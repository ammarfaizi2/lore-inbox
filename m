Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270772AbRIGBhj>; Thu, 6 Sep 2001 21:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270787AbRIGBh3>; Thu, 6 Sep 2001 21:37:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34820 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270772AbRIGBhK>; Thu, 6 Sep 2001 21:37:10 -0400
Subject: Re: [patch] proposed fix for ptrace() SMP race
To: andrea@suse.de (Andrea Arcangeli)
Date: Fri, 7 Sep 2001 02:41:11 +0100 (BST)
Cc: davidm@hpl.hp.com (David Mosberger), linux-kernel@vger.kernel.org
In-Reply-To: <20010907032801.N11329@athlon.random> from "Andrea Arcangeli" at Sep 07, 2001 03:28:01 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15fAdr-0000r7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#ifdef CONFIG_SMP
> +	rmb(); /* read child->has_cpu after child->state */
> +	while (child->has_cpu);
		rep_nop();

otherwise your PIV will overheat
