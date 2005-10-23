Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbVJWQh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVJWQh0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 12:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbVJWQh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 12:37:26 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:54677 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1750767AbVJWQhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 12:37:25 -0400
Message-ID: <435BBF60.EB3DD2C2@tv-sign.ru>
Date: Sun, 23 Oct 2005 20:50:40 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, mingo@elte.hu,
       roland@redhat.com, george@mvista.com, linux-kernel@vger.kernel.org,
       rostedt@goodmis.org, paulmck@us.ibm.com
Subject: Re: [PATCH] fix exit_itimers() vs posix_timer_event() AB-BAdeadlock
References: <20050818060126.GA13152@elte.hu>
			<1124495303.23647.579.camel@tglx.tec.linutronix.de>
			<43076138.C37ED380@tv-sign.ru>
			<1124617458.23647.643.camel@tglx.tec.linutronix.de>
			<43085E97.4EC3908B@tv-sign.ru>
			<1124659468.23647.695.camel@tglx.tec.linutronix.de>
			<1124661032.23647.698.camel@tglx.tec.linutronix.de>
			<4309731E.ED621149@tv-sign.ru>
			<1124698127.23647.716.camel@tglx.tec.linutronix.de>
			<43099235.65BC4757@tv-sign.ru>
			<1124705208.23647.737.camel@tglx.tec.linutronix.de>
			<430A012E.1CAF0A2F@tv-sign.ru>
			<1124791998.23647.789.camel@tglx.tec.linutronix.de>
			<430B4C35.AE7CD179@tv-sign.ru>
			<433557BB.EE6E5FE5@tv-sign.ru> <20050924224449.30582f70.akpm@osdl.org> <4336AF05.DFB5B611@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> Andrew Morton wrote:
> >
> > Oleg Nesterov <oleg@tv-sign.ru> wrote:
> > >
> > > +     /*
> > >  +     * We are locking ->it_lock + tasklist_lock backwards
> > >  +     * from release_task()->exit_itimers(), beware deadlock.
> > >  +     */
> > >  +    leader = timr->it_process->group_leader;
> > >  +    while (unlikely(!read_trylock(&tasklist_lock))) {
> > >  +            if (leader->flags & PF_EXITING) {
> > >  +                    smp_rmb();
> > >  +                    if (thread_group_empty(leader))
> > >  +                            return 0;
> > >  +            }
> > >  +            cpu_relax();
> > >  +    }
> >
> > Oh dear.  Is there no way to fix this up by taking the locks in the correct
> > order?  (Whatever that is).

Andrew, please drop this patch. It is obsoleted by Roland's
"[PATCH] Call exit_itimers from do_exit, not __exit_signal".

Oleg.
