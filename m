Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290296AbSAPAL5>; Tue, 15 Jan 2002 19:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290292AbSAPALr>; Tue, 15 Jan 2002 19:11:47 -0500
Received: from tangens.hometree.net ([212.34.181.34]:23486 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S290298AbSAPALg>; Tue, 15 Jan 2002 19:11:36 -0500
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Removing the whitespaces??? [Was: Re: Why not "attach" patches?]
Date: Wed, 16 Jan 2002 00:11:35 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <a22gfn$c15$1@forge.intermeta.de>
In-Reply-To: <Pine.LNX.4.33.0201151448050.5892-100000@xanadu.home> <Pine.LNX.4.33.0201151405250.9053-100000@segfault.osdlab.org> <20020115151629.N11251@lynx.adilger.int>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1011139895 29424 212.34.181.4 (16 Jan 2002 00:11:35 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Wed, 16 Jan 2002 00:11:35 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> writes:

>Well, it would be a feature if it knew enough to only remove whitespace
>at the end of "+" lines in context diffs.  Then we wouldn't have 200kB
>of useless whitespace in the kernel sources.

apply patches. Run this. Rinse. Repeat. :-)

--- cut ---

mkdir /usr/src/linux.noblanks

(
  cd /usr/src/linux
  find . -type d -exec mkdir -p /usr/src/linux.noblanks/{} \;
  for i in `find . -type f`; do
    perl -ne 's/[        ]+$//; print;' < ${i} > /usr/src/linux.noblanks/${i}
  done
)

diff -ur /usr/src/linux /usr/src/linux.noblanks | mail -s "blanks removed" torvalds@transmeta.com 

rm -rf /usr/src/linux.noblanks
--- cut ---

(This is a TAB and a space in the square brackets above. 
Don't use \s. Trust me.)

linux-2.2.20.tar.bz2:		15,751,285 bytes
linux-2.2.20-nbl.tar.bz2:       15,608,085 bytes

Patch Size (uncompressed):	17,815,166 bytes (yes this _is_ 17,4 MBytes)
           (compressed, bzip2):  3,322,456 bytes 

One mega-patch to shear off about 140 KBytes from the compressed (and
about 170 k from the unpacked (94488 vs. 94316 KBytes ) kernel source
would (while it may be the biggest single "reduce-size-of-kernel-tree
patch" in years :-) ) a little gross.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
