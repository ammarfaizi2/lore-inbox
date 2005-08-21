Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbVHUMiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbVHUMiZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 08:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbVHUMiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 08:38:25 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:57297
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1750984AbVHUMiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 08:38:24 -0400
Subject: Re: [PATCH] fix send_sigqueue() vs thread exit race
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       George Anzinger <george@mvista.com>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43085A6E.C7D249F0@tv-sign.ru>
References: <20050818060126.GA13152@elte.hu>
	 <1124495303.23647.579.camel@tglx.tec.linutronix.de>
	 <43076138.C37ED380@tv-sign.ru>
	 <1124617458.23647.643.camel@tglx.tec.linutronix.de>
	 <43085A6E.C7D249F0@tv-sign.ru>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 21 Aug 2005 14:38:55 +0200
Message-Id: <1124627935.23647.652.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-21 at 14:41 +0400, Oleg Nesterov wrote:
> If not:
> 
> >  timer event
> >         timr->it_process references a freed structure
> > 
> 
> No, create_timer() does get_task_struct(timr->it_process), this
> task may be EXIT_DEAD now, but the task_struct itself is valid,
> and it's ->flags has PF_EXITING flag.

Right, did not think about that.

tglx


