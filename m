Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWDBWmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWDBWmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWDBWmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 18:42:54 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:29670 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751479AbWDBWmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 18:42:54 -0400
Date: Mon, 3 Apr 2006 01:44:16 +0300
From: Dan Aloni <da-x@monatomic.org>
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
Message-ID: <20060402224416.GA9639@localdomain>
References: <20060402155647.GB20270@localdomain> <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2006 at 11:59:45AM -0600, Eric D. Mudama wrote:
> On 4/2/06, Dan Aloni <da-x@monatomic.org> wrote:
> > Hello,
> >
> > I'm testing the sata_mv driver to see whether reloading (rmmod
> > - insmod) works, and it seems something is broken there. The
> > first insmod goes okay - however all the insmods that follow
> > emit error=0x01 { AddrMarkNotFound } and status=0x50 { DriveReady
> > SeekComplete } from all the drives.
> 
> More to Jeff/Mark etc... wouldn't this be expected?  0x50/0x01 is the
> contents of a reset signature FIS.  If the module was removed, and
> upon insmod the bus came back up, the drive would complete ASR or
> COMRESET processing and post a signature FIS.  Is the phy disabled
> when sata_mv is removed?

Should it be disabled or enabled? BTW it seems that the Marvell 3.6.1
propriety controller driver doesn't exhibit this problem so we can 
exclude hardware faults.

It looks more like a problem between the controller and the driver. 
I'm not an expert in PCI, but according to my observation so far, 
the PCI_STATUS_SIG_TARGET_ABORT bit is turned on in the config space 
after the driver is unloaded and that might indicate something bad.

 kernel: PCI config space regs: 
-kernel: 00: 608111ab 02b00317 01000009 00002008  
+kernel: 00: 608111ab 02b80713 01000009 00002008  

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
