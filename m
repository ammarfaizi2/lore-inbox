Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbTGLDtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 23:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbTGLDtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 23:49:42 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:34527
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S267548AbTGLDtk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 23:49:40 -0400
Date: Sat, 12 Jul 2003 06:05:06 +0200
From: Voluspa <lista1@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 does not boot - TCQ oops
Message-Id: <20030712060506.0b152432.lista1@telia.com>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-07-11 20:58:09 Ivan Gyurdiev wrote:

> Patch confirmed to work - the machine boots.
[...]
> Most massive fs corruption I've ever had.
[...]
> I blamed the reiserfs bk work at first (which I applied along with
> [Axboe's] tcq patch), but I noted that the fs only gets corrupted
> with a tcq-enabled kernel

I took home 2.5.75-bk1, applied the tcq patch and then used the computer
for five hours in the TCQ+TASKFILE environment. Filesystem is ext2.

Untarred a kernel. Copied it to a couple of destinations. Compiled.
Listened to music. Watched part of a movie. Did a nfs move of a file
(which by the way was a pure horror... 600k in ca 3 minutes) from a
machine with a 2.2.16 kernel. Then read about your woes.

Checked the md5sum of a large file that I keep for... corruption checks.
Was ok. Did a read massage by "cd /usr ; find . -type f -exec md5sum {}
\;". No hickups. Except...

Found 1 error in /var/log/kernel that I _never_ get with the 2.4.19:
Jul 12 02:03:39 loke kernel: hda: status error: status=0x48 { DriveReady
DataRequest }
Jul 12 02:03:39 loke kernel: 
Jul 12 02:03:39 loke kernel: hda: drive not ready for command

So I shut down X in preparation for a reboot and full fs check, waiting
for the distributed project foldingathome to checkpoint its work, and
there was another never experienced error (time is UTC):

[01:10:00] [SPG] 100.0 % 
[01:10:00] [SPG] Writing current.xyz                                   
[01:10:01] [SPG] Sequence 15 completed:                                
[01:10:01] SNEYSGTFSFKTKQSKDEMLDALQIKNSYISQMRQITPKMAIEYPKGTPT . . .    
[01:10:01] - Error: Checksums don't match (work/wudata_06.arc)
[01:10:01] [SPG] Error: checksum error                                 
[01:10:02] CoreStatus = 0 (0)
[01:10:02] Client-core communications error: ERROR 0x0
[01:10:02] Deleting current work unit & continuing...

The reboot didn't reveal any fs corruption. Still, I've returned to a
safe kernel :-) Disk where TCQ was enabled (using depth 8)
is a IBM-DTLA-307015. Unfortunately, or luckily, my 
IC35L080AVVA07-0 shares its life with a CD, so no TCQ there.

Mvh
Mats Johannesson
