Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRHBL5d>; Thu, 2 Aug 2001 07:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbRHBL5N>; Thu, 2 Aug 2001 07:57:13 -0400
Received: from [193.45.212.82] ([193.45.212.82]:60932 "EHLO levi.aronsson.se")
	by vger.kernel.org with ESMTP id <S268900AbRHBL5D>;
	Thu, 2 Aug 2001 07:57:03 -0400
Date: Thu, 2 Aug 2001 13:57:27 +0200
Message-Id: <200108021157.f72BvRh01898@levi.aronsson.se>
From: Lars Aronsson <lars@aronsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Subject: Oops in dmi_table() from Linux 2.4.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I tried to compile and boot a fresh linux-2.4.7 kernel, and I got an
"Unable to handle kernel paging request" during boot, at EIP
0010:[<c02491d1>].  The docs tell me to run "nm vmlinux" to find the
address, but I didn't get this to work on my "bzImage", so instead I
looked in System.map, which indicates the problem is in dmi_table():

    c0249090 t winchip_mcheck_init
    c02490cc T mcheck_init
    c0249110 t mcheck_disable
    c0249120 t dmi_string
    c0249160 t dmi_table
    c0249210 T dmi_iterate
    c02492f0 t dmi_save_ident
    c024936c t disable_ide_dma

The "Call Trace: [<c0105037>][<c0105454>]" seems to indicate init()
and kernel_thread(), respectively, which I geuss is not very helpful.

dmi_table() is in arch/i386/kernel/dmi_scan.c which was not present in
my old 2.2.16 kernel.  The file doesn't have any comments indicating
who wrote it.

Hope you can use this for something.  Will you be helped if I enable
dmi_printk() and try this again?

This happened on a Toshiba Portege 7020CT with a Pentium II processor.


Lars Aronsson.
-- 
  Aronsson Datateknik
  Teknikringen 1e              tel +46-70-7891609     lars@aronsson.se
  SE-583 30 Linköping, Sweden  fax +46-13-211820    http://aronsson.se
