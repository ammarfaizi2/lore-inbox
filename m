Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130367AbQLQLDM>; Sun, 17 Dec 2000 06:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130899AbQLQLDC>; Sun, 17 Dec 2000 06:03:02 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12051 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130367AbQLQLC4>;
	Sun, 17 Dec 2000 06:02:56 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: Rasmus Andersen <rasmus@jaquet.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] link time error in drivers/mtd (240t13p2) 
In-Reply-To: Your message of "Sun, 17 Dec 2000 10:01:07 -0000."
             <Pine.LNX.4.30.0012170959580.14423-100000@imladris.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Dec 2000 21:32:24 +1100
Message-ID: <1875.977049144@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2000 10:01:07 +0000 (GMT), 
David Woodhouse <dwmw2@infradead.org> wrote:
>On Sun, 17 Dec 2000, Keith Owens wrote:
>
>> Somebody changed include/linux/mtd/map.h between 2.4.0-test11 and
>> test12.  That change is wrong, it adds conditional complexity where it
>> is not required - inter_module_xxx works even without CONFIG_MODULES.
>> cfi_probe should still be static.
>
>No. Think about the link order. inter_module_xxx doesn't work reliably.
>get_module_symbol() did.

Messing about with conditional compilation because the link order is
incorrect is the wrong fix.  The mtd/Makefile must link the objects in
the correct order.

cfi_probe.o needs to come after cfi_cmdset_000?.o.
doc_probe.o needs to come after doc200?.o.
nora.o, octagon-5066.o, physmap.o, rpxlite.o, vmax301.o, pnc2000.o need
to come after cfi_probe.o.
octagon-5066.o, vmax301.o need to come after jedec.o.
octagon-5066.o, vmax301.o need to come after map_ram.o.
octagon-5066.o, vmax301.o need to come after map_rom.o.

2.4.0-test13-pre2 almost does that, the only obvious problem is that
cfi_probe appears before cfi_cmdset.  Move cfi_probe to link after
cfi_cmdset, do you still get link order problems with the 2.4.0-test11
version of include/linux/mtd.h?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
