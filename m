Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRAZC3V>; Thu, 25 Jan 2001 21:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129771AbRAZC3L>; Thu, 25 Jan 2001 21:29:11 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:54022 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129398AbRAZC2z>; Thu, 25 Jan 2001 21:28:55 -0500
Message-ID: <3A70E0D7.8D28F8B6@baldauf.org>
Date: Fri, 26 Jan 2001 03:28:39 +0100
From: Xuan Baldauf <xuan--lkml@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Peter Horton <pdh@colonel-panic.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8 losing pages
In-Reply-To: <20010125231659.A2128@colonel-panic.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Horton wrote:

> I'm experiencing repeatable corruption whilst writing large volumes of
> data to disk. Kernel version is 2.4.1-pre8, on an 850MHz AMD Athlon on an
> ASUS A7V (VIA KT133 chipset) motherboard 128M RAM (tested with 'memtest86'
> for 10 hours).
>
> First, I realised that the fsck was noticing small corruptions on my ext2
> volume. My first suspect was the much discussed VIA IDE controller. As a
> test I created a 128M file from "urandom" and copied it to twenty six
> files. When I MD5 the files one or two of them are usually corrupt. The
> damage usually occurs in the 24th copy (thought not always). Inspecting
> the files shows a single 4K block (aligned on a 4K boundary) that is
> completely different from what it should be. The kernel logs no errors
> whilst writing the corrupt files.
>
> I've repeated the test on the other on-board IDE controller (Promise), a
> different hard disk, and on reiserfs. I see the corruption in all cases.
>
> I tried building the kernel for "Pentium-Classic", and I tried a few older
> kernels (2.4.0-test5 and 2.4.0-test12), still bad (all kernels built with
> GCC 2.95.2 - Debian potato).
>
> I really could do with some help as where to look next :-). I did try and
> come up with a test to see whether bad data is written or whether the
> damaged piece is just not written, but if I alter the testing procedure
> too much the problem seems to go away. It seems to just lose a single page
> under one very specific circumstance.

So what output does following bash script produce?

#!/bin/bash
uname -a
dd if=/dev/urandom of=test0 bs=1024k count=128
I=1
while test $I -lt 32; do
  echo $I
  cp test0 test$I
  I="$(($I+1))"
done
md5sum test*

I cannot reproduce your behaviour in 2.4.1-pre9.

Xuân.

>
>
> P.
>
> ( configs attached )
>
>   ------------------------------------------------------------
>                   Name: info.tar.gz
>    info.tar.gz    Type: Unix Tape Archive (application/x-tar)
>               Encoding: base64
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
