Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131148AbQK3UGL>; Thu, 30 Nov 2000 15:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131149AbQK3UGB>; Thu, 30 Nov 2000 15:06:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24375 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S131156AbQK3UFt>; Thu, 30 Nov 2000 15:05:49 -0500
Date: Thu, 30 Nov 2000 20:35:11 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre24
Message-ID: <20001130203511.A18804@athlon.random>
In-Reply-To: <E140wh7-0005Na-00@the-village.bc.nu> <20001129150159.Y872@opus.bloom.county> <20001130181740.A18566@athlon.random> <20001130112643.A16256@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001130112643.A16256@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Nov 30, 2000 at 11:26:43AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2000 at 11:26:43AM -0700, Tom Rini wrote:
> Right.  But the problem here was a new, unused sysctl-by-number, conflicted
> with an old-but-not-integrated sysctl-by-number that is used. :)  The only

Who is using it? Not even the raid developers cared to take the
sysctl-by-number consistent between 2.4.0-test12-pre2 and 2.2.x raid 0.90
so nobody should be using it in first place.

Furthmore since the number 4 is the official one for raid/md, DEV_MAC_HID=3
isn't really colliding with the raid sysctl, but DEV_MAC_HID=3 is still wrong
because is it should be =5 to be consistent with 2.4.x...

2.2.x RAID 0.90:

 enum {
 	DEV_CDROM=1,
-	DEV_HWMON=2
+	DEV_HWMON=2,
+	DEV_MD=3
 };
[..]
+/* /proc/sys/dev/md */
+enum {
+	DEV_MD_SPEED_LIMIT=1
 };


2.2.18pre24:

enum {
	DEV_CDROM=1,
	DEV_HWMON=2,
	DEV_MAC_HID=3
};

2.4.0-test12-pre2:

enum {
	DEV_CDROM=1,
	DEV_HWMON=2,
	DEV_PARPORT=3,
	DEV_RAID=4,
	DEV_MAC_HID=5
};
[..]
/* /proc/sys/dev/raid */
enum {
	DEV_RAID_SPEED_LIMIT_MIN=1,
	DEV_RAID_SPEED_LIMIT_MAX=2
};

As we can clearly see nobody cares about the sysctl-by-number interface because
it generates collisions too easily so it should be declared obsolete and nobody
should use it anymore. sysctl-by-name is less performant but it doesn't
generate binary-level collisions so easily and in turn it's a big win for open
source projects where everybody has some tons of unofficial patches applied
(raid 0.90 in this case).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
