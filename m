Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbTGBMsf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:48:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264970AbTGBMsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:48:35 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:15822 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264973AbTGBMse (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:48:34 -0400
Date: Wed, 2 Jul 2003 15:02:58 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig allows LOG_BUF_SHIFT parameters that lead to disfunctional kernel
Message-ID: <20030702130258.GA14640@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[also sent to akpm in a separate message that was posted to
 'linus-kernel@vger.kernel.org by accident] 

Attached patch adds a range check to LOG_BUF_SHIFT and clarifies the
configuration somewhat. I managed to build a non-booting kernel because I
thought 64 was a nice power of two, which lead to the kernel blocking when
it tried to actually use or allocate a 2^64 buffer.

Please apply, would've saved me a few hours of debugging.

--- init/Kconfig~	2003-07-02 14:49:28.000000000 +0200
+++ init/Kconfig	2003-07-02 14:40:53.000000000 +0200
@@ -93,7 +93,8 @@
 	  limited in memory.
 
 config LOG_BUF_SHIFT
-	int "Kernel log buffer size" if DEBUG_KERNEL
+	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
+	range 12 20
 	default 17 if ARCH_S390
 	default 16 if X86_NUMAQ || IA64
 	default 15 if SMP



-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
