Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129379AbQLAR6f>; Fri, 1 Dec 2000 12:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129351AbQLAR6P>; Fri, 1 Dec 2000 12:58:15 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:12278 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S129385AbQLAR5l>; Fri, 1 Dec 2000 12:57:41 -0500
Date: Fri, 01 Dec 2000 14:13:10 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: 'holey files' not holey enough.
To: Andreas Dilger <adilger@turbolinux.com>
Cc: Adam <adam@cfar.umd.edu>, linux-kernel@vger.kernel.org
Message-id: <3A27B1F6.48E959BE@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <200011292334.eATNYNB09518@webber.adilger.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> Marc Mutz writes:
> > kernel 2.2.17, '/' being a 1k blocksize ext2fs:
> >
> > root@adam:/ > dd if=/dev/zero of=holed.file bs=1000 seek=5000 count=1000
> > 1000+0 records in
> > 1000+0 records out
> > root@adam:/ > ls -l holed.file
> > -rw-r--r--   1 root     root      6000000 Nov 29 23:33 holed.file
> > root@adam:/ > du -sh holed.file
> > 5.7M    holed.file
> 
> Strangely, I have 2.2.17 (TurboLinux patched), on a 1k filesystem and
> I have no problems.  I have 1k, 2k, and 4k ext2 fs, all OK.
> 
> What people who have the problem should be doing is:
> > ls -li holed.file        # find inode number
> 10732 -rw-r--r--    1 root     root      6000000 Nov 29 16:17 holed.file
> > du -sk holed.file        # see what "stat" thinks
> 983k    holed.file

dito

> > debugfs /dev/XXX
> debugfs> stats           # find out ext2 block size
> ...
> Block size = 1024, fragment size = 1024
> ...

dito

> Links: 1   Blockcount: 1966

dito

> TOTAL: 983

dito

> If what debugfs says doesn't match du, then it is du/libc/stat that is
> broken.  If debugfs says the file actually has 6000000 bytes of data,
> then it is the filesystem that is broken.
> 
$ du --version
du (GNU fileutils) 3.16
$ ls -l /lib/libc*
lrwxrwxrwx   1 root     root           13 May  8  1999 /lib/libc.so.4 \
-> libc.so.4.7.6
-rwxr-xr-x   1 root     root       634880 Apr 29  1996
/lib/libc.so.4.7.6
-rwxr-xr-x   1 root     root      2478585 Dec 14  1998 /lib/libc.so.6
-rwxr-xr-x   1 root     root        85699 Dec 14  1998
/lib/libcrypt.so.1
$ ldd /usr/bin/du
        libc.so.6 => /lib/libc.so.6 (0x40009000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0x80000000)

all from SuSE 6.0 (I know, it's old...)

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
