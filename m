Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWGZAhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWGZAhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 20:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWGZAhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 20:37:23 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:25597 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932509AbWGZAhX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 20:37:23 -0400
Date: Tue, 25 Jul 2006 17:36:12 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: David Masover <ninja@slaphack.com>
cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Mike Benoit <ipso@snappymail.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Hans Reiser <reiser@namesys.com>, lkml@lpbproductions.com,
       Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <44C6B784.5050507@slaphack.com>
Message-ID: <Pine.LNX.4.63.0607251732001.9159@qynat.qvtvafvgr.pbz>
References: <200607242151.k6OLpDZu009297@laptop13.inf.utfsm.cl>
 <44C6B784.5050507@slaphack.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006, David Masover wrote:

> Horst H. von Brand wrote:
>
>> 18GiB = 18 million KiB, you do have a point there. But 40 million files on
>> that, with some space to spare, just doesn't add up.

if you have 18 million KiB and each file is a single block (512 Bytes = 0.5 Kib) 
then assuming zero overhead you could fit 18 Million KiB / 0.5 KiB = 36 Million 
files on the drive.

thus being scheptical about 40 million files on a 18G drive.

this is only possible if you are abel to have multiple files per 512 byte block.

David Lang

> Right, ok...
>
> Here's a quick check of my box.  I've explicitly stated which root-level
> directories to search, to avoid nfs mounts, chrooted OSes, and virtual
> filesystems like /proc and /sys.
>
> elite ~ # find /bin/ /boot/ /dev/ /emul/ /etc/ /home /lib32 /lib64 /opt
> /root /sbin /tmp /usr /var -type f -size 1 | wc -l
> 246127
>
> According to the "find" manpage:
>
> -size n[bckw]
>      File uses n units of space.  The units are  512-byte  blocks  by
>      default  or  if `b' follows n, bytes if `c' follows n, kilobytes
>      if `k' follows n, or 2-byte words if `w' follows  n.   The  size
>      does  not  count  indirect  blocks,  but it does count blocks in
>      sparse files that are not actually allocated.
>
>
> And I certainly didn't plan it that way.  And this is my desktop box,
> and I'm just one user.  Most of the space is taken up by movies.
>
> And yet, I have almost 250k files at the moment whose size is less than
> 512 bytes.  And this is a normal usage pattern.  It's not hard to
> imagine something prone to creating lots of tiny files, combined with
> thousands of users, easily hitting some 40 mil files -- and since none
> of them are movies, it could fit in 18 gigs.
>
> I mean, just for fun:
>
> elite ~ # find /bin/ /boot/ /dev/ /emul/ /etc/ /home /lib32 /lib64 /opt
> /root /sbin /tmp /usr /var | wc -l
> 866160
>
> It may not be a good idea, but it's possible.  And one of the larger
> reasons it's not a good idea is that most filesystems can't handle it.
> Kind of like how BitTorrent is a very bad idea on dialup, but a very
> good idea on broadband.
>
>
