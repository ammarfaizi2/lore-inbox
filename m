Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271569AbRHPUbs>; Thu, 16 Aug 2001 16:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271633AbRHPUbi>; Thu, 16 Aug 2001 16:31:38 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:11765 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S271569AbRHPUbX>; Thu, 16 Aug 2001 16:31:23 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Thu, 16 Aug 2001 14:30:58 -0600
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Steve Hill <steve@navaho.co.uk>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/random in 2.4.6
Message-ID: <20010816143058.Z31114@turbolinux.com>
In-Reply-To: <20010816131112.V31114@turbolinux.com> <212844030.997994112@[169.254.45.213]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <212844030.997994112@[169.254.45.213]>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2001 at 08:35:12PM +0100, Alex Bligh - linux-kernel wrote:
> It's a while since I looked, but I /thought/ entropy only came from
> IDE (not for instance from SCSI, and certainly not when everything
> is sitting in cache). I have a reasonably active mailserver (SCSI,
> no k/b, no mouse, lots of RAM) which doesn't have enough entropy
> to cope with SSL/TLS gracefully without relying on the network
> traffic (i.e. behaves like it is ramdisk only).

Actually, AFAIK you _may_ get entropy from the IDE interrupts directly
(I didn't check), but you also appear to get entropy from block I/O
completions as well.  I _thought_ I had seen such lines in IDE, DAC960,
and also in the SCSI midlayer, but then I wasn't paying much attention
to those - I was trying to track down the interrupts for net devices.

If it is NOT in the SCSI block I/O layer, it should probably be added.
Whether it makes sense to have entropy from both the block layer and
the actual device IRQs is an issue left up to the security experts (it
may have correlation, and not be good entropy).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

