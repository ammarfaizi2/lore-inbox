Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130090AbRAKK2O>; Thu, 11 Jan 2001 05:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130337AbRAKK2E>; Thu, 11 Jan 2001 05:28:04 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:31106 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S130090AbRAKK14>;
	Thu, 11 Jan 2001 05:27:56 -0500
Date: Thu, 11 Jan 2001 19:27:47 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.0prerelease -- lack of IO error on bad swap IO
Message-ID: <Pine.LNX.4.30.0101111918540.13260-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had a misconfigured swap partition: it went 480 blocks beyond the end of
the disk (last partition, SCSI, OSF/1 disklabels, Alpha).  mkswap -c
reported bad pages, and the kernel said IO error in the log on the last
mumble blocks.

When this system started to swap, the processes would just go into the D
state, and then vmstat, ps, top, et al. would go D.  Now, of course the
problem was that the swap partition was bigger than the physical media,
but there was no error message at all, just procs stuck in D.

Probably there should be an error message, or something.

Dr. Tom Holroyd
"I am, as I said, inspired by the biological phenomena in which
chemical forces are used in repetitious fashion to produce all
kinds of weird effects (one of which is the author)."
	-- Richard Feynman, _There's Plenty of Room at the Bottom_

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
