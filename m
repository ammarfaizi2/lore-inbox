Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129342AbQJZWo5>; Thu, 26 Oct 2000 18:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129514AbQJZWor>; Thu, 26 Oct 2000 18:44:47 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:40532 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129342AbQJZWoi>; Thu, 26 Oct 2000 18:44:38 -0400
Date: Fri, 27 Oct 2000 00:44:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: mauelshagen@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
Message-ID: <20001027004404.A1282@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0010261632440.15696-100000@duckman.distro.conectiva> <Pine.LNX.4.21.0010261834360.15696-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0010261834360.15696-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Oct 26, 2000 at 06:34:48PM -0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2000 at 06:34:48PM -0200, Rik van Riel wrote:
> On Thu, 26 Oct 2000, Rik van Riel wrote:
> 
> > it looks like the LVM snapshotting in 2.4 doesn't allow you
> > to create snapshots from anything else than the _first_ LV
> > in the VG...
> 
> OK, I reproduced it in 2.2 as well ... ;(

Which 2.2.x? LVM isn't supported in 2.2.18pre17 or any other previous version.

For some irrelevant reason I always test snapshotting on a LV with minor
number > 1 and the kernel side definitely works with 2.2.18pre17aa1:

laser:/home/andrea # ls -l /dev/vg1/lv*
brw-r-----   1 root     root      58,   0 Oct 27  2000 /dev/vg1/lv0
brw-r-----   1 root     root      58,   1 Oct 27  2000 /dev/vg1/lv1
laser:/home/andrea # lvcreate -s -n lv1-snap /dev/vg1/lv1 -L 400M
lvcreate -- INFO: using default snapshot chunk size of 64 KB
lvcreate -- doing automatic backup of "vg1"
lvcreate -- logical volume "/dev/vg1/lv1-snap" successfully created

laser:/home/andrea # lvremove -f /dev/vg1/lv1-snap 
lvremove -- doing automatic backup of volume group "vg1"
lvremove -- logical volume "/dev/vg1/lv1-snap" successfully removed

laser:/home/andrea # 

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
