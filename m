Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265673AbSKAKRI>; Fri, 1 Nov 2002 05:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265674AbSKAKRH>; Fri, 1 Nov 2002 05:17:07 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:33035 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S265673AbSKAKRH>; Fri, 1 Nov 2002 05:17:07 -0500
Date: Fri, 1 Nov 2002 11:23:27 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Hans Reiser <reiser@namesys.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       zam@namesys.com, umka <umka@thebsh.namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
Message-ID: <20021101102327.GA26306@louise.pinerecords.com>
References: <3DC19F61.5040007@namesys.com> <200210312334.18146.Dieter.Nuetzel@hamburg.de> <3DC1B2FA.8010809@namesys.com> <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC1DF02.7060307@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The atomic transactions that reiser4 offers are a much higher level of 
> data security than data journaling.  Really, you should read the 17 page 
> papers I send you URLs to;-).....
> (www.namesys.com/v4/fast_reiser4.html).

Am I to assume the following is expected behavior then?

# mkfs.reiser4 /dev/sda2
mkfs.reiser4, 0.1.0
Information: Reiser4 is going to be created on /dev/sda2.
(Yes/No): y
Creating reiser4 on /dev/sda2 with default40 profile...done
Synchronizing /dev/sda2...done
# mount /dev/sda2 /ap
# df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332       136   1490196   1% /ap
# (cd /ap && tar xzf /usr/src/linux-2.5.45.tgz)
# df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332    200508   1289824  14% /ap
# sync
# df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332    200468   1289864  14% /ap
# rm -rf /ap/linux-2.5.45
# df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332    255436   1234896  18% /ap
# # wtf is going on here?
# sync
# df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332     85848   1404484   6% /ap
# umount /ap
# mount /dev/sda2 /ap
# df /ap
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda2              1490332     54532   1435800   4% /ap
# # and here?

T.
