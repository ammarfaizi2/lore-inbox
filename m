Return-Path: <linux-kernel-owner+w=401wt.eu-S1751759AbXAOAew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbXAOAew (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbXAOAew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:34:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:39119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751759AbXAOAev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:34:51 -0500
X-Authenticated: #5039886
Date: Mon, 15 Jan 2007 01:34:48 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070115003448.GA2787@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
	linux-kernel@vger.kernel.org, htejun@gmail.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45AAC95B.1020708@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.14 19:22:51 -0500, Jeff Garzik wrote:
> Robert Hancock wrote:
> >Björn Steinbrink wrote:
> >>Hi,
> >>
> >>with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
> >>often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
> >>output follows. In the meantime, I'll start bisecting.
> >
> >...
> >
> >>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> >>ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
> >>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> >>ata1: soft resetting port
> >>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> >>ata1.00: configured for UDMA/133
> >>ata1: EH complete
> >>SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> >>sda: Write Protect is off
> >>sda: Mode Sense: 00 3a 00 00
> >>SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
> >>support DPO or FUA
> >
> >Looks like all of these errors are from a FLUSH CACHE command and the 
> >drive is indicating that it is no longer busy, so presumably done. 
> >That's not a DMA-mapped command, so it wouldn't go through the ADMA 
> >machinery and I wouldn't have expected this to be handled any 
> >differently from before. Curious..
> 
> It's possible the flush-cache command takes longer than 30 seconds, if 
> the cache is large, contents are discontiguous, etc.  It's a 
> pathological case, but possible.
> 
> Or maybe flush-cache doesn't get a 30 second timeout, and it should...? 
>  (thinking out loud)

Bi-section led to commit 249e83fe839 which makes absolutely no sense to
me, just in case that anyone sees any problem with that commit.
I'll go and re-check a few of those commits that I marked as good.

Björn
