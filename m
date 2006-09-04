Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWIDLln@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWIDLln (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWIDLlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:41:42 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25354 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964798AbWIDLlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:41:25 -0400
Date: Mon, 4 Sep 2006 13:41:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Miller <davem@davemloft.net>
Cc: hch@infradead.org, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/wd33c93.c: cleanups
Message-ID: <20060904114122.GM4416@stusta.de>
References: <20060821104357.GH11651@stusta.de> <20060821105344.GA28759@infradead.org> <20060821192215.GL11651@stusta.de> <20060821.123142.08327833.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060821.123142.08327833.davem@davemloft.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2006 at 12:31:42PM -0700, David Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Mon, 21 Aug 2006 21:22:15 +0200
> 
> > On Mon, Aug 21, 2006 at 11:53:44AM +0100, Christoph Hellwig wrote:
> > > On Mon, Aug 21, 2006 at 12:43:57PM +0200, Adrian Bunk wrote:
> > > > This patch contains the following cleanups:
> > > > - #include <linux/irq.h> for getting the prototypes of
> > > >   {dis,en}able_irq()
> > > 
> > > nothing outside of arch code must ever include <linux/irq.h>
> > 
> > Why?
> > It sounds rather strange that non-arch code should use asm headers.
> 
> It's an unfortunate side effect of how the generic IRQ layer was done.
> 
> The linux/irq.h head should only be used on platforms that make use of
> the generic IRQ layer.
> 
> asm/irq.h is what should be included by drivers and the like that want
> the IRQ interfaces.
> 
> I'm not saying this is a good situation, it's just the way it is.

What a mess...

Updated patch below.

cu
Adrian


<--  snip  -->


This patch contains the following cleanups:
- #include <asm/irq.h> for getting the prototypes of
  {dis,en}able_irq()
- make the needlessly global wd33c93_setup() static

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc5-mm1/drivers/scsi/wd33c93.c.old	2006-09-04 01:45:57.000000000 +0200
+++ linux-2.6.18-rc5-mm1/drivers/scsi/wd33c93.c	2006-09-04 01:46:26.000000000 +0200
@@ -85,6 +85,8 @@
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
 
+#include <asm/irq.h>
+
 #include "wd33c93.h"
 
 
@@ -1710,7 +1712,7 @@
 static char setup_used[MAX_SETUP_ARGS];
 static int done_setup = 0;
 
-int
+static int
 wd33c93_setup(char *str)
 {
 	int i;


-- 
VGER BF report: H 0.177864
