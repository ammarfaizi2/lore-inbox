Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132470AbRDQNKb>; Tue, 17 Apr 2001 09:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132606AbRDQNKU>; Tue, 17 Apr 2001 09:10:20 -0400
Received: from thorin.y.ics.muni.cz ([147.251.61.126]:2309 "HELO
	charybda.fi.muni.cz") by vger.kernel.org with SMTP
	id <S132470AbRDQNKL>; Tue, 17 Apr 2001 09:10:11 -0400
From: Jan Kasprzak <kas@informatics.muni.cz>
Date: Tue, 17 Apr 2001 15:10:07 +0200
To: linux-kernel@vger.kernel.org
Subject: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417151007.F916@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I have discovered a possible problem on my host. The short
story is: When downloading ISO images from this host (which
runs 2.4.3 + zerocopy and ProFTPd with sendfile()), the image is
sometimes corrupted (MD5 checksum of the downloaded file does not match).

	The long story: My server is Athlon 850 on ASUS A7V, 256M RAM.
Seven IDE discs, one SCSI disc. The controllers and NIC are as follows
(output of lspci):

00:04.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
00:0a.0 SCSI storage controller: Adaptec AIC-7881U
00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
00:11.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 0d30 (rev 02)

	The server runs Linux 2.4.3 with zero-copy patches and ProFTPd
1.2.2rc1 compiled with --enable-sendfile.

	The FTP area is on RAID-1 volume, which is created over two LVM
partitions (each LV spans three physical disks). I hope RAID-1 can speed
things up for multiple simultaneous users.

	Yesterday the Red Hat Linux 7.1 has been released, and from that
time the server has about 220 anonymous FTP users and was pushing data
at almost full 100 Mbps ethernet speed (currently the 2hour average is
89.7 Mbps according to MRTG). Today I've got about three complains
about corrupted ISO images. When I run md5sum on the server itself,
the MD5 checksums, of course, perfectly match. I've tried to download
the files from another machine on the same net, and MD5 sums were correct.
However, I have one report of corrupted download even from the same physical
network.

	In the last 24 hours the server pushed out about 660 gigabytes
of Red Hat 7.1. Is this amount (i.e. three reports out of 660 gigabytes)
a serious problem?

	Also note that I have no corrupted download report for rsync.
But I think rsyncd does not use sendfile(), and of course vast majority
of people use FTP, not rsync, for downloading.

-Yenya

-- 
\ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
\\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
\\\             Czech Linux Homepage:  http://www.linux.cz/              ///
Mantra: "everything is a stream of bytes". Repeat until enlightened. --Linus
