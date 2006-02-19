Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWBSKJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWBSKJl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 05:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWBSKJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 05:09:40 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:6840 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932388AbWBSKJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 05:09:40 -0500
To: linuxer@ever.mine.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
	<m3r760cntz.fsf@telia.com>
	<200602182335.k1INZFoi012487@rhodes.mine.nu>
From: Peter Osterlund <petero2@telia.com>
Date: 19 Feb 2006 11:09:31 +0100
In-Reply-To: <200602182335.k1INZFoi012487@rhodes.mine.nu>
Message-ID: <m38xs7d5ic.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxer@ever.mine.nu writes:

> Peter Osterlund <petero2@telia.com> writes:
>   > 
>   > linuxer@ever.mine.nu writes:
>   > 
>   > > In drivers/block/pktcdvd.c it appears that in the case of DVD
>   > > rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
>   > > (the maximum writing speed reported by the drive). 
>   > > 
>   > > In my case, I have a new drive capable of 8x re-writing. However, all of
>   > > my existing media is rated for only 4x rewrite speed. 
>   > > 
>   > > When attempting to rw mount these disks, pktcdvd reports:
>   > > 
>   > > Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
>   > > Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
>   > > sense 00.54.9c (No sense)
>   > > Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
>   > > 
>   > > And then of course a huge heap of I/O errors on the disk. 
>   > 
>   > Have you verified that this is caused by the speed setting, ie does it
>   > work correctly if you hack the driver to write at 4x speed?
> 
> Correct. Adding a hard-coded manual setting of write_speed = 5540 to
> pkt_open_write results in functional operation (at least with 4x rated
> DVD+RW media).
> 
> Obviously, this particular drive is perfectly happy to try to write at over
> the rated media speed if it is asked to. I can't fault the manufacturer for
> this, for I generally like the idea of letting the user decide instead of
> imposing hardware/firmware fixed limits. 

The Mt. Fuji specification would put the blame on the manufacturer.
>From the description of the "set cd speed" command:

        If the Logical Unit is requested to write at the speed which
        is not listed in the Logical Unit Write Speed Performance
        Descriptor, the Logical Unit shall select any slower Logical
        Unit Write Speed. This condition is not regarded as an error
        condition.

However, the specification doesn't matter if following it blindly
makes real hardware fail. I don't think it would be that hard to get
the maximum DVD media speed from the drive and use that instead of the
maximum drive speed.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
