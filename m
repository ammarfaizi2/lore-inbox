Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278803AbRKKLpB>; Sun, 11 Nov 2001 06:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280751AbRKKLov>; Sun, 11 Nov 2001 06:44:51 -0500
Received: from rztsun.rz.tu-harburg.de ([134.28.200.14]:4486 "EHLO
	rztsun.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id <S278803AbRKKLom>; Sun, 11 Nov 2001 06:44:42 -0500
Date: Sun, 11 Nov 2001 12:41:34 +0100
To: linux-kernel@vger.kernel.org,
        ReiserFS Mailingliste <reiserfs-list@namesys.com>
Subject: NFS dropouts with <=2.4.15pre1 + ReiserFS
Message-ID: <20011111124134.E6421@jensbenecke.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	ReiserFS Mailingliste <reiserfs-list@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.15i
X-FAQ-is-At: http://www.linuxfaq.de/
X-No-Archive: Yes
X-Operating-System: Linux 2.4.15-pre1-jb-gr
From: Jens Benecke <jens@jensbenecke.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

both to linux-kernel and reiserfs-list because currently I don't know who
to blame. It should be related to ReiserFS + NFS however, because I can FTP
between the systems and get 8-9MByte/sec.

I have two machines, ds9 (workstation) and server (well..), running
2.4.15pre1. The server was patched with grsecurity (www.grsecurity.net),
the workstation was patched with Win4lin (commercial, www.netraverse.com).

As I said, FTP works fine. But when I copy something via NFS, performance
is about a third to a fifth of the FTP performance - AND, from time to time
(I'd say every 200-300MByte) NFS throughput drops out completely.

I turned on NFSd debugging and got lots and lots of "fh_verify",
"fh_compose" etc messages in the kernel and found something very curious:

	Whenever my iptables packet filter would log denied packets, NFS
	would drop out for a couple seconds to a couple minutes - then
	resume operations. My NFS client told me "nfs server not
	responding, NFS server OK" a couple times.

This seems reproducable with a little effort - so I'd be happy to help
debugging this (and the bad performance ;) if anybody tells me where to
start. As I said, with 'echo 9 > nfsd_debug' I got megabytes of logs filled
with nfsd_dispatch, fh_verify, fh_compose, last message repeated 295 times,
etc. but nothing that (for me) pointed to an error situation.

The same happened with all 2.4 kernels I tried so far, as far as I can
remember.

Thanks in advance!


-- 
Jens Benecke ········ http://www.hitchhikers.de/ - Europas Mitfahrzentrale
