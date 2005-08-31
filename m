Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVHaPny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVHaPny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbVHaPnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:43:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:44300 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964841AbVHaPnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:43:53 -0400
Date: Wed, 31 Aug 2005 17:43:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Krufky <mkrufky@m1k.net>
Cc: stable@kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       linux-dvb-maintainer@linuxtv.org, torvalds@osdl.org
Subject: [2.6 patch] add missing select's to DVB_BUDGET_AV
Message-ID: <20050831154350.GB8638@stusta.de>
References: <4314B7C2.2080705@m1k.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4314B7C2.2080705@m1k.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 03:47:14PM -0400, Michael Krufky wrote:

> I wish I had seen this before 2.6.13 was released... I guess this only 
> goes to show that there haven't been any testers using saa7134-hybrid 
> dvb/v4l boards that depend on the tda1004x module, during the 2.6.13-rc 
> series :-(
> 
> Please apply this to 2.6.14, and also to 2.6.13.1 -stable.  Without this 
> patch, users will have to EXPLICITLY select tda1004x in Kconfig.  This 
> SHOULD be done automatically when saa7134-dvb is selected.  This patch 
> corrects this problem.
>...

What about the patch below fixing the following similar problems in 
drivers/media/dvb/ttpci/budget-ci.c ?

cu
Adrian


<--  snip  -->



Add missing select's to DVB_BUDGET_AV fixing the following compile 
error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
drivers/built-in.o: In function `frontend_init':
budget-av.c:(.text+0xb9448): undefined reference to `tda10046_attach'
budget-av.c:(.text+0xb9518): undefined reference to `tda10021_attach'
drivers/built-in.o: In function `philips_tu1216_request_firmware':
budget-av.c:(.text+0xb937b): undefined reference to `request_firmware'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13/drivers/media/dvb/ttpci/Kconfig.old	2005-08-31 17:36:33.000000000 +0200
+++ linux-2.6.13/drivers/media/dvb/ttpci/Kconfig	2005-08-31 17:39:57.000000000 +0200
@@ -99,12 +99,15 @@
 config DVB_BUDGET_AV
 	tristate "Budget cards with analog video inputs"
 	depends on DVB_CORE && PCI
 	select VIDEO_DEV
 	select VIDEO_SAA7146_VV
 	select DVB_STV0299
+	select DVB_TDA1004X
+	select DVB_TDA10021
+	select FW_LOADER
 	help
 	  Support for simple SAA7146 based DVB cards
 	  (so called Budget- or Nova-PCI cards) without onboard
 	  MPEG2 decoder, but with one or more analog video inputs.
 
 	  Say Y if you own such a card and want to use it.

