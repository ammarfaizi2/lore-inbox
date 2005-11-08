Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVKHX2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVKHX2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 18:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVKHX2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 18:28:53 -0500
Received: from [85.8.13.51] ([85.8.13.51]:20888 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932391AbVKHX2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 18:28:52 -0500
Message-ID: <437134AE.5060303@drzeus.cx>
Date: Wed, 09 Nov 2005 00:28:46 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.5 (X11/20051105)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hermes.drzeus.cx-23725-1131492526-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MMC] Use __devexit_p in wbsd
References: <20051107070458.6640.83631.stgit@poseidon.drzeus.cx> <20051108231809.GG13357@flint.arm.linux.org.uk>
In-Reply-To: <20051108231809.GG13357@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hermes.drzeus.cx-23725-1131492526-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Russell King wrote:
> On Mon, Nov 07, 2005 at 08:04:59AM +0100, Pierre Ossman wrote:
>> wbsd_*_remove() is declared as __devexit but __devexit_p isn't used
>> when taking their addresses.
> 
> This patch has been generated assuming that your PNP suspend/resume
> patches are in... what do you want me to do with this?  Wait for
> the PNP patches to hit mainline, or...?
> 

Sorry about that. Improper patch ordering on my part. Here's one where 
it's applied before the suspend stuff.

Rgds
Pierre


--=_hermes.drzeus.cx-23725-1131492526-0001-2
Content-Type: text/x-patch; name="wbsd-devexitp.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wbsd-devexitp.patch"

[MMC] Use __devexit_p in wbsd

wbsd_*_remove() is declared as __devexit but __devexit_p isn't used
when taking their addresses.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -2042,7 +2042,7 @@ static struct device_driver wbsd_driver 
 	.name		= DRIVER_NAME,
 	.bus		= &platform_bus_type,
 	.probe		= wbsd_probe,
-	.remove		= wbsd_remove,
+	.remove		= __devexit_p(wbsd_remove),
 
 	.suspend	= wbsd_suspend,
 	.resume		= wbsd_resume,
@@ -2054,7 +2054,7 @@ static struct pnp_driver wbsd_pnp_driver
 	.name		= DRIVER_NAME,
 	.id_table	= pnp_dev_table,
 	.probe		= wbsd_pnp_probe,
-	.remove		= wbsd_pnp_remove,
+	.remove		= __devexit_p(wbsd_pnp_remove),
 };
 
 #endif /* CONFIG_PNP */

--=_hermes.drzeus.cx-23725-1131492526-0001-2--
