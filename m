Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319221AbSH2PMG>; Thu, 29 Aug 2002 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319222AbSH2PMG>; Thu, 29 Aug 2002 11:12:06 -0400
Received: from hank-fep7-0.inet.fi ([194.251.242.202]:19371 "EHLO
	fep07.tmt.tele.fi") by vger.kernel.org with ESMTP
	id <S319221AbSH2PMF>; Thu, 29 Aug 2002 11:12:05 -0400
Message-ID: <3D6E3ADE.470CF7E5@pp.inet.fi>
Date: Thu, 29 Aug 2002 18:16:46 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: hch@infradead.org, aia21@cantab.net, kernel@bonin.ca,
       linux-kernel@vger.kernel.org
Subject: Re: Loop devices under NTFS
References: <200208291100.EAA11337@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
>         Bruce Schneier's x86 implementation of twofish encrypts at 18
> cycles per byte on Pentium 3, which should be about 55MB/sec on a 1GHz
> P3.  Here is a URL for someone who claims to have an x86 AES
> implementation that does up to 58MB/sec.:
> http://fp.gladman.plus.com/cryptography_technology/rijndael/ and one
> that does 45MB/sec on an 800MHz Pentium III:
> http://home.cyber.ee/helger/implementations/.  I believe that is about
> the sustained transfer rate of one top of the line hard disk (although
> the file system means there will be some seeks slowing that down), and
> the file system will have a slower sustained transfer rate on one
> disk, due at least to some seeking.  So, depending on CPU speed and
> other computing that there is to be done, it is possible that with
> read-ahead and write-behind that encryption one one CPU can be fast
> enough to keep up with the maximum throughput of the filesystem on a
> one disk drive.

Adam,

If you had followed what is going on with loop crypto, you would have known
that loop-AES' AES cipher is based on Dr Brian Gladman's implementation, and
as such is about twice as fast as the one in cryptoapi. Here is some data on
AMD Duron 800 MHz:

key length 128 bits, encrypt speed 354.3 Mbits/sec
key length 128 bits, decrypt speed 359.3 Mbits/sec
key length 192 bits, encrypt speed 298.8 Mbits/sec
key length 192 bits, decrypt speed 297.7 Mbits/sec
key length 256 bits, encrypt speed 258.8 Mbits/sec
key length 256 bits, decrypt speed 260.6 Mbits/sec

So if you really cared about speed, you would not be using cryptoapi. Also,
your loop patch will deadlock when used to encrypt swap. My loop patch does
not.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

