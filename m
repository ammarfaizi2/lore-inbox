Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265483AbUF2F5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265483AbUF2F5P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 01:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265484AbUF2F5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 01:57:14 -0400
Received: from av1-1-sn1.fre.skanova.net ([81.228.11.107]:42917 "EHLO
	av1-1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S265483AbUF2F5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 01:57:08 -0400
Date: Tue, 29 Jun 2004 07:59:07 +0200
From: Peter Lundkvist <p.lundkvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2: random problems with mmap
Message-ID: <20040629055906.GA21986@debian>
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624014655.5d2a4bfb.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have problems running cyrus lmtpd; it fails randomly after
fetching 30-50 mails. I have only seen this problem in
2.6.7-mm2 (-mm1 was ok, have not tested -mm3 yet).

/peter

Strace at failure:

open("/var/spool/cyrus/mail/p/user/peter/Linux kernel/cyrus.header", O_RDWR) = 12
fstat64(12, {st_mode=S_IFREG|0600, st_size=175, ...}) = 0
mmap2(NULL, 175, PROT_READ, MAP_SHARED, 12, 0) = 0x10000
rt_sigaction(SIGALRM, {0x8080300, [], SA_ONESHOT}, NULL, 8) = 0
alarm(100)                              = 0
fcntl64(12, F_SETLKW, {type=F_WRLCK, whence=SEEK_SET, start=0, len=0}) = 0
fstat64(12, {st_mode=S_IFREG|0600, st_size=175, ...}) = 0
stat64("/var/spool/cyrus/mail/p/user/peter/Linux kernel/cyrus.header", {st_mode=S_IFREG|0600, st_size=175, ...}) = 0
alarm(0)                                = 100
rt_sigaction(SIGALRM, {SIG_IGN}, NULL, 8) = 0
open("/var/spool/cyrus/mail/p/user/peter/Linux kernel/cyrus.index", O_RDWR) = 13
fstat64(13, {st_mode=S_IFREG|0600, st_size=2177784, ...}) = 0
mmap2(NULL, 2187264, PROT_READ, MAP_SHARED, 13, 0) = -1 ENOMEM (Cannot allocate memory)

map at time of failure:


00010000-00011000 r--s 00000000 03:0a 442939     /var/spool/cyrus/mail/p/user/peter/Linux kernel/cyrus.header
08048000-0810e000 r-xp 00000000 03:0a 1954693    /usr/lib/cyrus/bin/lmtpd
0810e000-0810f000 rw-p 000c6000 03:0a 1954693    /usr/lib/cyrus/bin/lmtpd
0810f000-0815c000 rw-p 0810f000 00:00 0 
b6a4d000-b6a56000 r-xp 00000000 03:0a 1375569    /lib/tls/i686/cmov/libnss_files-2.3.2.so
b6a56000-b6a57000 rw-p 00008000 03:0a 1375569    /lib/tls/i686/cmov/libnss_files-2.3.2.so
b6a57000-b6a60000 r-xp 00000000 03:0a 1441139    /lib/tls/i686/cmov/libnss_nis-2.3.2.so
b6a60000-b6a61000 rw-p 00008000 03:0a 1441139    /lib/tls/i686/cmov/libnss_nis-2.3.2.so
b6a70000-b6a77000 r-xp 00000000 03:0a 1372610    /lib/tls/i686/cmov/libnss_compat-2.3.2.so
b6a77000-b6a78000 rw-p 00006000 03:0a 1372610    /lib/tls/i686/cmov/libnss_compat-2.3.2.so
b6af4000-b6af8000 r--s 00000000 03:0a 631004     /var/lib/cyrus/mailboxes.db
b6af8000-b6afe000 rw-s 00000000 03:0a 166401     /var/lib/cyrus/db/__db.005
b6afe000-b7a50000 rw-s 00000000 03:0a 57597      /var/lib/cyrus/db/__db.004
b7a50000-b7a68000 rw-s 00000000 03:0a 6192       /var/lib/cyrus/db/__db.003
b7a68000-b7aaa000 rw-s 00000000 03:0a 5293       /var/lib/cyrus/db/__db.002
b7aaa000-b7aac000 rw-s 00000000 03:0a 4811       /var/lib/cyrus/db/__db.001
b7aac000-b7aaf000 r-xp 00000000 03:0a 443116     /usr/lib/sasl2/libanonymous.so.2.0.18
b7aaf000-b7ab0000 rw-p 00002000 03:0a 443116     /usr/lib/sasl2/libanonymous.so.2.0.18
b7ad0000-b7ad4000 r-xp 00000000 03:0a 442951     /usr/lib/sasl2/libcrammd5.so.2.0.18
b7ad4000-b7ad5000 rw-p 00003000 03:0a 442951     /usr/lib/sasl2/libcrammd5.so.2.0.18
b7af5000-b7aff000 r-xp 00000000 03:0a 443097     /usr/lib/sasl2/libdigestmd5.so.2.0.18
b7aff000-b7b00000 rw-p 0000a000 03:0a 443097     /usr/lib/sasl2/libdigestmd5.so.2.0.18
b7b20000-b7b23000 r-xp 00000000 03:0a 528665     /usr/lib/sasl2/liblogin.so.2.0.18
b7b23000-b7b24000 rw-p 00003000 03:0a 528665     /usr/lib/sasl2/liblogin.so.2.0.18
b7b44000-b7b48000 r-xp 00000000 03:0a 1235682    /lib/tls/i686/cmov/libcrypt-2.3.2.so
b7b48000-b7b49000 rw-p 00004000 03:0a 1235682    /lib/tls/i686/cmov/libcrypt-2.3.2.so
b7b49000-b7b70000 rw-p b7b49000 00:00 0 
b7b7f000-b7b82000 r-xp 00000000 03:0a 443105     /usr/lib/sasl2/libplain.so.2.0.18
b7b82000-b7b83000 rw-p 00003000 03:0a 443105     /usr/lib/sasl2/libplain.so.2.0.18
b7ba3000-b7baa000 r-xp 00000000 03:0a 622716     /usr/lib/sasl2/libntlm.so.2.0.18
b7baa000-b7bab000 rw-p 00007000 03:0a 622716     /usr/lib/sasl2/libntlm.so.2.0.18
b7bcb000-b7bd0000 r-xp 00000000 03:0a 178254     /usr/lib/sasl2/libsasldb.so.2.0.18
b7bd0000-b7bd1000 rw-p 00004000 03:0a 178254     /usr/lib/sasl2/libsasldb.so.2.0.18
b7bf1000-b7bf9000 r-xp 00000000 03:0a 443102     /usr/lib/sasl2/libotp.so.2.0.18
b7bf9000-b7bfc000 rw-p 00008000 03:0a 443102     /usr/lib/sasl2/libotp.so.2.0.18
b7c7d000-b7c7e000 rw-p b7c7d000 00:00 0 
b7c7e000-b7c80000 r-xp 00000000 03:0a 1235688    /lib/tls/i686/cmov/libdl-2.3.2.so
b7c80000-b7c81000 rw-p 00001000 03:0a 1235688    /lib/tls/i686/cmov/libdl-2.3.2.so
b7c81000-b7db0000 r-xp 00000000 03:0a 1235678    /lib/tls/i686/cmov/libc-2.3.2.so
b7db0000-b7db8000 rw-p 0012f000 03:0a 1235678    /lib/tls/i686/cmov/libc-2.3.2.so
b7db8000-b7dbc000 rw-p b7db8000 00:00 0 
b7dbc000-b7dce000 r-xp 00000000 03:0a 1235733    /lib/tls/i686/cmov/libnsl-2.3.2.so
b7dce000-b7dcf000 rw-p 00011000 03:0a 1235733    /lib/tls/i686/cmov/libnsl-2.3.2.so
b7dcf000-b7dd1000 rw-p b7dcf000 00:00 0 
b7dd1000-b7dd8000 r-xp 00000000 03:0a 1467215    /lib/libwrap.so.0.7.6
b7dd8000-b7dd9000 rw-p 00006000 03:0a 1467215    /lib/libwrap.so.0.7.6
b7dd9000-b7dda000 rw-p b7dd9000 00:00 0 
b7dda000-b7ec2000 r-xp 00000000 03:0a 1482802    /usr/lib/i686/cmov/libcrypto.so.0.9.7
b7ec2000-b7ed3000 rw-p 000e8000 03:0a 1482802    /usr/lib/i686/cmov/libcrypto.so.0.9.7
b7ed3000-b7ed7000 rw-p b7ed3000 00:00 0 
b7ed7000-b7f05000 r-xp 00000000 03:0a 1484387    /usr/lib/i686/cmov/libssl.so.0.9.7
b7f05000-b7f08000 rw-p 0002d000 03:0a 1484387    /usr/lib/i686/cmov/libssl.so.0.9.7
b7f08000-b7fb1000 r-xp 00000000 03:0a 622722     /usr/lib/libdb3.so.3.0.2
b7fb1000-b7fb2000 rw-p 000a8000 03:0a 622722     /usr/lib/libdb3.so.3.0.2
b7fb2000-b7fc1000 r-xp 00000000 03:0a 1441157    /lib/tls/i686/cmov/libresolv-2.3.2.so
b7fc1000-b7fc2000 rw-p 0000f000 03:0a 1441157    /lib/tls/i686/cmov/libresolv-2.3.2.so
b7fc2000-b7fc5000 rw-p b7fc2000 00:00 0 
b7fc5000-b7fd9000 r-xp 00000000 03:0a 172678     /usr/lib/libsasl2.so.2.0.18
b7fd9000-b7fda000 rw-p 00013000 03:0a 172678     /usr/lib/libsasl2.so.2.0.18
b7fe9000-b7fea000 rw-p b7fe9000 00:00 0 
b7fea000-b8000000 r-xp 00000000 03:0a 1375576    /lib/ld-2.3.2.so
b8000000-b8001000 rw-p 00015000 03:0a 1375576    /lib/ld-2.3.2.so
bfff5000-c0000000 rwxp bfff5000 00:00 0 
ffffe000-fffff000 ---p 00000000 00:00 0 

ulimit -a:
core file size        (blocks, -c) 0
data seg size         (kbytes, -d) unlimited
file size             (blocks, -f) unlimited
max locked memory     (kbytes, -l) unlimited
max memory size       (kbytes, -m) unlimited
open files                    (-n) 1024
pipe size          (512 bytes, -p) 8
stack size            (kbytes, -s) 8192
cpu time             (seconds, -t) unlimited
max user processes            (-u) 4094
virtual memory        (kbytes, -v) unlimited

