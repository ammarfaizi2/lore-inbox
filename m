Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSFAL2O>; Sat, 1 Jun 2002 07:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316586AbSFAL2O>; Sat, 1 Jun 2002 07:28:14 -0400
Received: from khms.westfalen.de ([62.153.201.243]:47555 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S316576AbSFAL2N>; Sat, 1 Jun 2002 07:28:13 -0400
Date: 01 Jun 2002 13:12:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Message-ID: <8Q3lFMgmw-B@khms.westfalen.de>
In-Reply-To: <ad8bvv$3tr$1@penguin.transmeta.com>
Subject: Re: do_mmap
X-Mailer: CrossPoint v3.12d.kh9 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 31.05.02 in <ad8bvv$3tr$1@penguin.transmeta.com>:

> In article <1022855243.12888.410.camel@irongate.swansea.linux.org.uk>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >On Fri, 2002-05-31 at 14:00, Thomas 'Dent' Mirlacher wrote:
> >> and the checks in various places are really strange. - well some
> >> places check for:
> >> 	o != NULL
> >> 	o > -1024UL
> >
> >"Not an error". Its relying as some other bits of code do actually that
> >the top mappable user address is never in the top 1K of the address
> >space
> >
> >> is it possible to have 0 as a valid address? - if not, this should
> >> be the return on errors.
> >
> >SuS explicitly says that 0 is not a valid mmap return address.
>
> But if so, SuS is _very_ _very_ wrong.

[...]

> and if SuS says that mmap must not return NULL for this case, then SuS
> is so full of sh*t that it's not worth worrying about.

Actually, at least SuSv3 does not say any such thing. *What* it says is  
that the return is either MAP_FAILED or the correct address, and that if  
it is called *without* MAP_FIXED, then the argument 0 has special meaning,  
and it won't map something at 0 (and thus return 0) - which, AFAICT, is  
exactly what we want it to say. Specifically, NULL is *never* an error  
return value for mmap.

At least, unless we define MAP_FAILED to be NULL - traditionally, it's  
(void *)-1 probably exactly so it is possible to return an address of 0.

See <http://www.opengroup.org/onlinepubs/007904975/functions/mmap.html>.

MfG Kai
