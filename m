Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261274AbSJHSYl>; Tue, 8 Oct 2002 14:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJHSYl>; Tue, 8 Oct 2002 14:24:41 -0400
Received: from mailf.telia.com ([194.22.194.25]:6646 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S261274AbSJHSYk>;
	Tue, 8 Oct 2002 14:24:40 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
Date: Tue, 8 Oct 2002 20:30:10 +0200 (CEST)
From: Peter Osterlund <petero2@telia.com>
X-X-Sender: petero@p4.localdomain
To: Greg KH <greg@kroah.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.5.40 panic in uhci-hcd
In-Reply-To: <20021008181951.GD5239@kroah.com>
Message-ID: <Pine.LNX.4.44.0210082025570.16233-100000@p4.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Oct 2002, Greg KH wrote:

> On Tue, Oct 08, 2002 at 08:01:34PM +0200, Peter Osterlund wrote:
> > On Tue, 8 Oct 2002, Greg KH wrote:
> > 
> > > On Sun, Oct 06, 2002 at 02:03:49PM +0200, Peter Osterlund wrote:
> > > > Sometimes when booting 2.5.40 and my Freecom USB-IDE controller (CDRW)
> > > > is connected, the kernel panics when trying to initialize the usb
> > > > subsystem. It happens right after the RH73 boot scripts print out:
> > > > 
> > > >         Initializing USB controller (uhci-hcd):  [  OK  ]
> > > > 
> > > > In 2.5.39, this happened every time I tried to boot, but in 2.5.40 it
> > > > seems to happen about 20% of the time.
> > > 
> > > Hey, we're getting better :)
> > > 
> > > How does 2.5.41 work for you?
> > 
> > It seems to be fixed. Thanks.
> 
> Heh, that's pretty funny.  There were not any uhci specific fixes in
> 2.5.41...
> 
> Not complaining,

Actually, there were. This patch is in 2.5.41.

diff -Nru a/drivers/usb/host/uhci-hcd.c b/drivers/usb/host/uhci-hcd.c
--- a/drivers/usb/host/uhci-hcd.c       Mon Oct  7 11:25:38 2002
+++ b/drivers/usb/host/uhci-hcd.c       Mon Oct  7 11:25:38 2002
@@ -2149,14 +2149,14 @@
        uhci->fl->dma_handle = dma_handle;
 
        uhci->td_pool = pci_pool_create("uhci_td", hcd->pdev,
-               sizeof(struct uhci_td), 16, 0, GFP_ATOMIC);
+               sizeof(struct uhci_td), 16, 0);
        if (!uhci->td_pool) {
                err("unable to create td pci_pool");
                goto err_create_td_pool;
        }
 
        uhci->qh_pool = pci_pool_create("uhci_qh", hcd->pdev,
-               sizeof(struct uhci_qh), 16, 0, GFP_ATOMIC);
+               sizeof(struct uhci_qh), 16, 0);
        if (!uhci->qh_pool) {
                err("unable to create qh pci_pool");
                goto err_create_qh_pool;

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340

