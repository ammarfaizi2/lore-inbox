Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280467AbRK1Tm7>; Wed, 28 Nov 2001 14:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280456AbRK1Tmu>; Wed, 28 Nov 2001 14:42:50 -0500
Received: from mail.myrio.com ([63.109.146.2]:9722 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S280257AbRK1Tmk>;
	Wed, 28 Nov 2001 14:42:40 -0500
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CAE2@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
        Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: =?iso-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: RE: Unresponiveness of 2.4.16
Date: Wed, 28 Nov 2001 11:42:03 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, I just looked at the code in /fs/reiserfs/bitmap.c and 
the comment block above the warning message specifically mentions 
the low-latency patches.

I feel better now, looks like my filesystem is safe...

Torrey

Andrew Morton wrote:
[...]

> > fall over, and during the run I got the following error/
> > warning message printed about 20 times on the console
> > and in the kernel log:
> > 
> > vs-4150: reiserfs_new_blocknrs, block not free<4>
> > 
> 
> uh-oh.  I probably broke reiserfs in the low-latency patch.
> 
> It's fairly harmless - we drop the big kernel lock, schedule
> away.  Upon resumption, the block we had decided to allocate
> has been allocated by someone else.  The filesystem emits a
> warning and goes off to find a different block.
> 
> Will fix.

