Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWDCV4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWDCV4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 17:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWDCV4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 17:56:13 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:44420 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932373AbWDCV4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 17:56:12 -0400
Date: Tue, 4 Apr 2006 00:57:29 +0300
From: Dan Aloni <da-x@monatomic.org>
To: "Eric D. Mudama" <edmudama@gmail.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
Message-ID: <20060403215729.GA17731@localdomain>
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

Okay, finally got to test sata_mv with kexec, perhaps this can shed
some light on the matter.

 * Normal boot
 * insmod sata_mv
 * all is okay, as expected
 * Did kexec    
 * insmod sata_mv
 * all is okay!

Good! It means that sata_mv doesn't mess things on its initialization 
sequence.

 * Normal boot
 * insmod sata_mv
 * all is okay, as expected
 * rmmod sata_mv
 * insmod sata_mv 
 * all is bad, as expected
 * kexec
 * insmod sata_mv
 * all is bad!

Conclusion: sata_mv's shutdown does something bad.

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
