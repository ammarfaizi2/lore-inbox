Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314835AbSGYP1E>; Thu, 25 Jul 2002 11:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSGYP1E>; Thu, 25 Jul 2002 11:27:04 -0400
Received: from [196.26.86.1] ([196.26.86.1]:52448 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S314835AbSGYP1D>; Thu, 25 Jul 2002 11:27:03 -0400
Date: Thu, 25 Jul 2002 17:47:50 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Samuel Thibault <samuel.thibault@fnac.net>
Cc: vojtech@suse.cz, <martin@dalecki.de>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <andre@linux-ide.org>
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
In-Reply-To: <Pine.LNX.4.10.10207251642490.935-100000@bureau.famille.thibault.fr>
Message-ID: <Pine.LNX.4.44.0207251744130.19117-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Samuel Thibault wrote:

>  static void qd_write_reg (byte content, byte reg)
>  {
>  	unsigned long flags;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> +	spin_lock_irqsave(&qd_iolock,flags);
>  	outb(content,reg);

Do we need a lock/cli for that one outb?

> +	spin_unlock_irqrestore(&qd_iolock,flags);

	Zwane

-- 
function.linuxpower.ca

