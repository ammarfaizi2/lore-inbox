Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293181AbSCTAH4>; Tue, 19 Mar 2002 19:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293164AbSCTAHg>; Tue, 19 Mar 2002 19:07:36 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293181AbSCTAH0>; Tue, 19 Mar 2002 19:07:26 -0500
Subject: Re: [PATCH] 2.4 and 2.5: remove Alt-Sysrq-L
To: kasperd@daimi.au.dk (Kasper Dupont)
Date: Wed, 20 Mar 2002 00:22:37 +0000 (GMT)
Cc: rmk@arm.linux.org.uk (Russell King),
        linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <3C97ADD8.71408946@daimi.au.dk> from "Kasper Dupont" at Mar 19, 2002 10:30:00 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nTsD-0000lv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		panic("Attempted to kill init!");
> +	if (tsk->pid == 1) {
> +		printk(KERN_EMERG "Attempted to kill init!\n");
> +		flush_child_loop(tsk);
> +	}

This can occur in IRQ path - your code won't handle that. Otherwise it
seems to have potential
