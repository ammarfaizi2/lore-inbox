Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265398AbUAZBtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 20:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbUAZBtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 20:49:10 -0500
Received: from user-0c8gj4g.cable.mindspring.com ([24.136.76.144]:48513 "EHLO
	mayonaise.dyndns.org") by vger.kernel.org with ESMTP
	id S265398AbUAZBs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 20:48:57 -0500
Date: Sun, 25 Jan 2004 17:48:14 -0800
From: Eric Wong <normalperson@yhbt.net>
To: Emmanuel Hislen <hislen@mindspring.com>
Cc: hrm@carfax.org.uk, linux-kernel@vger.kernel.org
Subject: Re: TR: SiI2112 + Seagate + nFroce2: no DMA!
Message-ID: <20040126014814.GA4888@Mayonaise>
References: <IEEHKGFDFPBODOHJKGLIEEILCAAA.hislen@mindspring.com> <40142C76.4070907@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40142C76.4070907@mindspring.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Hislen <hislen@mindspring.com> wrote:
> 
> Hi again,
> 
> Here's a more complete report on this issue.
> 
> -1-
> 
> Going to Fedora Core 12.4.22-1.2115.nptl fixed the DMA issue. The 
> Seagate SATA drive (ST3160023AS) came up in DMA mode.
> The speed however (hdparm -t) was 25MB/s, better but still unacceptable.

You have the same drive I have.

> 
> I got the latest Fedora Core: 2.4.22-1.2149.nptl
> 
> Interestingly enough I found out that this release comes with a sata_sil 
> module that is not even in 2.4.24, it was probably ported from 2.6.1 by 
> the Fedora team.
> Anyway I believe this is just a RAID driver, it did not change anything 
> (same as -1-).

sata_sil is the libata driver, it doesn't support "hardware" RAID.
Enable CONFIG_BROKEN to compile it, siimage is the generic ATA driver
(and supposedly the safer of the two, but I've had no problems (yet)
with sata_sil).  

> -5-
> 
> Now I tried kernel 2.6.1: it is worse, it dropped to 14 MB/s !?!?!
> I've seem several similar reports about 2.6.

Try 2.6.2-rc1 using the sata_sil driver, it has a blacklist instead of
punishing all Seagate (and Maxtor) drives, and ST3160023AS is definitely
not blacklisted at all, regardless of chipset revision.  Revision 2 or
newer of the SiI3112 should be fine with all Seagate drives.

warning: your /dev/hdY will become /dev/sdX (probably /dev/sda, in your
case) if you go from the IDE (siimage) driver to a libata (sata_sil)
driver.

-- 
Eric Wong                normalperson@yhbt.net
Petta Technology, Inc      eric@petta-tech.com
