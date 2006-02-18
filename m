Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWBRCGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWBRCGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbWBRCGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:06:31 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35467 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750732AbWBRCGa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:06:30 -0500
Date: Fri, 17 Feb 2006 18:06:59 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
Message-ID: <20060218020659.GH1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru> <20060216192617.GF1296@us.ibm.com> <43F4E6EC.3B9F91C4@tv-sign.ru> <20060216195341.GG1296@us.ibm.com> <43F4EC88.D8B2DEE5@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4EC88.D8B2DEE5@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 12:20:08AM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > The other thing to think through is tkill on a thread/process while it
> > is being created.  I believe that this is OK, since thread-specific
> > kill must target a specific thread, so does not do the traversal.
> 
> Also, tkill was not converted to use rcu_read_lock yet, it still
> takes tasklist_lock, so I think it is safe.

I suspect that tkill will eventually need to avoid tasklist_lock...  ;-)

						Thanx, Paul
