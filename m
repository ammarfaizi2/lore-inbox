Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVFQJNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVFQJNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 05:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbVFQJNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 05:13:08 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:40414 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261924AbVFQJNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 05:13:04 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Lukasz Stelmach <stlman@poczta.fm>, mru@inprovide.com,
       Patrick McFarland <pmcfarland@downeast.net>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 17 Jun 2005 11:12:43 +0200
References: <4eUwr-7i7-33@gated-at.bofh.it> <4ffAV-72e-11@gated-at.bofh.it> <4fBrR-7eO-31@gated-at.bofh.it> <4fBUW-7wi-19@gated-at.bofh.it> <4fCe4-7Rm-11@gated-at.bofh.it> <4fCHg-89R-29@gated-at.bofh.it> <4fHxo-3Lo-63@gated-at.bofh.it> <4fNMd-l6-25@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DjCu5-0001jc-Nl@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:

> What do you do if the underlying filesystem can not store some unicode
> characters that are allowed on others?

On vfat:
open("/e/a:b", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0666) = -1 EINVAL

> VFAT uses unicode?  I thought it used the same codepage silyness as FAT
> did, since after all ti was just supposed to be a long filename
> extension to FAT.  Do they use unicode in the long filenames only?

It uses two codepages, one for short names and one for long names.
The long name charset defaults to iso-8859-1, and the short one to cp437

$ dd if=/dev/zero of=img bs=512 count=90
$ mkfs.msdos img
$ mount -oloop img /x
$ touch /x/testäöüßtest
$ umount /x
$ hex<img
...
0600  41 74 00 65 00 73 00 74  00 e4 00 0f 00 db f6 00  At.e.s.t ........
0610  fc 00 df 00 74 00 65 00  73 00 00 00 74 00 00 00  ....t.e. s...t...
0620  54 45 53 54 8e 99 7e 31  20 20 20 20 00 00 d0 58  TEST..~1     ...X
0630  d1 32 d1 32 00 00 d0 58  d1 32 00 00 00 00 00 00  .2.2...X .2......

-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
