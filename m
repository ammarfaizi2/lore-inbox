Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbULMUCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbULMUCS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:02:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbULMT77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 14:59:59 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:37345 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262278AbULMTyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 14:54:54 -0500
From: Jan De Luyck <lkml@kcore.org>
To: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-usb-users] [2.6.10-rc2] ehci_hcd causes oops after some use of usb harddisk
Date: Mon, 13 Dec 2004 20:55:08 +0100
User-Agent: KMail/1.7.1
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>,
       USB users list <linux-usb-users@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0411231557100.6467-100000@ida.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0411231557100.6467-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412132055.10273.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 22:02, Alan Stern wrote:
> On Tue, 23 Nov 2004, Jan De Luyck wrote:
> > On Tuesday 23 November 2004 20:39, Alan Stern wrote:
> > > Try the patch below and see if it helps.
> > >
> > > Alan Stern
> > >
> > >
> > > ===== drivers/usb/storage/transport.c 1.152 vs edited =====
> > > --- 1.152/drivers/usb/storage/transport.c 2004-11-14 19:41:07 -05:00
> > > +++ edited/drivers/usb/storage/transport.c 2004-11-23 14:37:40 -05:00
> > > @@ -987,7 +987,7 @@
> > >   /* Genesys Logic interface chips need a 100us delay between the
> > >    * command phase and the data phase */
> > >   if (us->pusb_dev->descriptor.idVendor == USB_VENDOR_ID_GENESYS)
> > > -  udelay(100);
> > > +  udelay(200);
> > >
> > >   if (transfer_length) {
> > >    unsigned int pipe = srb->sc_data_direction == DMA_FROM_DEVICE ?
> >
> > Indeed, this solved my problems.
> >
> > Thanks a lot.
>
> Just out of curiosity, could you try using several different values in
> that udelay() statement?  Maybe 200 is larger than necessary.  If
> something like 110 would work just as well, then it would help improve the
> I/O speed.

Alan, 

Sorry for the late answer, I've been rather busy of late. Today I had the time 
to recompile and test the drive.

I'm currently using the drive with a udelay of 110, and it works without any 
problems. The transfer speed is indeed higher than with the 200msec delay ;)

Hope this helps, maybe this can now be integrated into the main kernel so 
people no longer have a problem with it :)

If you need more information, feel free to ask.

Jan

-- 
I learned to play guitar just to get the girls, and anyone who says they
didn't is just lyin'!
  -- Willie Nelson
