Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSGVUkM>; Mon, 22 Jul 2002 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317806AbSGVUkM>; Mon, 22 Jul 2002 16:40:12 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:51631 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317802AbSGVUkL>; Mon, 22 Jul 2002 16:40:11 -0400
Date: Mon, 22 Jul 2002 22:43:06 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Block devices in pagecache, fsck, and what's going on...
In-Reply-To: <BA7A23202E6@vcnet.vc.cvut.cz>
Message-ID: <Pine.SOL.4.30.0207222239220.13634-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

On Mon, 22 Jul 2002, Petr Vandrovec wrote:

> Hello,
>   I've noticed very bad problem few weeks ago, but I thought that it
> is just some bad accident. But today it happened again.
>
>   Say that for some reason kernel will crash (such as missing read_unlock...)
> and you have to hard reboot it.
>
>   Now you reboot, and system runs e2fsck, which removes couple of
> /var/run/*.pid entries.
>
>   It was not severe, so initscripts (Debian unstable) remount root read-write,
> and continue booting. And now - oops - first cleanup script complains
> that it could not remove these *.pid files because of -EIO, and shortly
> after that filesystem is remounted read-only because of "Freeing blocks not
> in datazone - block = 271450112, count=56; block = 32768, count = 2564"
> and it goes downhill very quickly...
>
>   After reboot fsck it says that entries xxx.pid in /var/run has deleted/unused
> inode yyy, and if I do not reboot, there is very high chance that it
> will die again.
>
>   If I reboot after running e2fsck, everything is fine. Always.
>
>   My question is very simple: is this intended behavior of non-coherent
> cache between /dev/hda1 and ext2 layer (which also makes dump to crash),
> or is it something missing in e2fsck (1.27), or is it Debian bug and

It is not Debian's bug I sometimes get the same problem on
highly modified RedHat 7.2 with e2fsck (1.23) (Yes, I know I should
upgrade).

> it is now required to reboot machine after any run of e2fsck on /
> partition?
>                                     Thanks,
>                                         Petr Vandrovec
>                                         vandrove@vc.cvut.cz
>
> P.S.: BTW, I find it very strange that in /var/log/* I can have
> written: "Can't open file /var/cache/samba/browse.dat.. Error was Read-only
> file system" when /var/log/* lives on same filesystem as /var/cache...
> and also all remounting-readonly messages are here, written to same
> partition which was remounted-read only due to these fatal errors.


