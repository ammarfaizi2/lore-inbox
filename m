Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277797AbRJ3T4I>; Tue, 30 Oct 2001 14:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277818AbRJ3Tzs>; Tue, 30 Oct 2001 14:55:48 -0500
Received: from quimbies.gnus.org ([195.204.10.148]:30479 "EHLO
	quimbies.gnus.org") by vger.kernel.org with ESMTP
	id <S277729AbRJ3Tza>; Tue, 30 Oct 2001 14:55:30 -0500
X-Now-Playing: Peaches's _The Teaches of Peaches_: "Hot Rod"
To: linux-kernel@vger.kernel.org
Subject: nfs_lookup_validate and dud inodes
From: Lars Magne Ingebrigtsen <larsi@gnus.org>
Date: Tue, 30 Oct 2001 20:53:28 +0100
Message-ID: <m3zo68rjk7.fsf@quimbies.gnus.org>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.0.104
X-Face: &w!^oO<W.WBH]FsTP:P0f9X6M-ygaADlA_)eF$<UwQzj7:C=Gi<a?/_4$LX^@$Qq7-O&XHp
 lDARi8e8iT<(A$LWAZD*xjk^')/wI5nG;1cNB>~dS|}-P0~ge{$c!h\<y
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an nfs server and a diskless client, both running 2.2.19 under
Debian.  If I update files on the server, sometimes the client gets
confused about some files, and stays confused.  For instance:

[larsi@sparky ~]$ ls -l /lib/libe2*
ls: /lib/libe2p.so.2: Input/output error
-rw-r--r--    1 root     root        13400 Sep 22 17:15 /lib/libe2p.so.2.3

This is what it looks like on the server:

[larsi@quimbies ~]$ ls -l /tftpboot/sparky/lib/libe2p.so.2*
lrwxrwxrwx    1 root     root           13 Oct 30 20:23 /tftpboot/sparky/lib/libe2p.so.2 -> libe2p.so.2.3
-rw-r--r--    1 root     root        13400 Sep 22 17:15 /tftpboot/sparky/lib/libe2p.so.2.3

So the error message is when trying to access the symlink.

If I tell the nfs client to output debug messages:

# echo 65535 > /proc/sys/sunrpc/nfs_debug

I then get the following output:

nfs_lookup_validate: lib/libe2p.so.2 has dud inode
NFS: put_inode(1/1912607313)
NFS: lookup(lib/libe2p.so.2)
NFS call  lookup libe2p.so.2
NFS reply lookup: 0
NFS: nfs_fhget(lib/libe2p.so.2 fileid=1912607313)
NFS: __nfs_fhget(1/1912607313 ct=0)
NFS call  lookup n
NFS reply lookup: 0

(I think this is the relevant part; it spews out quite a lot of data.)

There are no error messages in any of the log files on the server.

Is this a known bug?

-- 
(domestic pets only, the antidote for overdose, milk.)
   larsi@gnus.org * Lars Magne Ingebrigtsen
