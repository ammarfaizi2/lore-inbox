Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbQLMVKS>; Wed, 13 Dec 2000 16:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131718AbQLMVKJ>; Wed, 13 Dec 2000 16:10:09 -0500
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:7697 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131525AbQLMVJz>; Wed, 13 Dec 2000 16:09:55 -0500
Date: Wed, 13 Dec 2000 21:37:17 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: Slow NFS mounting with 2.2.18
Message-ID: <20001213213717.A9885@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 0 d, 23:52:59 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

After changing kernels from 2.2.17 to 2.2.18 I found that NFS
mounts now take ages. (Well, 15 seconds.) With 2.2.17, they went
through in about half a second. Once the mount is done, all
operations seem to run with the usual speed.

The client is vanilla 2.2.18, the server is vanilla 2.2.17.
The fs to mount from the server is reiserfs, as is the mount
point on the client. Both machines are connected to each other
and nothing else.

I tried 2.2.18's nfs module both with and without NFSv3 support.

syslog on the client:
Dec 13 21:26:22 christian automount[9814]: attempting to mount entry /mnt/mp3
Dec 13 21:26:22 christian automount[9964]: lookup(file): looking up mp3
Dec 13 21:26:22 christian automount[9964]: lookup(file): mp3 -> -ro,rsize=8192^I
Dec 13 21:26:22 christian automount[9964]: parse(sun): expanded entry: -ro,rsize
Dec 13 21:26:22 christian automount[9964]: parse(sun): dequote("ro,rsize=8192^I^
Dec 13 21:26:22 christian automount[9964]: parse(sun): gathered options: ro,rsiz
Dec 13 21:26:22 christian automount[9964]: parse(sun): dequote("ser1:/mnt/mp3") 
Dec 13 21:26:22 christian automount[9964]: parse(sun): core of entry: options=ro
Dec 13 21:26:22 christian automount[9964]: parse(sun): mounting root /mnt, mount
Dec 13 21:26:22 christian automount[9964]: mount(nfs):  root=/mnt name=mp3/ what
Dec 13 21:26:22 christian automount[9964]: mount(nfs): nfs options="ro,rsize=819
Dec 13 21:26:22 christian automount[9964]: mount(nfs): calling mkdir_path /mnt/m
Dec 13 21:26:22 christian automount[9964]: mount(nfs): calling mount -t nfs -s -
Dec 13 21:26:22 christian kernel: nfs warning: mount version older than kernel
Dec 13 21:26:27 christian kernel: portmap: too small RPC reply size (0 bytes)
Dec 13 21:26:37 christian automount[9964]: mount(nfs): mounted ser1:/mnt/mp3 on 
Dec 13 21:26:37 christian kernel: portmap: too small RPC reply size (0 bytes)

syslog on the server:

Dec 13 21:26:23 ser1 mountd[153]: NFS mount of /mnt/mp3 attempted from 192.168.0.2 
Dec 13 21:26:23 ser1 mountd[153]: /mnt/mp3 has been mounted by 192.168.0.2 

The server's clock is about one second ahead, so it looks as if the
server completed the job in the same second, and the client slept
for a while. The mount process stayed in D state all the time.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
