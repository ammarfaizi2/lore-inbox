Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWDDGHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWDDGHF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 02:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWDDGHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 02:07:04 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:32360 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S1751290AbWDDGHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 02:07:02 -0400
Date: Tue, 4 Apr 2006 09:08:28 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Mark Lord <liml@rtr.ca>
Cc: "Eric D. Mudama" <edmudama@gmail.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Mark Lord <lkml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>
Subject: Re: sata_mv: module reloading doesn't work
Message-ID: <20060404060828.GA11996@localdomain>
References: <20060402155647.GB20270@localdomain> <311601c90604021059jcdf56e4ja35e3507ab291179@mail.gmail.com> <20060403215729.GA17731@localdomain> <4431DE2B.1020306@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4431DE2B.1020306@rtr.ca>
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

On Mon, Apr 03, 2006 at 10:47:07PM -0400, Mark Lord wrote:
> Dan Aloni wrote:
> >
> > * Normal boot
> > * insmod sata_mv
> > * all is okay, as expected
> > * rmmod sata_mv
> > * insmod sata_mv 
> > * all is bad, as expected
> > * kexec
> > * insmod sata_mv
> > * all is bad!
> >
> >Conclusion: sata_mv's shutdown does something bad.
> 
> sata_mv seems to just use the default libata shutdown sequence,
> so perhaps it's leaving the device in EDMA mode with interrupt
> coalescing still on (from the BIOS), and interrupts are still
> coming in or something..
> 
> I suppose it really ought to shut down the device before exiting,
> and maybe the default of pci_disable_device() is not enough.. ?

BTW, can you tell what firmware version are you using? I'm 
using rev 9, perhaps it also plays some role in this problem.

-- 
Dan Aloni, Linux specialist
XIV LTD, http://www.xivstorage.com
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
