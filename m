Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318236AbSIBIXY>; Mon, 2 Sep 2002 04:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSIBIXY>; Mon, 2 Sep 2002 04:23:24 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:36213 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S318236AbSIBIXW>;
	Mon, 2 Sep 2002 04:23:22 -0400
Date: Mon, 2 Sep 2002 10:27:50 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Marek Michalkiewicz <marekm@amelek.gda.pl>
Cc: Martin Wilck <mwilck@freenet.de>, Greg KH <greg@kroah.com>,
       marcelo@conectiva.com.br, mdharm-usb@one-eyed-alien.net,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] USB storage: Datafab KECF-USB, Sagatek DCS-CF
Message-ID: <20020902082750.GA9255@win.tue.nl>
References: <1030911578.17142.1.camel@odysseus.mittagstun.de> <E17lktd-0001R2-00@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17lktd-0001R2-00@alf.amelek.gda.pl>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 02, 2002 at 08:41:13AM +0200, Marek Michalkiewicz wrote:
> > Am Don, 2002-08-29 um 15.57 schrieb Marek Michalkiewicz:
> > > > > UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
> > > > > 		"Datafab",
> > > > > 		"KECF-USB",
> > > > > 		US_SC_SCSI, US_PR_BULK, NULL,
> > > > > 		US_FL_FIX_INQUIRY ),
> > 
> > This works fine with 2.4.20 - congratulations!!
> > I wonder what happened to the SCSI inquiry - was it limited to 36 bytes?
> 
> My understanding is that US_FL_FIX_INQUIRY flag fakes a response
> without sending the SCSI inquiry to the device at all.
> 
> What revision number does your device have, so we can limit the range
> (mine is 0113)?  How about US_FL_MODE_XLATE and US_FL_START_STOP -
> how to test if these flags are necessary?

I wrote in my unusual_devices.h source:

/* Marek Michalkiewicz - needed at least for revisions 0015 and 0113 */
UNUSUAL_DEV(  0x07c4, 0xa400, 0x0000, 0xffff,
              "Datafab",
              "KECF-USB",
              US_SC_SCSI, US_PR_BULK, NULL,
              US_FL_FIX_INQUIRY ),

and

/* aeb - needed at least for revision 0100 */
UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
                "Feiya",
                "5-in-1 Card Reader",
                US_SC_SCSI, US_PR_BULK, NULL,
                US_FL_FIX_CAPACITY ),

If some revision has a certain property then most likely a later revision
has the same property. We maximize the chances that someone's device
will work out of the box by making the range as large as possible.
But document in the source what precisely is needed, so that if we
find a later revision without the quirk, the limits can be adapted.

Andries
