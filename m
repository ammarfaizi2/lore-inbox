Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132216AbRADTJM>; Thu, 4 Jan 2001 14:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132254AbRADTJD>; Thu, 4 Jan 2001 14:09:03 -0500
Received: from dns1.rz.fh-heilbronn.de ([141.7.1.18]:55591 "EHLO
	dns1.rz.fh-heilbronn.de") by vger.kernel.org with ESMTP
	id <S129557AbRADTIw>; Thu, 4 Jan 2001 14:08:52 -0500
Date: Thu, 4 Jan 2001 20:08:49 +0100 (CET)
From: Oliver Paukstadt <pstadt@stud.fh-heilbronn.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NFS-Root on AIX
In-Reply-To: <E14D9lv-00019l-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.05.10101042005210.3501-100000@lara.stud.fh-heilbronn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HY HY

I did some further tests with the Device-Number-Problem between Linux and
AIX when using AIX as NFS-Server for NFSroot-Boot.

The Devices finally all were created on the AIX.
FYI: 42*256=10752, 42*256+42=10794

AIX, oslevel 4.3.3.0
[aix4330]/home/root # ls -l /share/
total 0
crw-r--r--   1 root     system    42, 42 Jan 04 16:59 test1
crw-r--r--   1 root     system   10752,10752 Jan 04 17:00 test2
crw-r--r--   1 root     system   10794,10794 Jan 04 17:01 test3

FYI: system is uid 0 on this box.

Linux IA32 2.2.16
bash-2.04# ls -l /mnt/nfs/
total 0
crw-r--r--    1 root     root       0,  42 Jan  4 16:59 test1
crw-r--r--    1 root     root      42,   0 Jan  4 17:00 test2
crw-r--r--    1 root     root      42,  42 Jan  4 17:01 test3

Linux S/390 2.2.16
bash-2.04# ls -l /mnt/nfs/
total 0
crw-r--r--    1 root     root       0,  42 Jan  4 16:59 test1
crw-r--r--    1 root     root      42,   0 Jan  4 17:00 test2
crw-r--r--    1 root     root      42,  42 Jan  4 17:01 test3

Linux IA32 2.4.0-prerelease
bash-2.04# ls -l /mnt/nfs/
total 0
crw-r--r--    1 root     root      42,  42 Jan  4 16:59 test1
crw-r--r--    1 root     root       0,   0 Jan  4 17:00 test2
crw-r--r--    1 root     root      42,  42 Jan  4 17:01 test3


AIX seems to export 16-Bit-Device-Numbers and Linux imports only
8-Bit-Device-Numbers. In 2.2.X the Minor-Device-Number exported by AIX is
split in halves and becomes the 8-Bit Minor- _and_ Major-Device-Number.
In 2.4.x linux works correct, but shortens the Device-Numbers to 8-Bit-Values.

Linux S/390 shows that there is no difference in 2.2.16 running on little
oder bigendian machines.

All the tests where done with redhat 7 based system, including the S/390 ;-)

BYtE Oli

+++LINUX++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+++Manchmal stehe ich sogar nachts auf und installiere mir eins....+++++++
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ 
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
