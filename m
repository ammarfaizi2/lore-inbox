Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265826AbTL3QMd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 11:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265829AbTL3QMd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 11:12:33 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:9662 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265826AbTL3QMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 11:12:31 -0500
Subject: Re: Fw: LVM2 on Gentoo-Dual Opteron/Amd64 system troubles...
From: Christophe Saout <christophe@saout.de>
To: Branko <brankob@avtomatika.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <007401c3cee2$80edba60$0a03a8c0@brane>
References: <007401c3cee2$80edba60$0a03a8c0@brane>
Content-Type: text/plain
Message-Id: <1072800771.4290.24.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Dec 2003 17:12:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 30.12.2003 schrieb Branko um 15:37:

>  I have bothered support at Sistina with this, but received no answer yet
> (being christmas time etc), so I thought of posting it here also...

Yep, on vacation.

> Manual recommends using special script called lvmcreate_initdr to do initrd
> initialisations, but my lvm2 doesn't have that script. After many trials and
> errors  i have made initrd which succeeds with LVM initialisation, but
> machine reboots just at the point when it should drop initrd environment and
> jump into root  on LV.
> [...]
> -how does one make initrd with LVM ? I had to scavenge script from LVM1,
> without much success...

How does your initrd look like?

What boot loader do you use?

I wrote an initrd myself some time ago that works very well (for me).

It's only a simle x86 one, but I think the binaries could be replaced
with the opteron ones. I just copied the binaries from my own (also
Gentoo) system and stripped them.

You can find it here:
http://www.saout.de/misc/initrd-2.6.0-lvm2-athlon.gz
(there's also a small README in that directory)

gunzip it and
mount initrd-2.6.0-lvm2-athlon /mnt -o loop

Then you can go in there and replace the binaries (some libraries in
/lib, /bin and /sbin).

/bin/sh is a small shell called "ash" (which can also be emerged). udev
is used when no devfs is available.

You can try playing with that one until someone writes a script.

It doesn't contain a module loader so device-mapper and ext3 should be
compiled into the kernel.

You should create a directory called /initrd on your root volume and
pass root=/path/to/volume to the kernel (instead of the numeric
root=fe00), then the script will try to mount the root volume itself and
pivot_root to it which will work better because LVM2 uses dynamic
minors.

Good luck. :)


