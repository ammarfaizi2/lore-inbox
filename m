Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVDKQjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVDKQjC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVDKQgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:36:18 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:24704 "EHLO
	mail-in-06.arcor-online.net") by vger.kernel.org with ESMTP
	id S261841AbVDKQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:33:51 -0400
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: formatting CD-RW locks the system
To: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Mon, 11 Apr 2005 18:33:35 +0200
References: <3RPvT-2g8-31@gated-at.bofh.it> <3RRo1-3O4-21@gated-at.bofh.it> <3RVUD-7td-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DL1qz-0000uR-Ta@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:

> Every disk system I have ever delt with, has as a default, (and I've
> walked around in a couple of them at the assembly language level) the
> assumption that if track 0 is to be formatted, then the whole device
> is assumed to be needing formatted, and every filesystem I've ever
> screwed with will do exactly that.

There is one "new" filesystem you should screw with:

$ echo foo > test
$ mkisofs test > /dev/fd0h1440
Total translation table size: 0
Total rockridge attributes bytes: 0
Total directory bytes: 0
Path table size(bytes): 10
Max brk space used 21000
175 extents written (0 Mb)
$ fdformat -n /dev/fd0h1440
Double-sided, 80 tracks, 18 sec/track. Total capacity 1440 kB.
Formatting ...   0
(press ^C after writing most of the first track, hexdump will show
 blocks of 0xf6)
$ mount /dev/fd0h1440 /z -t iso9660
$ cat /z/test
foo
$

>  Often, but not always, that can
> actually be offloaded to the device itself if its smart enough, and
> the operating system itself can go on about its business, whether its
> you composing a letter to your aunt Tilly or whatever.

This would require a) the device being smart enough and b) the bus
being smart enough. 

> IDE/ATAPI drives have been cheerfully ignoreing format messages from
> the OS now for what, 12 years now unless backed up by super secret
> code word access to such builtin functions of the drive, only
> possessed by the factory technicians who do have the tools to control
> the track spaceings and data densities on the surfaces etc etc?

That's because in contrast to floppy media and CD/RW, the tracks on
HDD don't need reformating. Floppy drives suffer from aging sector
headers, and CD/RW will AFAIK suffer from a loss in writing quality.

> Are the firmwares of modern cd/dvd writers actualy dumb enough they
> need the OS's help for that?  If the answer is yes, lord help us.

They need to report success. This would require delaying the end of the
operation till the formating has finished. ATAPI is dumb enough to block
the bus during that time. Off cause you could implement SCSI disconnect
for IDE, but that would be too easy.
-- 
Top 100 things you don't want the sysadmin to say:
31. I hate it when that happens.

Friﬂ, Spammer: comptrollers@0riginals.net elq@amnszmarw.com
