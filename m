Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267207AbSLRIzn>; Wed, 18 Dec 2002 03:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSLRIzn>; Wed, 18 Dec 2002 03:55:43 -0500
Received: from twilight.ucw.cz ([195.39.74.230]:37789 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S267207AbSLRIzm>;
	Wed, 18 Dec 2002 03:55:42 -0500
Date: Wed, 18 Dec 2002 10:03:38 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: AnonimoVeneziano <voloterreno@tin.it>
Cc: linux-kernel@vger.kernel.org, Patrick Petermair <black666@inode.at>
Subject: Re: IDE-CD and VT8235 issue!!!
Message-ID: <20021218100338.B15267@ucw.cz>
References: <3DFB7B21.7040004@tin.it> <3DFBC4F3.2070603@tin.it> <20021215215057.A12689@ucw.cz> <200212152256.25266.black666@inode.at> <20021216113458.A31837@ucw.cz> <3DFDD2FC.2030700@tin.it> <20021216141945.A32729@ucw.cz> <3DFDDF8C.8030609@tin.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DFDDF8C.8030609@tin.it>; from voloterreno@tin.it on Mon, Dec 16, 2002 at 03:13:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 16, 2002 at 03:13:32PM +0100, AnonimoVeneziano wrote:
> Vojtech Pavlik wrote:
> 
> >On Mon, Dec 16, 2002 at 02:19:56PM +0100, AnonimoVeneziano wrote:
> >  
> >
> >>>>Thanks for all your effort here. It's great to see such a good 
> >>>>community.
> >>>>        
> >>>>
> >>>If you can, please try 2.4.20 with this patch.
> >>>
> >>>      
> >>>
> >>This patch works great!! I've solved with this patch, very good work
> >>
> >>Thank you very much Pavlik!
> >>    
> >>
> >
> >Can you try another patch (on top of the previous one?)? It might still
> >work, and be less intrusive ... (attached)
> >
> >  
> >
> I don't know what u have changed in this patch, but this work great too. ;-)
> Thank you very much again

One more here, if you can try it (and remove the two previous ones
first).

-- 
Vojtech Pavlik
SuSE Labs

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=vt8235-min

ChangeSet@1.884, 2002-12-18 10:01:30+01:00, vojtech@suse.cz
  vt82cxxx.c IDE: Never use 1 PCICLK address setup, because new devices
  choke on it.


 via82cxxx.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)


diff -Nru a/drivers/ide/pci/via82cxxx.c b/drivers/ide/pci/via82cxxx.c
--- a/drivers/ide/pci/via82cxxx.c	Wed Dec 18 10:01:43 2002
+++ b/drivers/ide/pci/via82cxxx.c	Wed Dec 18 10:01:43 2002
@@ -286,6 +286,9 @@
  *	@timing: IDE timing data to use
  *
  *	via_set_speed writes timing values to the chipset registers
+ *	Note: we never use the fastest ADDRESS_SETUP timing (1 PCICLK),
+ *	because although it is OK with PIO4, many modern ATAPI devices
+ *	choke on it.
  */
 
 static void via_set_speed(struct pci_dev *dev, u8 dn, struct ide_timing *timing)
@@ -293,7 +296,7 @@
 	u8 t;
 
 	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
+	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 2, 4) - 1) << ((3 - dn) << 1));
 	pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
 
 	pci_write_config_byte(dev, VIA_8BIT_TIMING + (1 - (dn >> 1)),

--4SFOXa2GPu3tIq4H--
