Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277011AbRJQR5m>; Wed, 17 Oct 2001 13:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277013AbRJQR5d>; Wed, 17 Oct 2001 13:57:33 -0400
Received: from web20507.mail.yahoo.com ([216.136.226.142]:25604 "HELO
	web20507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277011AbRJQR5U>; Wed, 17 Oct 2001 13:57:20 -0400
Message-ID: <20011017175752.80489.qmail@web20507.mail.yahoo.com>
Date: Wed, 17 Oct 2001 19:57:52 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: Making diff(1) of linux kernels faster
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul !

congratulations for this improvement, it seems really
interesting. BTW, I personnaly use hard links between
kernels to make the effective data set smaller, and
I'd
like to explain here how I proceed since there are
often people who seem completely amazed by this method
which I learned here on LKML a few years ago :

# cd /usr/src
# tar Ixf anydir/linux-2.4.12.tar.bz2
# cp -dRflp linux linux-2.4.12
>>> this way, only dir entries are duplicated, so very
>>> little overhead
# (cd linux && bzcat anydir/patch-2.4.13pre1.bz2|patch
-Np1)
# cp -dRflp linux linux-2.4.13pre1
>>> now, only file affected by the patch are
duplicated
>>> then, you can work inside linux dir, and construct
>>> your patches very quickly since a few files
>>> effectively differ from your new tree and old
ones.

Be very careful not to modify a multi-linked file, or
it will be damaged in all trees and won't be seen by
diff. your editor must unlink before saving.

I hope it will help someone as it has helped me for a
while now. I nearly always have sub-second diffs, even
with not-so-much RAM.

Cheers,
Willy


___________________________________________________________
Un nouveau Nokia Game commence. 
Allez sur http://fr.yahoo.com/nokiagame avant le 3 novembre
pour participer à cette aventure tous médias.
