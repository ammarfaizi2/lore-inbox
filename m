Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262866AbVHEGI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262866AbVHEGI3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVHEGI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:08:29 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:2995 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262866AbVHEGI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:08:27 -0400
Date: Fri, 5 Aug 2005 08:08:07 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Phillip Lougher <phil.lougher@gmail.com>
cc: plougher@users.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: squashfs seems nfs-incompatible
In-Reply-To: <cce9e37e050804083347c138d4@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0508050804090.19610@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0508021710590.4634@yvahk01.tjqt.qr>
 <cce9e37e050804083347c138d4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> I found out that you cannot mount an exported squash fs. The exports(5) fsid=
>> parameter does not help it [like it did with unionfs].
>
>The exports(5) man page says fsid=num is necessary for filesystems on
>non-block devices - I don't know whether this includes loopback
>filesystems.  Have you tried exporting a Squashfs filesystem mounted
>on a real block device?

Loopback is a real block device, and no, fsid= does not help it. I have talked 
with the unionfs people, because it works for them. After a short flash of 
idea and comparison, it turns out that squashfs is missing 
sb->s_export->get_parent (the only requirement as it seems). Includes that you 
have sb->s_export non-null, of course. sb->s_export can be set within 
fill_super().

>I've never tried to export a Squashfs filesystem, and so I don't know
>if it works.  If it doesn't, I would say it is because Squashfs (like
>Cramfs) doesn't store correct nlink information for directories.
>
>The next release does store nlink information, has support for > 4GB
>files/filesystems, and other nice improvements.  I'm hoping to release
>an alpha release soon.

FTR, I currently cheated by using
`mount -t unionfs -o dirs=/squash=ro none /squash` to get the export working.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
