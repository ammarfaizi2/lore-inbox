Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131185AbRAKTZH>; Thu, 11 Jan 2001 14:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131541AbRAKTY6>; Thu, 11 Jan 2001 14:24:58 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:13841 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S131185AbRAKTYw>; Thu, 11 Jan 2001 14:24:52 -0500
Message-ID: <3A5E0886.4389692E@Hell.WH8.TU-Dresden.De>
Date: Thu, 11 Jan 2001 20:24:54 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange umount problem in latest 2.4.0 kernels
In-Reply-To: <Pine.GSO.4.21.0101111337250.17363-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /dev/hdb1: Inode 522901, i_blocks is 64, should be 8. FIXED

Ok, culprit identified: /var/spool/lpd/lpd.lock

On another partition I had the same problem with httpd's
error_log.

Since both of those seem to be log- and lock-files, maybe
there's something wrong with file locking?

Anyway, disabled both lpd and httpd from the startup scripts
and now the bug is triggered *every* time. I cannot reboot
a single time without partitions being busy. When neither
lpd nor httpd run, fsck finds nothing wrong.

The very strange stuff is umount at reboot:

umount: none busy - remounted read-only
umount: /: device is busy
Remounting root-filesystem read-only
mount: / is busy
Rebooting.

*fsck*

The "none" bit puzzles me the most. /etc/fstab and /etc/mtab
look perfectly ok.

Has anyone got an idea? Everything worked well with 2.4.0 and
Alan's tree up to -ac4, didn't try ac5, and ac6 is what messes
up now.

-Udo.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
