Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262677AbTCJAEk>; Sun, 9 Mar 2003 19:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262678AbTCJAEk>; Sun, 9 Mar 2003 19:04:40 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:45322
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262677AbTCJAEj>; Sun, 9 Mar 2003 19:04:39 -0500
Subject: Re: [PATCH] small fixes in brlock.h
From: Robert Love <rml@tech9.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303091843250.1464-100000@montezuma.mastecende.com>
Content-Type: text/plain
Organization: 
Message-Id: <1047255325.680.22.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 09 Mar 2003 19:15:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 18:44, Zwane Mwaikambo wrote:

>  #define br_read_unlock_irqrestore(idx, flags) \
> -	do { br_read_unlock(irx); local_irq_restore(flags); } while (0)
> +	do { br_read_unlock(idx); local_irq_restore(flags); } while (0)

BTW, I am amazed all these s/idx/irx/ bugs exist and no one noticed
them.

I guess nothing uses these irq variants.  In fact, grepping the
source... wow, not much uses brlocks at all.  Only registered lock is
BR_NETPROTO_LOCK.  A read lock on it is called only 7 times and a write
lock is used 31 times.

Everything must of moved over to using RCU or something.  It makes me
question the future of these things.

	Robert Love

