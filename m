Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129084AbQJ0Nzo>; Fri, 27 Oct 2000 09:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129212AbQJ0Nze>; Fri, 27 Oct 2000 09:55:34 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:45300 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129084AbQJ0NzU>; Fri, 27 Oct 2000 09:55:20 -0400
Date: Fri, 27 Oct 2000 11:55:03 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
cc: mauelshagen@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
In-Reply-To: <20001027154409.A13469@athlon.random>
Message-ID: <Pine.LNX.4.21.0010271152470.25174-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2000, Andrea Arcangeli wrote:
> On Fri, Oct 27, 2000 at 11:32:06AM -0200, Rik van Riel wrote:
> > Have you checked if the CONTENT of the snapshot is indeed
> > the right LV and not the other one?
> 
> laser:~ # mke2fs /dev/vg1/lv1 &>/dev/null
> laser:~ # mount /dev/vg1/lv1 /mnt
> laser:~ # >/mnt/ciao
> laser:~ # ls /mnt
> .  ..  ciao  lost+found
> laser:~ # umount /mnt
> laser:~ # lvcreate -s -n lv1-snap /dev/vg1/lv1 -L 400M
> lvcreate -- INFO: using default snapshot chunk size of 64 KB
> lvcreate -- doing automatic backup of "vg1"
> lvcreate -- logical volume "/dev/vg1/lv1-snap" successfully created
> 
> laser:~ # mount /dev/vg1/lv1 /mnt
> laser:~ # rm /mnt/ciao
> laser:~ # umount /mnt
> laser:~ # mount /dev/vg1/lv1-snap /mnt
> mount: block device /dev/vg1/lv1-snap is write-protected, mounting read-only
> laser:~ # ls /mnt/
> .  ..  ciao  lost+found
> laser:~ # 

OK, good. I guess that means that the lvmutils (even the
patched version in the RPM) are heavily broken ...

Andrea, could you send me the patches you use to make your
LVM utilities work? Then we'll be able to put together at
least one working LVM utilities version ;)

Heinz, how about releasing a 0.8.1 version of the utilities
so that there is something WORKING out there? Not having
working LVM utilities available is an utter disgrace when
all the code to make it work is just available...

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
