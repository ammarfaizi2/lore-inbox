Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751528AbWFPWiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528AbWFPWiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWFPWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:38:20 -0400
Received: from terminus.zytor.com ([192.83.249.54]:38380 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751528AbWFPWiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:38:20 -0400
Message-ID: <449332CC.6070809@zytor.com>
Date: Fri, 16 Jun 2006 15:38:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Phillip Lougher <phil.lougher@gmail.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       phillip@lougher.demon.co.uk
Subject: Re: squashfs size in statfs
References: <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr>	 <e62cs9$csl$1@terminus.zytor.com>	 <Pine.LNX.4.61.0606151151020.9572@yvahk01.tjqt.qr> <cce9e37e0606161511p5fc33a8dtb63432060f9e3784@mail.gmail.com>
In-Reply-To: <cce9e37e0606161511p5fc33a8dtb63432060f9e3784@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Lougher wrote:
>> >
>> Yes, because CRAM does it that way, and maybe zisofs does it too:
> 
> Zisofs doesn't (H. Peter Anvin should know as he wrote it :-) ).
> 
> root@pierrot:/# ls -la dir.iso
> -rw-r--r--  1 root root 366592 2006-06-16 22:41 dir.iso
> root@pierrot:/# mount -t iso9660 dir.iso /mnt -o loop
> root@pierrot:/# df /mnt
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dir.iso                   358       358         0 100% /mnt
> root@pierrot:/# ls -la /mnt
> total 13
> drwxr-xr-x   2 root root     2048 2006-06-16 22:41 .
> drwxr-xr-x  32 root root     4096 2006-06-16 22:56 ..
> -rw-r--r--   1 root root 51200000 2006-06-16 22:40 zero
> 
> Statfs should return the size of the filesystem, not the amount of
> data the filesystem  represents.  In this respect the behaviour of
> Squashfs and Zisofs is correct.
> 
> This is analogous to performing stat on a gzipped file.  The stat
> returns the size of the compressed file, not the uncompressed size.
> 

A better analogy is it is like statting a sparse file on, say, an ext3 filesystem.  stat 
(ls -s) and statfs report the amount of storage consumed.

	-hpa

