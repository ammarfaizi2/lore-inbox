Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290017AbSAQQsX>; Thu, 17 Jan 2002 11:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290027AbSAQQsN>; Thu, 17 Jan 2002 11:48:13 -0500
Received: from L0563P10.dipool.highway.telekom.at ([62.46.134.74]:16000 "EHLO
	pitt.yi.org") by vger.kernel.org with ESMTP id <S290024AbSAQQsF>;
	Thu, 17 Jan 2002 11:48:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christoph Pittracher <pitt@gmx.at>
Organization: PITT
Message-Id: <200201171736.25266@pitt4u.2y.net>
To: linux-kernel@vger.kernel.org
Subject: ncpfs input/output error
Date: Thu, 17 Jan 2002 17:48:02 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
I've a problem with writing to a netware volume from a linux client. 
The server is a novell netware 4. Mounting the netware volume and 
reading data from the server works without problems. But if i want to 
write a file to the server that is bigger than 128kb I get an I/O-error 
(sometimes it's possible to write a file with more than 128kb but then 
the I/O-error occurs at 256kb, or 283kb sometimes after storing 192kb 
of the data).

workstation:~$ mount
/dev/hda2 on / type ext2 (rw,errors=remount-ro,errors=remount-ro)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
FST01/NETWARE.USER on /home/netware-user type ncpfs (rw)
workstation:~$

The netware volume is mounted to /home/netware-user (with 
uid=netware-user and gid=netware, a local linux user).

workstation:~$ cp /home/wk/linux-2.4.17.tar.bz2 /home/netware-user
cp: writing `./linux-2.4.17.tar.bz2': Input/output error
workstation:~$

Now have a look at the file size on the server:

workstation:~$ ls -al /home/netware-user/linux-2.4.17.tar.bz2
-rwxr-xr-x    1 netware- netware    262144 Jan 17 15:00 
linux-2.4.17.tar.bz2
workstation:~$

strace output of the cp command:
workstation:~$ strace cp /home/wk/linux-2.4.17.tar.bz2 
/home/netware-user
[...]
read(3, "i1L@a\216\27\212Dva\200\344\'.O\306\331\257\232;\367\375"..., 
512)
= 512
write(4, "i1L@a\216\27\212Dva\200\344\'.O\306\331\257\232;\367\375"..., 
512)
= 512
read(3, "\337\375\337\341\273\257\344\n\264\0302%\231\337\233\261"..., 
512)
= 512
write(4, "\337\375\337\341\273\257\344\n\264\0302%\231\337\233\261"..., 
512)
= -1 EIO (Input/output error)
[...]

I don't know why this write fails...
Any hints?

Some version information:
workstation:~$ ncpmount -v
ncpfs version 2.2.0.18
workstation:~$

workstation:~$ uname -r
2.4.17
workstation:~$

NCPFS specific kernel configurations:
CONFIG_NCP_FS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_NCPFS_NLS=y
CONFIG_NCPFS_EXTRAS=y

Please tell me if you need any additional information.

Thanks,
Christoph
