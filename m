Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUK2N7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUK2N7k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 08:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUK2N7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 08:59:40 -0500
Received: from aun.it.uu.se ([130.238.12.36]:4751 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261373AbUK2N7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 08:59:38 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16811.11073.511847.968733@alkaid.it.uu.se>
Date: Mon, 29 Nov 2004 14:59:29 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Pavel Machek <pavel@ucw.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1 broke apmd
In-Reply-To: <20041129125313.GB3291@elf.ucw.cz>
References: <200411291138.iATBcBiR007342@harpo.it.uu.se>
	<20041129125313.GB3291@elf.ucw.cz>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek writes:
 > Hi!
 > 
 > > Starting with 2.6.10-rc1, date and time on my old APM-based
 > > laptop is messed up after a resume. Specifically, Emacs and
 > > xclock both make a huge forward leap and then stop updating
 > > their current time displays.
 > > 
 > > The cause is the "jiffies += sleep_length * HZ;" addition
 > > to arch/i386/kernel/time.c:time_resume() which is in conflict
 > > with the hwlock --hctosys that the APM daemon normally does
 > > at resume.
 > 
 > I do not understand why they interfere... time_resume should fix
 > system time, then userland sets it to the right value, again. Unless
 > these two happen in paralel (they should not), nothing bad should happen.
 > 
 > Can you try to suspend, wait, launch hwclock --hctosys manually?

I disabled apmd's automatic hwlock --hctosys and ran it manually
after resume + 5 seconds: no problem. I suspect that apmd runs
really early at resume and that's why it interferes with time_resume.

/Mikael
