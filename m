Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269483AbUIRN2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269483AbUIRN2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 09:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269491AbUIRN2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 09:28:20 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:59149 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269483AbUIRN2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 09:28:18 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Mikael Pettersson <mikpe@csd.uu.se>, R.E.Wolff@BitWizard.nl, akpm@osdl.org
Subject: Re: [PATCH][2.6.9-rc2] Specialix RIO driver gcc-3.4 fixes
Date: Sat, 18 Sep 2004 16:28:10 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200409181242.i8ICg0c9006579@harpo.it.uu.se>
In-Reply-To: <200409181242.i8ICg0c9006579@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409181628.10896.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 September 2004 15:42, Mikael Pettersson wrote:
> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.6.9-rc2
> kernel's Specialix RIO driver. This is a forward port of the fix
> I made for the 2.4 kernel.
> 
> /Mikael
> 
> --- linux-2.6.9-rc2/drivers/char/rio/rio_linux.c.~1~	2004-03-11 14:01:27.000000000 +0100
> +++ linux-2.6.9-rc2/drivers/char/rio/rio_linux.c	2004-09-18 14:27:33.000000000 +0200
> @@ -1139,7 +1139,7 @@
>        if (((1 << hp->Ivec) & rio_irqmask) == 0)
>                hp->Ivec = 0;
>        hp->CardP	= (struct DpRam *)
> -      hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
> +      (hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN));

I think it's best to untangle assignments, it's easier to read this way:

	hp->Caddr = ioremap(p->RIOHosts[p->RIONumHosts].PaddrP, RIO_WINDOW_LEN);
	hp->CardP = (struct DpRam *) hp->Caddr;
--
vda

