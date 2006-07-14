Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945904AbWGNXWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945904AbWGNXWK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 19:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945905AbWGNXWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 19:22:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45218 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1945904AbWGNXWI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 19:22:08 -0400
Date: Fri, 14 Jul 2006 17:50:07 -0400
From: Dave Jones <davej@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from x86 cmos_lock
Message-ID: <20060714215007.GI24705@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Oliver Neukum <oliver@neukum.org>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <1152888523.27135.2.camel@localhost.localdomain> <200607141653.35011.oliver@neukum.org> <1152889765.27135.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1152889765.27135.6.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2006 at 11:09:25AM -0400, Steven Rostedt wrote:
 > On Fri, 2006-07-14 at 16:53 +0200, Oliver Neukum wrote:
 > > Am Freitag, 14. Juli 2006 16:48 schrieb Steven Rostedt:
 > > > @@ -52,14 +54,16 @@ static inline void lock_cmos(unsigned ch
 > > >  
 > > >  static inline void unlock_cmos(void)
 > > >  {
 > > > -       cmos_lock = 0;
 > > > +       set_wmb(cmos_lock, 0);
 > > >  }
 > > >  static inline int do_i_have_lock_cmos(void)
 > > >  {
 > > > +       barrier();
 > > 
 > > Shouldn't these be rmb() ?
 > 
 > I was thinking that too, but I'm still not sure when to use rmb or
 > barrier.  wmb seems pretty straight forward though.  hmm, maybe this
 > really should be a smb_rmb since I believe a barrier would be ok for UP.

I'm more puzzled why it's inventing its own locking primitives instead of
using one of the many the kernel provides.  This stuff is prehistoric though.
Hangover from the really early days ?

		Dave

-- 
http://www.codemonkey.org.uk
