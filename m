Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932582AbVLQOKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbVLQOKt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 09:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbVLQOKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 09:10:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58890 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932582AbVLQOKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 09:10:48 -0500
Date: Sat, 17 Dec 2005 15:10:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Gerhard Mack <gmack@innerfire.net>, wli@holomorphy.com,
       davem@davemloft.net, ecd@brainaid.de, jj@sunsite.ms.mff.cuni.cz,
       anton@samba.org
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [2.6 patch] on sparc{,64}, RTC must depend on PCI
Message-ID: <20051217141049.GP23349@stusta.de>
References: <Pine.LNX.4.64.0512160832350.995@innerfire.net> <20051216222154.GK23349@stusta.de> <Pine.LNX.4.64.0512161908460.20531@innerfire.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512161908460.20531@innerfire.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2005 at 07:10:05PM -0500, Gerhard Mack wrote:
> 
> I always forget that for some reason.
> If I disable CONFIG_RTC it compiles cleanly.

That's expected since this is the driver that breaks the build.

The patch below adds the dependency of CONFIG_RTC on CONFIG_PCI on the 
sparc architecture.

> 	Gerhard

cu
Adrian

BTW: @sparc maintainers:
     Is there any reason against introducing a SPARC Kconfig symbol
     that is set on both the sparc and sparc64 architectures?


<--  snip  -->


On sparc and sparc64, the rtc driver doesn't compile with PCI support 
disabled.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14.4/drivers/char/Kconfig.old	2005-12-17 15:03:06.000000000 +0100
+++ linux-2.6.14.4/drivers/char/Kconfig	2005-12-17 15:03:33.000000000 +0100
@@ -687,7 +687,7 @@
 
 config RTC
 	tristate "Enhanced Real Time Clock Support"
-	depends on !PPC32 && !PARISC && !IA64 && !M68K
+	depends on !PPC32 && !PARISC && !IA64 && !M68K && (!(SPARC32 || SPARC64) || PCI)
 	---help---
 	  If you say Y here and create a character special file /dev/rtc with
 	  major number 10 and minor number 135 using mknod ("man mknod"), you

