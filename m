Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWFPWLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWFPWLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWFPWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:11:16 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:11653 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751273AbWFPWLP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:11:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sEvauxBiku+rbhAQkdytO2kceRzVGDFXo2G2AgO9AkEBpprhLwXyAScRJmAt20yuyGG4cOiWVSXa23AYixACfqMa1VkLmw2ktastsIkvFiy/lD4kkQsYblmS80V92/hAATuLqMNfgibqMMiiCmtLQDWfVix8b4UqDUNcV+I5S+o=
Message-ID: <cce9e37e0606161511p5fc33a8dtb63432060f9e3784@mail.gmail.com>
Date: Fri, 16 Jun 2006 23:11:14 +0100
From: "Phillip Lougher" <phil.lougher@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: squashfs size in statfs
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
       phillip@lougher.demon.co.uk
In-Reply-To: <Pine.LNX.4.61.0606151151020.9572@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.61.0606051243100.579@yvahk01.tjqt.qr>
	 <e62cs9$csl$1@terminus.zytor.com>
	 <Pine.LNX.4.61.0606151151020.9572@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Hello list,
> >>
> >>
> >> # l /mnt
> >> total 36293
> >> drwxr-xr-x   2 root root       20 Jun  5 11:50 .
> >> drwxr-xr-x  31 root root     4096 Jun  5  2006 ..
> >> -rw-r--r--   1 root root 37158912 Jun  5 11:06 mem
> >> # df
> >> Filesystem           1K-blocks      Used Available Use% Mounted on
> >> /dev/shm/sc.sqfs         26688     26688         0 100% /mnt
> >> # l sc.sqfs
> >> -rwx------  1 jengelh users 27279360 Jun  5 11:50 sc.sqfs
> >>
> >> I think statfs() should show the uncompressed size, no?
> >
> >No.
> >
> Yes, because CRAM does it that way, and maybe zisofs does it too:

Zisofs doesn't (H. Peter Anvin should know as he wrote it :-) ).

root@pierrot:/# ls -la dir.iso
-rw-r--r--  1 root root 366592 2006-06-16 22:41 dir.iso
root@pierrot:/# mount -t iso9660 dir.iso /mnt -o loop
root@pierrot:/# df /mnt
Filesystem           1K-blocks      Used Available Use% Mounted on
/dir.iso                   358       358         0 100% /mnt
root@pierrot:/# ls -la /mnt
total 13
drwxr-xr-x   2 root root     2048 2006-06-16 22:41 .
drwxr-xr-x  32 root root     4096 2006-06-16 22:56 ..
-rw-r--r--   1 root root 51200000 2006-06-16 22:40 zero

Statfs should return the size of the filesystem, not the amount of
data the filesystem  represents.  In this respect the behaviour of
Squashfs and Zisofs is correct.

This is analogous to performing stat on a gzipped file.  The stat
returns the size of the compressed file, not the uncompressed size.

Phillip
