Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbTAVKYV>; Wed, 22 Jan 2003 05:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267418AbTAVKYU>; Wed, 22 Jan 2003 05:24:20 -0500
Received: from smtp1.BelWue.de ([129.143.2.12]:60384 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id <S267417AbTAVKYT>;
	Wed, 22 Jan 2003 05:24:19 -0500
Date: Wed, 22 Jan 2003 11:33:22 +0100 (MET)
From: Oliver Tennert <tennert@science-computing.de>
To: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
cc: kw@science-computing.de
Subject: NFS client problem and IO blocksize
Message-ID: <Pine.GHP.4.02.10301221121260.4286-100000@alderaan.science-computing.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I sem to have a problem with a 2.4.20 kernel + Trond's NFS client patches
+ some of Neil Brown's server patches.

The problem seems to be restricted to NFS client functionality, though, as
it also occurs when the NFS server is a totally different platform.

The problem is that the rsize/wsize options seem to be ignored:

hal9000:/home/tennert # mount -o nfsvers=3,udp,rsize=1024,wsize=1024
ilka2000:/scr /mnt
hal9000:/home/tennert # stat /mnt/Snatch.avi 
  File: `/mnt/Snatch.avi'
  Size: 724893696       Blocks: 1415816    IO Block: 4096   Regular File

hal9000:/home/tennert # umount /mnt
hal9000:/home/tennert # mount -o nfsvers=3,udp,rsize=8192,wsize=8192
ilka2000:/scr /mnt
hal9000:/home/tennert # stat /mnt/Snatch.avi 
  File: `/mnt/Snatch.avi'
  Size: 724893696       Blocks: 1415816    IO Block: 4096   Regular File

hal9000:/home/tennert # umount /mnt
hal9000:/home/tennert # mount -o nfsvers=3,udp,rsize=32768,wsize=32768
ilka2000:/scr /mnt
hal9000:/home/tennert # stat /mnt/Snatch.avi 
  File: `/mnt/Snatch.avi'
  Size: 724893696       Blocks: 1415816    IO Block: 4096   Regular File

If TCP instead of UDP is taken as transport protocol, the behaviour is
still the same, i.e. the IO blocksize of the file does not change at all!

In this case the underlying physical file system is XFS.

Beware! I don't think the NFS server is to blame, because (with different
client machines and same kernel ) I get the same behaviour when the NFS
server platform is AIX, e.g.

It also occurred (on an older installation) that if the rsizw/wsize is
taken very small, e.g. 512 or 1024 Byte, a listing of the directory fails
to show any files at all, although the mount worked well.

Could you help me any further?

Best regards

Oliver 

		   Dr. Oliver Tennert
                    
  		   +49 -7071 -9457-598
                          
 		   e-mail: O.Tennert@science-computing.de
  		   science + computing AG
  		   Hagellocher Weg 71                  
   		   D-72070 Tuebingen                  
                                     


