Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSGYRYZ>; Thu, 25 Jul 2002 13:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315491AbSGYRYZ>; Thu, 25 Jul 2002 13:24:25 -0400
Received: from smtp.9tel.net ([213.203.124.147]:52201 "HELO smtp4.9tel.net")
	by vger.kernel.org with SMTP id <S315485AbSGYRYZ>;
	Thu, 25 Jul 2002 13:24:25 -0400
Date: Thu, 25 Jul 2002 19:26:10 +0200 (CEST)
From: Samuel Thibault <samuel.thibault@fnac.net>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: vojtech@suse.cz, martin@dalecki.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, andre@linux-ide.org
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
In-Reply-To: <Pine.LNX.4.44.0207251744130.19117-100000@linux-box.realnet.co.sz>
Message-ID: <Pine.LNX.4.10.10207251915420.1532-100000@bureau.famille.thibault.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Jul 2002, Zwane Mwaikambo wrote:

> On Thu, 25 Jul 2002, Samuel Thibault wrote:
> 
> >  static void qd_write_reg (byte content, byte reg)
> >  {
> >  	unsigned long flags;
> >  
> > -	save_flags(flags);	/* all CPUs */
> > -	cli();			/* all CPUs */
> > +	spin_lock_irqsave(&qd_iolock,flags);
> >  	outb(content,reg);
> 
> Do we need a lock/cli for that one outb?
> 
> > +	spin_unlock_irqrestore(&qd_iolock,flags);

Well, I put it since many ide chipset drivers put it, but we may indeed
get rid of it, provided the board isn't upset when parallel selectprocing
/ tuning on ide0 and ide1. I won't be able to test before September.

Oh, btw, I only use one spinlock for timing computing, while there could
be one per QD channel, which would speed up tunig :o)

-- 
Samuel Thibault <samuel.thibault@fnac.net>
Hi ! I'm a .signature virus ! Copy me into your ~/.signature, please !

