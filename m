Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265912AbTL3XZN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265929AbTL3XZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 18:25:13 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:17924 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S265912AbTL3XY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 18:24:59 -0500
From: Willem <wdit@xs4all.nl>
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Patch (fix for libata patch 2.6.0-1) in ata_std_bio_param 
Date: Wed, 31 Dec 2003 00:24:08 +0100
User-Agent: KMail/1.5.4
Organization: WD-IT
Cc: matic@cyberia.net.lb, slaugther@linux.nu
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312310024.08393.wdit@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following problem when compiling linux 2.6.0 + 2.6.0libata1 patch. 
(On a recent Intel motherboard with SATA, so I applied the libata patch.) 

Since I noticed this problem at the Gentoo bugs site as well 
( http://bugs.gentoo.org/show_bug.cgi?id=36812 )
I decided to publish this patch, to help others. 

 LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xa7784): In function `ata_std_bios_param':
: undefined reference to `__udivdi3'
make: *** [.tmp_vmlinux1] Error 1
* gen_die(): Could not copy kernel binary to boot

The following patch fixes this. 
Best regards, and happy 2004!

Willem Dekker 

---- 
*** libata-scsi.c       2003-12-31 00:17:14.000000000 +0100
--- libata-scsi.org     2003-12-31 00:17:59.000000000 +0100
***************
*** 49,55 ****
  {
        geom[0] = 255;
        geom[1] = 63;
!       geom[2] = (int) capacity /(int) (geom[0] * geom[1]);

        return 0;
  }
--- 49,55 ----
  {
        geom[0] = 255;
        geom[1] = 63;
!       geom[2] =  capacity / (geom[0] * geom[1]);

        return 0;
  }

