Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283282AbRK2PuI>; Thu, 29 Nov 2001 10:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283286AbRK2Pt6>; Thu, 29 Nov 2001 10:49:58 -0500
Received: from c0mailgw.prontomail.com ([216.163.180.10]:20946 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S283282AbRK2Ptw>; Thu, 29 Nov 2001 10:49:52 -0500
X-Version: gilat2home 7.5.3345.0
From: "war war" <war@starband.net>
Message-Id: <B7F1F9B7DE30EDF47ADB4F8F44CAC84B@war.starband.net>
Date: Thu, 29 Nov 2001 10:46:40 -0500
X-Priority: Normal
Content-Type: text/plain; charset=iso-8859-1
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.16 & Heavy I/O
CC: war@starband.net
X-Mailer: Web Based Pronto
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Issue:

Is it possible to set the disk cache size to a higher value to avoid 
temporary freezing while untarring large files?  Memory is not an 
issue, I have plenty of it.  The disk drive is a good drive, does 
29.2MB/s sustained in single user mode, 25MB/s when I have a lot of 
processes open.  Here is what I think is going on.  Sometimes, when I 
untar things, or do things that consume a lot of disk space rapidly, 
they do it VERY quickly, and then the disk rumbles on for 5-20 
seconds after it is done.  What accounts for this?

Example:

[20:10]% tar -xf 2GB-FILE.tar
[20:30]% # Hard disk is still grinding.
[20:60]% # Hard disk stops grinding.

In essence, the 'tar' command is finished, however, 30-60 seconds 
after it has finished, it is actually still decompressing the data to 
the file on the disk.

I have not tested ALL kernels for when or where this has started, but 
could someone provide a further explanation as to why the disk 
scheduluer works like this?

On Solaris, when I untar a file, the disk stops grinding when the tar 
process is finished, and the system is totally usuable.

With Linux, when I untar the file, the system may completely lock up 
for 3-5 seconds during the duration after the initial untar (which is 
30-60 seconds) after the untar processes has ended.

System Setup: P3/866
              1GB RAM
              2GB SWAP
              Kernel 2.4.16

Result:

Just read this [bottom] after trying to burn 2 CD's (luckily on 
CDRW's) at the same time on two different IDE bus controllers while 
untarring a 1.6GB file.  With earlier kernels, this is usually not a 
problem.

CDRW1 = Plextor v1.09
CDRW2 = HP 7510i

Burnproof kicked in for the Plextor, I love Plextor drives.
With the HP, it didn't have enough data to fill the buffer, and 
therefore caused a buffer underrun, easy to blank=toc and re-write 
however.

http://lwn.net/2001/1129/kernel.php3

The current stable kernel release is 2.4.16. This release, the first 
by Marcelo Tosatti, contains little beyond the filesystem fix. This 
release does seem to deserve the name "stable," though there are 
still some persistent complaints about interactive response in the 
presence of heavy I/O. The culprit appears to be the disk I/O 
scheduler; a real fix for that problem could be long in coming. The 
2.4.17-pre1 prepatch contains a number of items including a new USB 
maintainer and a devfs update. 
