Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTL2Txt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTL2Tvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:51:42 -0500
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:53207 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S263937AbTL2TvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:51:22 -0500
Date: Mon, 29 Dec 2003 12:52:35 -0700
From: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
Message-ID: <20031229195235.GC26821@bounceswoosh.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16368.20794.147453.255239@jik.kamens.brookline.ma.us>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29 at 11:07, Jonathan Kamens wrote:
>The topic of CRC errrors from IDE drives has been discussed numerous
>times on this list, and I've reviewed those discussions, but I'm still
>not 100% certain of the answer to this question: Is it safe for me to
>ignore occasional CRC errors from my drive?
>
>Here are the details....
>
>The errors look like this:
>
>  hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>  hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
>
>They don't seem to happen often enough to convince the kernel to back
>down to a slower UDMA mode.

0x5184 is the error code for when the drive sends you data that was
corrupted during transmission over the cable.  In general, nothing is
wrong with your drive, and a re-read from the drive will almost always
produce the proper data.

Odds are your cable is bad, regardless of how "good" it looks, you
really can't tell if you have marginal conductivity on a pin or
something else wierd.  In my home system I replace the IDE cables
every few years, on my test box at work I replace them every month
since I'm doing lots of re-plugging of drives. Note that a bad cable
is *dangerous* to your filesystem, since a PIO transfer to the drive
has *no* integrity checking on the cable!

Also, those "round" cables violate the ATA spec, I can't really
recommend using them unless airflow is your #1 concern, however in
that case you're probably better off buying a SATA drive.

Generic IDE ribbon cables (between 6" and 18") seem to work fine for
most people, just go buy another $2 cable from CompUSA and see if the
problem goes away.

FYI, UDMA4 isn't that fast, only 66MB/sec... "good" (functional, not
brand name) flat cables should be able to do 100MB sec trivially.

--eric

-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

