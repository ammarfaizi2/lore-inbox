Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131166AbQJ1R46>; Sat, 28 Oct 2000 13:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131188AbQJ1R4s>; Sat, 28 Oct 2000 13:56:48 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:23305 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131166AbQJ1R4h>; Sat, 28 Oct 2000 13:56:37 -0400
Date: Sat, 28 Oct 2000 20:02:44 +0000
From: Heinz.Mauelshagen@t-online.de (Heinz J. Mauelshagen)
To: Rik van Riel <riel@conectiva.com.br>
Cc: mhe@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: LVM snapshotting broken?
Message-ID: <20001028200244.A19767@srv.t-online.de>
Reply-To: Mauelshagen@sistina.com
In-Reply-To: <20001027154409.A13469@athlon.random> <Pine.LNX.4.21.0010271152470.25174-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010271152470.25174-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Oct 27, 2000 at 11:55:03AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 11:55:03AM -0200, Rik van Riel wrote:
> On Fri, 27 Oct 2000, Andrea Arcangeli wrote:
> > On Fri, Oct 27, 2000 at 11:32:06AM -0200, Rik van Riel wrote:
> > > Have you checked if the CONTENT of the snapshot is indeed
> > > the right LV and not the other one?
> > 
> > laser:~ # mke2fs /dev/vg1/lv1 &>/dev/null
> > laser:~ # mount /dev/vg1/lv1 /mnt
> > laser:~ # >/mnt/ciao
> > laser:~ # ls /mnt
> > .  ..  ciao  lost+found
> > laser:~ # umount /mnt
> > laser:~ # lvcreate -s -n lv1-snap /dev/vg1/lv1 -L 400M
> > lvcreate -- INFO: using default snapshot chunk size of 64 KB
> > lvcreate -- doing automatic backup of "vg1"
> > lvcreate -- logical volume "/dev/vg1/lv1-snap" successfully created
> > 
> > laser:~ # mount /dev/vg1/lv1 /mnt
> > laser:~ # rm /mnt/ciao
> > laser:~ # umount /mnt
> > laser:~ # mount /dev/vg1/lv1-snap /mnt
> > mount: block device /dev/vg1/lv1-snap is write-protected, mounting read-only
> > laser:~ # ls /mnt/
> > .  ..  ciao  lost+found
> > laser:~ # 
> 
> OK, good. I guess that means that the lvmutils (even the
> patched version in the RPM) are heavily broken ...

As i mentioned before: i wasn't able to reproduce your problem on any of
my systems. It work just fine with 0.8final and in 0.9 as weel.

Did anybody else beside Rik face a problem with snapshots _not_ referring
to the original logical volume they where created for?

> 
> Andrea, could you send me the patches you use to make your
> LVM utilities work? Then we'll be able to put together at
> least one working LVM utilities version ;)
> 
> Heinz, how about releasing a 0.8.1 version of the utilities
> so that there is something WORKING out there? Not having
> working LVM utilities available is an utter disgrace when
> all the code to make it work is just available...

I don't have any complaints so far about similar snapshot malfunctions
you mentioned, Rik.
That said it is overemphasis to say, that the LVM utilities
are not working.
IMHO Andreas Dilger's LVM 0.8 backport to kernel 2.2 should be o.k. for
most of the cases.

I'ld like to have 0.9 to do the integtration of the available patches
which will be released in november.

> 
> regards,
> 
> Rik
> --
> "What you're running that piece of shit Gnome?!?!"
>        -- Miguel de Icaza, UKUUG 2000
> 
> http://www.conectiva.com/		http://www.surriel.com/

-- 

Regards,
Heinz      -- The LVM guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Bartningstr. 12
                                                  64289 Darmstadt
                                                  Germany
Mauelshagen@Sistina.com                           +49 6151 7103 86
                                                       FAX 7103 96
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
