Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132463AbQLQLJe>; Sun, 17 Dec 2000 06:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132456AbQLQLJY>; Sun, 17 Dec 2000 06:09:24 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:12813 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131880AbQLQLJW>; Sun, 17 Dec 2000 06:09:22 -0500
Date: Sun, 17 Dec 2000 04:38:45 -0600
To: Tim Riker <Tim@Rikers.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: loop device length
Message-ID: <20001217043845.S3199@cadcamlab.org>
In-Reply-To: <3A398E0A.A12F973E@Rikers.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A398E0A.A12F973E@Rikers.org>; from Tim@Rikers.org on Thu, Dec 14, 2000 at 08:20:42PM -0700
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tim Riker]
> losetup allows for setting a starting offset within a file for the
> loop block device. There however is no length parameter to permit
> setting the length. Adding a length parameter would allow for
> multiple fs images in a single file (or device) and would correctly
> handle programs like resize2fs.

You don't need a length field for this, although it may be a good idea.
Filesystems know how big they are.  You only need to force it at mkfs
and resize time, and in both cases you can override the tool's
knowledge.

In other words, you *can* put multiple fs images on a single piece of
backing store as long as you manage the lengths manually, which you
have to do anyway since you're keeping track of the starting offsets.

All the length parameter buys is not having to specify the same length
to losetup and mke2fs.  And a little protection from shooting yourself
in the foot, but by the time you are messing with stuff like this you
had better be careful anyway.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
