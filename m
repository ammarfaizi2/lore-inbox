Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314491AbSFQPw0>; Mon, 17 Jun 2002 11:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314500AbSFQPwZ>; Mon, 17 Jun 2002 11:52:25 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:7888 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314491AbSFQPwZ>; Mon, 17 Jun 2002 11:52:25 -0400
Date: Mon, 17 Jun 2002 10:52:20 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 broke modversions
In-Reply-To: <3D0E02C2.5010304@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0206171050320.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Martin Dalecki wrote:

> The following diff clutter appears in every diff after make menuconfig
> 
> diff -urN linux-2.5.21/scripts/lxdialog/.checklist.o.cmd 
> linux/scripts/lxdialog/.checklist.o.cmd
> [..]

Ah, okay. We don't remove .*.cmd in scripts/dialog on make clean, since
we want lxdialog to survive the make clean. Unfortunately, that means
we didn't remove those at all.

--Kai


===== Makefile 1.265 vs edited =====
--- 1.265/Makefile	Mon Jun 17 10:26:40 2002
+++ edited/Makefile	Mon Jun 17 10:49:48 2002
@@ -622,7 +622,8 @@
 
 mrproper: clean archmrproper
 	@echo 'Making mrproper'
-	@find . \( -size 0 -o -name .depend \) -type f -print | xargs rm -f
+	@find . \( -size 0 -o -name .depend -o -name .\*.cmd \) \
+		   -type f -print | xargs rm -f
 	@rm -f $(MRPROPER_FILES)
 	@rm -rf $(MRPROPER_DIRS)
 	@$(MAKE) -C Documentation/DocBook mrproper

