Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVCXPWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVCXPWT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 10:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262798AbVCXPWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 10:22:19 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:46809 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262558AbVCXPTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 10:19:16 -0500
Message-ID: <4242DA5A.4020904@ens-lyon.org>
Date: Thu, 24 Mar 2005 16:18:50 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Stefano Rivoir <s.rivoir@gts.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.12-rc1-mm2
References: <20050324044114.5aa5b166.akpm@osdl.org> <200503241540.33012.s.rivoir@gts.it>
In-Reply-To: <200503241540.33012.s.rivoir@gts.it>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano Rivoir a écrit :
> Alle 13:41, giovedì 24 marzo 2005, Andrew Morton ha scritto:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>>6.12-rc1-mm2/
> 
> 
>>- Some fixes for the recent DRM problems.
> 
> 
> Hi Andrew,
> 
> While I was OK with DRM up to 2.6.12-rc1-mm1, now I get this at startup, and 
> Xorg fails to enable DRI (attached, lspci and .config):

Same problem on my Radeon M6 LY here.
This seems to be due to agp_find_bridge not being exported anymore
in agp_backend.h. Dave might have forgotten it when reworking my patch.
Patch attached.

Brice


Signoff-by: Brice Goglin <Brice.Goglin@ens-lyon.org>


--- linux-mm/include/linux/agp_backend.h.old    2005-03-24 
16:17:25.000000000 +0100
+++ linux-mm/include/linux/agp_backend.h        2005-03-24 
16:10:25.000000000 +0100
@@ -100,6 +100,7 @@
  extern int agp_bind_memory(struct agp_memory *, off_t);
  extern int agp_unbind_memory(struct agp_memory *);
  extern void agp_enable(struct agp_bridge_data *, u32);
+extern struct agp_bridge_data * (*agp_find_bridge)(struct pci_dev *);
  extern struct agp_bridge_data *agp_backend_acquire(struct pci_dev *);
  extern void agp_backend_release(struct agp_bridge_data *);

