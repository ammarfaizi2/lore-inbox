Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311829AbSDXLbC>; Wed, 24 Apr 2002 07:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311834AbSDXLbB>; Wed, 24 Apr 2002 07:31:01 -0400
Received: from gherkin.frus.com ([192.158.254.49]:1664 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S311829AbSDXLbA>;
	Wed, 24 Apr 2002 07:31:00 -0400
Message-Id: <m170Kz0-0005kiC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: 2.5.9 -- Build error -- scsidrv.o: In function `ahc_linux_halt':
 undefined reference to `ahc_tailq'
In-Reply-To: <3CC5D19D.5000006@sgi.com> "from Stephen Lord at Apr 23, 2002 04:26:53
 pm"
To: Stephen Lord <lord@sgi.com>
Date: Wed, 24 Apr 2002 06:30:46 -0500 (CDT)
CC: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>,
        torvalds@transmeta.com
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord wrote:
> Miles Lane wrote:
> 
> >drivers/scsi/scsidrv.o: In function `ahc_linux_halt':
> >drivers/scsi/scsidrv.o(.text+0x78cd): undefined reference to `ahc_tailq'
> >drivers/scsi/scsidrv.o(.text+0x78e2): undefined reference to
> >`ahc_shutdown'
> >drivers/scsi/scsidrv.o: In function `ahc_linux_detect':
> >drivers/scsi/scsidrv.o(.text+0x7fb7): undefined reference to `ahc_tailq'
> >drivers/scsi/scsidrv.o: In function `ahc_linux_register_host':
> >drivers/scsi/scsidrv.o(.text+0x80c6): undefined reference to
> >`ahc_set_unit'
> >drivers/scsi/scsidrv.o(.text+0x8109): undefined reference to
> >`ahc_set_name'
> >
> >and so on.

The problem appears to be a couple of simple typos made by whoever
submitted the patch for linux/scsi/aic7xxx/Makefile.  Here's a quick
"counter"patch that fixed things for me...

--- linux/drivers/scsi/aic7xxx/Makefile.orig	Tue Apr 23 08:43:08 2002
+++ linux/drivers/scsi/aic7xxx/Makefile	Tue Apr 23 12:31:06 2002
@@ -8,7 +8,7 @@
 obj-$(CONFIG_SCSI_AIC7XXX)	+= aic7xxx_mod.o
 
 # Core files
-aix7xxx_mod-objs	+= aic7xxx.o aic7xxx_93cx6.o aic7770.o
+aic7xxx_mod-objs	+= aic7xxx.o aic7xxx_93cx6.o aic7770.o
 
 # Platform Specific Files
 aic7xxx_mod-objs	+= aic7xxx_linux.o aic7xxx_proc.o aic7770_linux.o
@@ -33,4 +33,4 @@
 aicasm/aicasm: aicasm/*.[chyl]
 	$(MAKE) -C aicasm
 
-aix7xxx_mod.o: aic7xxx_seq.h aic7xxx_reg.h
+aic7xxx_mod.o: aic7xxx_seq.h aic7xxx_reg.h

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
