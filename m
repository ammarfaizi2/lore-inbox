Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030456AbWGNPJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030456AbWGNPJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 11:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWGNPJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 11:09:39 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:46781 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030456AbWGNPJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 11:09:38 -0400
Subject: Re: [PATCH] remove volatile from x86 cmos_lock
From: Steven Rostedt <rostedt@goodmis.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200607141653.35011.oliver@neukum.org>
References: <1152888523.27135.2.camel@localhost.localdomain>
	 <200607141653.35011.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 14 Jul 2006 11:09:25 -0400
Message-Id: <1152889765.27135.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 16:53 +0200, Oliver Neukum wrote:
> Am Freitag, 14. Juli 2006 16:48 schrieb Steven Rostedt:
> > @@ -52,14 +54,16 @@ static inline void lock_cmos(unsigned ch
> >  
> >  static inline void unlock_cmos(void)
> >  {
> > -       cmos_lock = 0;
> > +       set_wmb(cmos_lock, 0);
> >  }
> >  static inline int do_i_have_lock_cmos(void)
> >  {
> > +       barrier();
> 
> Shouldn't these be rmb() ?

I was thinking that too, but I'm still not sure when to use rmb or
barrier.  wmb seems pretty straight forward though.  hmm, maybe this
really should be a smb_rmb since I believe a barrier would be ok for UP.

-- Steve


