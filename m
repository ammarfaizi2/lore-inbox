Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280777AbRKSX4L>; Mon, 19 Nov 2001 18:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280786AbRKSX4C>; Mon, 19 Nov 2001 18:56:02 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:60056 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280777AbRKSXz4>;
	Mon, 19 Nov 2001 18:55:56 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Patrick Mau <mau@oscar.prima.de>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Date: Mon, 19 Nov 2001 15:55:40 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20011120004350.A9631@oscar.dorf.de>
In-Reply-To: <20011120004350.A9631@oscar.dorf.de>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E165yGL-00012u-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 15:43, Patrick Mau wrote:
> Hallo all,
>
> I'm using kernel 2.4.15-pre6 and I can see my journal file
> on '/'. Should I worry ?
No, apparently the .journal file is visible if you created while the 
filesystem is mounted, but invisible if you create it when the filesystem is 
unmounted. Probably because you can't mess with the filesystem too much when 
its mounted without confusing the filesystem driver, so creating hidden files 
is out of the question. In either case, I created my journal with the 
filesystem mounted, and it created a visible, immutable .journal file in my 
root directory, and my filesystem has yet to explode.

> [root@tony] ls -ali /
> total 65720
>    2 drwxr-xr-x   24 root     root         4096 Nov 20 00:26 .
>    2 drwxr-xr-x   24 root     root         4096 Nov 20 00:26 ..
> 2930 -rw-------    1 root     root     67108864 Nov 18 19:56 .journal
> 					^^^^^^^ created as -J size=64
64 * (1024^2) = 67108864
Remember 1K = 1024, and 1M = 1024^2

>
> [root@tony] tune2fs -l /dev/sda1
> tune2fs 1.25 (20-Sep-2001)
> Filesystem volume name:   /
> Last mounted on:          <not available>
> Filesystem UUID:          b909b36d-8f16-4be1-9614-5049bad90e96
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal filetype needs_recovery sparse_super
>                                                ^^^^^^^^^^^^^^
> 					       ??????????????
The flag "filetype needs_recovery" is always set on a mounted filesystem, 
it's unset once you umount. In the event of power failure, the flag will be 
left set, and fsck knows the it has to recover the filesytem. Pretty clever, 
eh?

> Could someone please comment on this ?
> I'm feeling kind of worried.
Everything seems to be in order...

-Ryan
