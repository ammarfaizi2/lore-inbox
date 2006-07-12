Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750860AbWGLISI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWGLISI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWGLISH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:18:07 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:19584 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750860AbWGLISG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:18:06 -0400
Message-ID: <44B4B041.9050808@drzeus.cx>
Date: Wed, 12 Jul 2006 10:18:09 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hera.drzeus.cx-20416-1152692285-0001-2"
To: Greg KH <greg@kroah.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: resource_size_t and printk()
References: <44AAD59E.7010206@drzeus.cx> <20060704214508.GA23607@kroah.com> <44AB3DF7.8080107@drzeus.cx> <20060711231537.GC18973@kroah.com>
In-Reply-To: <20060711231537.GC18973@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-20416-1152692285-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Greg KH wrote:
> Good catch, care to create a patch to fix these?
>   

Included.

--=_hera.drzeus.cx-20416-1152692285-0001-2
Content-Type: text/x-patch; name="pnp-fixprintk.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pnp-fixprintk.patch"

[PNP] Add missing casts in printk() arguments

Some resource_size_t values are fed to printk() without handling the fact
that they can have different size depending on your .config.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/pnp/interface.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 3163e3d..0c14f4f 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -265,8 +265,8 @@ static ssize_t pnp_show_current_resource
 				pnp_printf(buffer," disabled\n");
 			else
 				pnp_printf(buffer," 0x%llx-0x%llx\n",
-						pnp_port_start(dev, i),
-						pnp_port_end(dev, i));
+					(long long)pnp_port_start(dev, i),
+					(long long)pnp_port_end(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_MEM; i++) {
@@ -276,8 +276,8 @@ static ssize_t pnp_show_current_resource
 				pnp_printf(buffer," disabled\n");
 			else
 				pnp_printf(buffer," 0x%llx-0x%llx\n",
-						pnp_mem_start(dev, i),
-						pnp_mem_end(dev, i));
+					(long long)pnp_mem_start(dev, i),
+					(long long)pnp_mem_end(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_IRQ; i++) {
@@ -287,7 +287,7 @@ static ssize_t pnp_show_current_resource
 				pnp_printf(buffer," disabled\n");
 			else
 				pnp_printf(buffer," %lld\n",
-						pnp_irq(dev, i));
+					(long long)pnp_irq(dev, i));
 		}
 	}
 	for (i = 0; i < PNP_MAX_DMA; i++) {
@@ -297,7 +297,7 @@ static ssize_t pnp_show_current_resource
 				pnp_printf(buffer," disabled\n");
 			else
 				pnp_printf(buffer," %lld\n",
-						pnp_dma(dev, i));
+					(long long)pnp_dma(dev, i));
 		}
 	}
 	ret = (buffer->curr - buf);

--=_hera.drzeus.cx-20416-1152692285-0001-2--
