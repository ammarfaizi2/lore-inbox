Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268120AbTAJDAk>; Thu, 9 Jan 2003 22:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268119AbTAJDAk>; Thu, 9 Jan 2003 22:00:40 -0500
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:11255 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S268120AbTAJDAj>; Thu, 9 Jan 2003 22:00:39 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15902.14667.489252.346007@wombat.chubb.wattle.id.au>
Date: Fri, 10 Jan 2003 14:08:59 +1100
To: eric@andante.org
CC: linux-kernel@vger.kernel.org
Subject: ISO-9660 Rock Ridge gives different links different inums
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence" XEmacs Lucid
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In linux 2.5.54, multiple links to the same file on a rock-ridge CD
have different inode numbers.  This confuses cpio, tar and cp -ra
because the multiple links are each copied separately as a single file.

It'll probably also confuse NFS, but I haven't tried that.

Example from the knoppix CD:

$ ls -il gunzip gzip uncompress zcat
1896278 -rwxr-xr-x    4 root     root        49256 Oct 10 01:31 gunzip
1896564 -rwxr-xr-x    4 root     root        49256 Oct 10 01:31 gzip
1902292 -rwxr-xr-x    4 root     root        49256 Oct 10 01:31 uncompress
1902856 -rwxr-xr-x    4 root     root        49256 Oct 10 01:31 zcat

(For comparison, here's what I see on XFS:
100663485 -rwxr-xr-x    4 root     root        49288 Nov  7 11:37 gunzip
100663485 -rwxr-xr-x    4 root     root        49288 Nov  7 11:37 gzip
100663485 -rwxr-xr-x    4 root     root        49288 Nov  7 11:37 uncompress
100663485 -rwxr-xr-x    4 root     root        49288 Nov  7 11:37 zcat
)


Currently the inode number appears to be the offset in bytes from the start of
the file system to the iso directory entry.  Files with multiple
directory entries (i.e., links) therefore have different inums.

I don't know enough about the ISO9660 standard to be sure what's best
to do about this.

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
