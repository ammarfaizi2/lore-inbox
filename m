Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbRHHUUI>; Wed, 8 Aug 2001 16:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbRHHUT6>; Wed, 8 Aug 2001 16:19:58 -0400
Received: from srvr2.telecom.lt ([212.59.0.1]:24317 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S267241AbRHHUTy>;
	Wed, 8 Aug 2001 16:19:54 -0400
Message-Id: <200108082020.WAA1347968@mail.takas.lt>
Date: Wed, 8 Aug 2001 22:14:37 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re: [PATCH] vfat write wrong value into lcase flag
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <87wv4er2kt.fsf@devron.myhome.or.jp>
In-Reply-To: <87wv4er2kt.fsf@devron.myhome.or.jp>
X-Mailer: Mahogany, 0.63 'Saugus', compiled for Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Aug 2001 00:30:58 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:

OH> The current vfat is writeing wrong value into lcase flag.  It is
OH> writing the lowercase flag, although filename is uppercase.

Hello,

In December 1999 I sent my investigation about short filenames in vfat:
_________________________________________
Hello,

there were some complaints about linux not handling upper/lowercase
filenames in vfat correctly (they are below). So I did some investigation.
I created following directories (or files, it does not matter):

in Linux: LINUP, linlow
in win98: 98UP, 98low
in NT4: NTUP, ntlow
in W2k: W2KUP, w2klow

Now what ls/dir shows:

in Linux: LINUP, linlow, 98up, 98low, ntup, ntlow, w2kup, w2klow
in win98: LINUP, LINLOW, 98UP, 98low, NTUP, NTLOW, W2KUP, W2KLOW
in NT4: LINUP, linlow, 98UP, 98low, NTUP, ntlow, W2KUP, w2klow
in W2K: LINUP, linlow, 98UP, 98low, NTUP, ntlow, W2KUP, w2klow

So I would suggest NT/W2K shows everything correctly (if we can call so,
because microsoft mixed everything up), and win98/Linux shows differently
in opposite directions. I think Linux should follow one of win95/98 or NT/W2K,
and since NT/W2K seams more reasonable, Linux could display filenames
like NT (Linux creates filenames similar to NT already).

There is no such problem with mixed up/low or with filenames
containing more than 8 characters.
_________________________________________

I like this table format better, with errors marked:

in Linux:  LINUP  linlow <98up> 98low <ntup> ntlow
in win98:  LINUP <LINLOW> 98UP  98low  NTUP <NTLOW>
in NT4:    LINUP  linlow  98UP  98low  NTUP  ntlow

Clearly NT displays everything right.
Lowercase must be written the Win98 way.
Uppercase must be written the Linux way.
_________________________________________
Then I sent a diskette image to Al Viro:

> I am sending diskette image, made with
> dd if=/dev/fd0 of=fdd_vfat bs=512 count=2847

Aha... In other words, for NT in short records bit 3 at offset 0xc
means 'lowercase it'. 9x ignores the thing. Everybody handle the long
entries the same way. Umhm... Thanks.
_________________________________________

I think Linux should create files like win98
(because NT shows them correctly) and show like NT.


Regards,
Nerijus


