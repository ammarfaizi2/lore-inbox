Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbUKVQa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbUKVQa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUKVQ3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:29:36 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64783 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262156AbUKVPv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 10:51:27 -0500
Date: Mon, 22 Nov 2004 16:51:23 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Michael Hunold <hunold@linuxtv.org>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [patch] 2.6.10-rc2-mm3: DVB: philips_tdm1316l_config multiple definition
Message-ID: <20041122155123.GE19419@stusta.de>
References: <20041121223929.40e038b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041121223929.40e038b2.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 21, 2004 at 10:39:29PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc2-mm2:
>...
> +dvb-follow-frontend-changes-in-drivers.patch
>...
> +dvb-follow-changes-in-dvb-ttpci-and-budget-drivers.patch
> 
>  Big DVB update
>...

<--  snip  -->

...
  LD      drivers/media/dvb/built-in.o
drivers/media/dvb/ttusb-budget/built-in.o(.data+0x3364): multiple 
definition of `philips_tdm1316l_config'
drivers/media/dvb/ttpci/built-in.o(.data+0x8c8): first defined here
make[3]: *** [drivers/media/dvb/built-in.o] Error 1

<--  snip  -->


Since none of them has a good reason for being global, the patch below 
makes both static.


diffstat output:
 drivers/media/dvb/ttpci/budget-ci.c               |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/media/dvb/ttpci/budget-ci.c.old	2004-11-22 14:48:33.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/media/dvb/ttpci/budget-ci.c	2004-11-22 14:48:45.000000000 +0100
@@ -840,7 +840,7 @@
 	return request_firmware(fw, name, &budget_ci->budget.dev->pci->dev);
 }
 
-struct tda1004x_config philips_tdm1316l_config = {
+static struct tda1004x_config philips_tdm1316l_config = {
 
 	.demod_address = 0x8,
 	.invert = 0,
--- linux-2.6.10-rc2-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c.old	2004-11-22 14:48:59.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c	2004-11-22 14:49:08.000000000 +0100
@@ -1190,7 +1190,7 @@
 	return request_firmware(fw, name, &ttusb->dev->dev);
 }
 
-struct tda1004x_config philips_tdm1316l_config = {
+static struct tda1004x_config philips_tdm1316l_config = {
 
 	.demod_address = 0x8,
 	.invert = 1,

