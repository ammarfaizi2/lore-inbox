Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318970AbSH1VRL>; Wed, 28 Aug 2002 17:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318972AbSH1VRL>; Wed, 28 Aug 2002 17:17:11 -0400
Received: from ip68-4-60-172.pv.oc.cox.net ([68.4.60.172]:46145 "EHLO
	siamese.dyndns.org") by vger.kernel.org with ESMTP
	id <S318970AbSH1VRL>; Wed, 28 Aug 2002 17:17:11 -0400
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au
Subject: [TRIVIAL] aic7xxx/Makefile fix
From: junio@siamese.dyndns.org
Date: 28 Aug 2002 14:21:27 -0700
Message-ID: <7vit1ullwo.fsf@siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch against 2.4.19.  If you are in a (good) habit of making
all the upstream sources read-only before starting your build,
generation of the firmware code fails because it tries to write
into read-only files.  This bites only in configurations where
CONFIG_AIC7XXX_BUILD_FIRMWARE is set to 'y'. 

--- 2.4.19/drivers/scsi/aic7xxx/Makefile	2002-08-02 10:48:53.000000000 -0700
+++ 2.4.19/drivers/scsi/aic7xxx/Makefile	2002-08-28 14:14:31.000000000 -0700
@@ -39,6 +39,7 @@
 $(obj-aic7xxx): aic7xxx_reg.h
 
 aic7xxx_seq.h aic7xxx_reg.h: aic7xxx.seq aic7xxx.reg aicasm/aicasm
+	rm -f aic7xxx_seq.h aic7xxx_reg.h
 	aicasm/aicasm -I. -r aic7xxx_reg.h -o aic7xxx_seq.h aic7xxx.seq
 endif
