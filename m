Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVF0QEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVF0QEG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 12:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVF0QDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 12:03:14 -0400
Received: from adren.mine.nu ([81.56.37.44]:52399 "EHLO adren.mine.nu")
	by vger.kernel.org with ESMTP id S262135AbVF0PnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 11:43:23 -0400
Date: Mon, 27 Jun 2005 17:43:11 +0200
From: Cyril Chaboisseau <cyril.chaboisseau@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jakob Oestergaard <jakob@unthought.net>
Subject: Re: dm-mirror/kmirrord oops
Message-ID: <20050627154311.GB7851@adren.mine.nu>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jakob Oestergaard <jakob@unthought.net>
References: <20050627070709.GA9169@adren.mine.nu> <20050627115716.GH422@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050627115716.GH422@unthought.net>
X-Operating-System: Linux 2.6.11.11
X-GPG-Key-Fingerprint: F4AD 74A4 8F10 C2CB C569  8BD6 2E64 953B B725 9AF5
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Le 27 June vers 13:57, Jakob Oestergaard écrivait:
> Is your root filesystem mounted on an LV in 'vg' ?

no it's not

everything but / and /boot were in LVM

Sys. de fich.        1K-blocs       Occupé Disponible Capacité Monté sur
/dev/sda1               918322    263155    606171  31% /
tmpfs                   511064         0    511064   0% /dev/shm
/dev/sda3               233366     31130    189786  15% /boot
/dev/mapper/vg-tmp     1032088     32960    946700   4% /tmp
/dev/mapper/vg-usr     6192704   3577264   2300868  61% /usr
/dev/mapper/vg-var     2064208    679576   1279776  35% /var
/dev/mapper/vg-vcache
                       2064208    102568   1856784   6% /var/cache
/dev/mapper/vg-ulocal
                       6192704   2311668   3629380  39% /usr/local
/dev/mapper/vg-home   16513960   4829176  10845924  31% /home
tmpfs                    10240      3332      6908  33% /dev

this is the new layout but it was pretty much the way things were
organised


> But on another note; you should not have your root (or at least /etc)
> filesystem on LVM - because the LVM backup/recovery files are written
> there, and if LVM screws up completely, you'll then have no way of
> recovering (since the recovery files you need to get LVM going are
> stored via. LVM).

I thing that not having / in LVM saved my datas !
(I was indeed able to boot with a Knoppix and comment out the
problematic partitions)

> I always create a partition for / and keep /boot, /sbin, /lib and /etc
> there.
> 
> Then, I create another partition and make it a PV, put /var, /usr and
> everything else on LVM.

indeed

> That way I can pvmove anything without running into the bug you
> (probably) saw, and I will be able to recover the LVM in case it screws
> up (which I haven't seen yet).

in my case, I really thing that there was a problem with pvmove/kmirrord
when it tried to move data when they were being accessed

now, this is just a _wild_ guess after spending the whole afternoon
trying to recover my disks and I have no hard figures to back this 
speculation

I just realized that when I finally let pvmove finish it's work
everything went fine while previously every single attempt to copy data
to a new disk failed one way or another the same way : Oops in the
kernel

-- 
	Cyril Chaboisseau
