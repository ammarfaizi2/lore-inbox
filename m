Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQJ0NpD>; Fri, 27 Oct 2000 09:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129084AbQJ0Nox>; Fri, 27 Oct 2000 09:44:53 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44642 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129050AbQJ0Non>; Fri, 27 Oct 2000 09:44:43 -0400
Date: Fri, 27 Oct 2000 15:44:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: mauelshagen@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
Message-ID: <20001027154409.A13469@athlon.random>
In-Reply-To: <20001027004404.A1282@athlon.random> <Pine.LNX.4.21.0010271131020.25174-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0010271131020.25174-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Oct 27, 2000 at 11:32:06AM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 11:32:06AM -0200, Rik van Riel wrote:
> Have you checked if the CONTENT of the snapshot is indeed
> the right LV and not the other one?

laser:~ # mke2fs /dev/vg1/lv1 &>/dev/null
laser:~ # mount /dev/vg1/lv1 /mnt
laser:~ # >/mnt/ciao
laser:~ # ls /mnt
.  ..  ciao  lost+found
laser:~ # umount /mnt
laser:~ # lvcreate -s -n lv1-snap /dev/vg1/lv1 -L 400M
lvcreate -- INFO: using default snapshot chunk size of 64 KB
lvcreate -- doing automatic backup of "vg1"
lvcreate -- logical volume "/dev/vg1/lv1-snap" successfully created

laser:~ # mount /dev/vg1/lv1 /mnt
laser:~ # rm /mnt/ciao
laser:~ # umount /mnt
laser:~ # mount /dev/vg1/lv1-snap /mnt
mount: block device /dev/vg1/lv1-snap is write-protected, mounting read-only
laser:~ # ls /mnt/
.  ..  ciao  lost+found
laser:~ # 

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
