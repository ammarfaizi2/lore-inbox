Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWIFJ7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWIFJ7y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 05:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWIFJ7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 05:59:54 -0400
Received: from secure.htb.at ([195.69.104.11]:4621 "EHLO pop3.htb.at")
	by vger.kernel.org with ESMTP id S1750746AbWIFJ7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 05:59:53 -0400
Date: Wed, 6 Sep 2006 11:59:47 +0200
From: Richard Mittendorfer <delist@gmx.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Wrong free space reported for XFS filesystem
Message-Id: <20060906115947.7980f919.delist@gmx.net>
In-Reply-To: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com>
References: <9a8748490609060154ye8730b0n16e23524010a35e4@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
X-Face: &0P^N,K:@}b8ykW@3d!=n}3D;*Cf{9KYT>>+gcM)XyIMRkBSDg|ur7Zen^BlzmJVr&!;7KT6\t+sHI69\fW(}.=PM+(`w_jnzZ.HbWb/KM"`795_k(&\Lje|'g\cm$4e%Zy*I)hJz-z0!}xkm@!>U0rO{>~[YZUs/=B{}R%#nZ8eBt'{,*>kTTKl_kj'vzrl5|'j5SBiFy#!Sj,p_zl;)q.lpSI\Er"]D`bZY@#+']kJW/YsqvRzi0GR!7ifpt$?]0TYcNs.*wC5OukokPm~R&mmW\q&DL@='khZEET;3ryo[0_mC^K~7,ZvHkj
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach "Jesper Juhl" <jesper.juhl@gmail.com> (Wed, 6 Sep 2006
10:54:34 +0200):
> For your information;
> 
> I've been running a bunch of benchmarks on a 250GB XFS filesystem.
> After the benchmarks had run for a few hours and almost filled up the
> fs, I removed all the files and did a "df -h" with interresting
> results :
> 
> /dev/mapper/Data1-test
>                      250G  -64Z  251G 101% /mnt/test
> 
[...] 
> I then did an umount and remount of the filesystem and then things
> look more sane :
> 
> "df -h" :
> /dev/mapper/Data1-test
>                       250G  126M  250G   1% /mnt/test
[...]
> The filesystem is mounted like this :
> 
> /dev/mapper/Data1-test on /mnt/test type xfs
> (rw,noatime,ihashsize=64433,logdev=/dev/Log1/test_log,usrquota)

I once (2.6.12?) had to copy a quite large directory to an XFS
partition. It "should" had fit onto it (by what df said), but I ran into
"disk full". I think the reason was related to a large xfsbufd_centisecs
or xfssyncd_centisecs and indeed I could watch free space to grow and
shrink in regulaer intervals (watch df -k). I may well be wrong here (as
I'm sure no XFS-expert), but it looked like old data gets some kind of
"comressed" or "ordered" by the XFS-driver while newly written data took
more place. A "slow" copy did it, as well as a later try to an reiserfs
or ext.

sl ritch
