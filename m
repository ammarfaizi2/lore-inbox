Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131370AbQLMNPH>; Wed, 13 Dec 2000 08:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131395AbQLMNPB>; Wed, 13 Dec 2000 08:15:01 -0500
Received: from univ.uniyar.ac.ru ([193.233.51.120]:56494 "EHLO
	univ.uniyar.ac.ru") by vger.kernel.org with ESMTP
	id <S131370AbQLMNOp>; Wed, 13 Dec 2000 08:14:45 -0500
Date: Wed, 13 Dec 2000 15:43:38 +0300 (MSK)
From: "Igor Yu. Zhbanov" <bsg@uniyar.ac.ru>
To: urban@teststation.com, linux-kernel@vger.kernel.org, Alan.Cox@linux.org
Subject: Re: [PATCH] Bug in date converting functions DOS<=>UNIX in FAT, NCPFS and SMBFS drivers [second attempt]
Message-ID: <Pine.GSO.3.96.SK.1001213154121.6051A-100000@univ.uniyar.ac.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, sorry for slow response.
(I have lost and found your first letter.)

On Tue, 28 Nov 2000, Urban Widmark wrote:

> On Fri, 24 Nov 2000, Igor Yu. Zhbanov wrote:
>
...
>
> > I have found a bug in drivers of file systems which use a DOS-like format
> > of date (16 bit: years since 1980 - 7 bits, month - 4 bits, day - 5 bits).
>
> [snip]
>
> > 2) VFAT for example have three kinds of dates: creation date, modification date
> >    and access date. Sometimes one of these dates is set to zero (which indicates
> >    that this date is not set). Zero is not a valid date (e.g. months are
> >    numbered from one, not from zero) and can't be properly converted to
> >    UNIX-like format of date (it was converted to date before 1980).
>
> Days are also numbered from one (at least smbfs) and this change doesn't
> do anything about that. An all zero date gives 315446400 (or else my
> testprogram is broken) and you wanted it to give 315532800 (?). So that
> should be fixed too, I think.

I think your testprogram is broken (or else my testprogram is broken :). After applying
my pathch you will get 315532800 (86400*(-1+3653)) on zero date (Jan 1 GMT 00:00:00 1980).
Since 'month = ((date >> 5) & 15) - 1;' is changed to 'month = ((date >> 5) - 1) & 15;'
variable 'month' will be equal to 15 (on zero date) instead of -1. Since day_n[15]==0 you
will get 315532800 (Jan 1 GMT 00:00:00 1980). So nothing to be fixed, I think.

I hope FAT filesystem will be fixed too some day :)

Thank you.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
