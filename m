Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264019AbTCXJxE>; Mon, 24 Mar 2003 04:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264083AbTCXJxE>; Mon, 24 Mar 2003 04:53:04 -0500
Received: from cs-ats40.donpac.ru ([217.107.128.161]:8208 "EHLO pazke")
	by vger.kernel.org with ESMTP id <S264019AbTCXJxD>;
	Mon, 24 Mar 2003 04:53:03 -0500
Date: Mon, 24 Mar 2003 13:04:06 +0300
To: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
Subject: Re: USB harddrive not working (2.4, 2.5)
Message-ID: <20030324100406.GA14591@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-usb-users@lists.sourceforge.net
References: <20030319102117.GA689@pazke> <20030321182230.GA25297@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321182230.GA25297@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 080, 03 21, 2003 at 01:22:30 -0500, Jan Harkes wrote:
> On Wed, Mar 19, 2003 at 01:21:17PM +0300, Andrey Panin wrote:
> > Hi,
> > 
> > ISD200 based hard drive bay doesn't work with 2.4 & 2.5, 
> > can someone assist me with it?
> 
> This looks like the same problem I was seeing with my Archos. The
> initial probes for ATA devices fail and the driver falls back to
> 'transparent scsi mode', where it passes everything along unchanged.
> Probably works fine when an ATAPI device is attached, but not with my
> drive.
> 
> > usb-storage:    isd200_action(ENUM,0xa0)
> > usb-storage: Bulk command S 0x43425355 T 0x0 Trg 0 LUN 1 L 0 F 0 CL 0
> > usb-storage: usb_stor_bulk_transfer_buf(): xfer 31 bytes
> > usb-storage: Status code 0; transferred 31/31
> > usb-storage: -- transfer complete
> > usb-storage: Bulk command transfer result=0
> > usb-storage: Attempting to get CSW...
> > usb-storage: usb_stor_bulk_transfer_buf(): xfer 13 bytes
> > usb-storage: Status code -32; transferred 0/13
> 
> The isd200 driver is not correctly initializing the srb.cmd_len field,
> which is the main reason why things fail. I also noticed that the
> usb_stor_bulk functions are interpreting the ATA commands as if they
> were scsi, so the packet was sent to the wrong lun, but that might not
> really matter much.
> 
> Here is a patch agains 2.5.64 that fixes both of these problems for me.
> It will probably apply to 2.5.65 as well.

I don't have this drive at this time, but i'll test your patch and report
results ASAP.

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net
