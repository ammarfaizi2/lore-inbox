Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUFBLvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUFBLvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 07:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUFBLvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 07:51:19 -0400
Received: from ms003msg.fastwebnet.it ([213.140.2.42]:26100 "EHLO
	ms003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262003AbUFBLvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 07:51:18 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] fix dependeces for CONFIG_USB_STORAGE
Date: Wed, 2 Jun 2004 13:52:14 +0200
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, Linux-kernel <linux-kernel@vger.kernel.org>
References: <200406021116.35529.ornati@fastwebnet.it> <20040602104900.GB32474@infradead.org>
In-Reply-To: <20040602104900.GB32474@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406021352.14561.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 June 2004 12:49, Christoph Hellwig wrote:
> On Wed, Jun 02, 2004 at 11:16:35AM +0200, Paolo Ornati wrote:
> > This patch adds a missed dependence for CONFIG_USB_STORAGE.
> >
> > Signed-off-by: Paolo Ornati <ornati@fastwebnet.it>
> >
> > --- linux/drivers/usb/storage/Kconfig.orig	2004-06-02
> > 10:55:18.000000000 +0200 +++
> > linux/drivers/usb/storage/Kconfig	2004-06-02 10:56:03.000000000 +0200
> > @@ -6,6 +6,7 @@
> >  	tristate "USB Mass Storage support"
> >  	depends on USB
> >  	select SCSI
> > +	select BLK_DEV_SD
>
> Huh, why?

This HELP (taken from linux/drivers/scsi/Kconfig) is quite explicit:

config BLK_DEV_SD
        tristate "SCSI disk support"
        depends on SCSI
        ---help---
          If you want to use SCSI hard disks, Fibre Channel disks,
          USB storage or the SCSI or parallel port version of
          the IOMEGA ZIP drive, say Y and read the SCSI-HOWTO,
          the Disk-HOWTO and the Multi-Disk-HOWTO, available from
          <http://www.tldp.org/docs.html#howto>. This is NOT for SCSI
          CD-ROMs.

So if you want to use USB Mass Storage devices (that use SCSI emulation) you 
need also SCSI disk support (I have realized it when I've tried to mount 
one those USB devices, without success).

Bye,

-- 
	Paolo Ornati
	Linux v2.6.6

