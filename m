Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbSKYQ4G>; Mon, 25 Nov 2002 11:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbSKYQ4G>; Mon, 25 Nov 2002 11:56:06 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21230 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261593AbSKYQ4E>; Mon, 25 Nov 2002 11:56:04 -0500
Subject: Re: [BUG] 2.4.20-rc2-ac3 oops (causer is DRM 4.3.x code)
From: Arjan van de Ven <arjanv@redhat.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@nl.linux.org>
In-Reply-To: <200211251711.59882.m.c.p@wolk-project.de>
References: <200211251711.59882.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Nov 2002 18:02:27 +0100
Message-Id: <1038243747.1372.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-25 at 17:12, Marc-Christian Petersen wrote:
> Hi Alan, Hi Arjan,
> 

@ -622,16 +615,20 @@
        if ( dev->dev_private ) {
                drm_r128_private_t *dev_priv = dev->dev_private;

+#if __REALLY_HAVE_SG
                if ( !dev_priv->is_pci ) {
+#endif
                        DRM_IOREMAPFREE( dev_priv->cce_ring );
                        DRM_IOREMAPFREE( dev_priv->ring_rptr );
                        DRM_IOREMAPFREE( dev_priv->buffers );
+#if __REALLY_HAVE_SG
                } else {
                        if (!DRM(ati_pcigart_cleanup)( dev,
                                                dev_priv->phys_pci_gart,
                                                dev_priv->bus_pci_gart
))
                                DRM_ERROR( "failed to cleanup PCI
GART!\n" );
                }
+#endif
 

is the only worthy change to drivers/char/drm/r128_cce.c that I can
think of that can cause this, could you try to just remove the #if's ?
