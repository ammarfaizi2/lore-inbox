Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263000AbUJ1MhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUJ1MhT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbUJ1MhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:37:19 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:31219 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S262988AbUJ1Mf3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:35:29 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: Re: wd module doesn't work in 2.4 and 2.6 ???
Date: Thu, 28 Oct 2004 14:35:22 +0200
User-Agent: KMail/1.6.2
References: <200410281346.32206.cijoml@volny.cz>
In-Reply-To: <200410281346.32206.cijoml@volny.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200410281435.22250.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It look like that check for my card never goes into

                } else {
                        int tmp = inb(ioaddr+1); /* fiddle with 16bit bit */
                        outb( tmp ^ 0x01, ioaddr+1 ); /* attempt to clear 
16bit bit */
                        if (((inb( ioaddr+1) & 0x01) == 0x01) /* A 16 bit card 
*/
                                && (tmp & 0x01) == 0x01 ) 
{                             /* In a 16 slot. */
                                int asic_reg5 = inb(ioaddr+WD_CMDREG5);
                                /* Magic to set ASIC to word-wide mode. */
                                outb( NIC16 | (asic_reg5&0x1f), 
ioaddr+WD_CMDREG5);
                                outb(tmp, ioaddr+1);
                                model_name = "WD8013";
                                word16 = 1;             /* We have a 16bit 
board here! */


in wd.c source

Michal

Dne èt 28. øíjna 2004 13:46 Michal Semler napsal(a):
> Hi guys,
>
> I have an old SMC card named SMC EtherCard Plus Elite 16 Combo (WD 8013EW
> or 8013EWC)
>
> it should work with module wd.
>
> Under win95 :) it works great with
>
> io=0x300 irq=15 mem=0xc8000 mem_end=0xcvfff
>
> When I modprobe wd with these params, both 2.4 and 2.6 kernels tells me
>
> No wd80x3 card found (io=0x300)
>
> PLS help me. Where is problem???
>
> Michal
