Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132069AbQLRNQE>; Mon, 18 Dec 2000 08:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130247AbQLRNPy>; Mon, 18 Dec 2000 08:15:54 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:34564 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S132069AbQLRNPo>; Mon, 18 Dec 2000 08:15:44 -0500
Date: Mon, 18 Dec 2000 06:45:13 -0600
To: Tigran Aivazian <tigran@veritas.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test13-pre3] rootfs boot param. support
Message-ID: <20001218064513.G3199@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0012111102480.801-100000@penguin.homenet> <Pine.LNX.4.21.0012181150060.840-100000@penguin.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012181150060.840-100000@penguin.homenet>; from tigran@veritas.com on Mon, Dec 18, 2000 at 11:56:47AM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Tigran Aivazian]
> +/* this can be set at boot time, e.g. rootfs=ext2 
> + * if set to invalid value or if read_super() fails on the specified
> + * filesystem type then mount_root() will go through all registered filesystems.
> + */
> +static char rootfs[128] __initdata = "ext2";

Better that we not hard-code anything here.  If we want ext2 to be
tried first, we should link it first, which we already do.

Peter

[hand-edited patch, may not be right!]

--- linux/fs/super.c	Tue Dec 12 09:25:22 2000
+++ rootfs/fs/super.c	Mon Dec 18 10:03:31 2000
@@ -63,7 +63,7 @@
  * if set to invalid value or if read_super() fails on the specified
  * filesystem type then mount_root() will go through all registered filesystems.
  */
-static char rootfs[128] __initdata = "ext2";
+static char rootfs[32] __initdata = "";
 
 int nr_super_blocks;
 int max_super_blocks = NR_SUPER;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
