Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbVJYTlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbVJYTlK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 15:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbVJYTlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 15:41:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31126 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932332AbVJYTlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 15:41:09 -0400
Date: Tue, 25 Oct 2005 21:08:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: sharp zaurus: prevent killing spitz-en
Message-ID: <20051025190829.GA1788@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is wrong solution, but it prevents breaking flashing mechanism on
spitz with too big kernel. It may be handy to someone...

								Pavel

--- clean-rp/arch/arm/boot/Makefile	2004-12-25 13:34:57.000000000 +0100
+++ linux-rp/arch/arm/boot/Makefile	2005-10-25 20:43:58.000000000 +0200
@@ -53,6 +53,12 @@
 $(obj)/zImage:	$(obj)/compressed/vmlinux FORCE
 	$(call if_changed,objcopy)
 	@echo '  Kernel: $@ is ready'
+	@ls -al $@
+	@wc -c $@ | ( read SIZE Y; \
+		if [ $$SIZE -gt 1294336 ]; then \
+			echo '  Kernel is too big, would kill spitz'; \
+			rm $@; \
+		fi )
 
 endif
 



-- 
Thanks, Sharp!
