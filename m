Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWJLPrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWJLPrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWJLPrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:47:48 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:40204 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S932266AbWJLPrq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:47:46 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk>
	<1160648885.5897.6.camel@Homer.simpson.net>
	<1160662435.6177.3.camel@Homer.simpson.net>
	<20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
	<87odshr289.fsf@sycorax.lbl.gov> <20061012152356.GE6515@kernel.dk>
Date: Thu, 12 Oct 2006 08:47:18 -0700
In-Reply-To: <20061012152356.GE6515@kernel.dk> (message from Jens Axboe on
	Thu, 12 Oct 2006 17:23:57 +0200)
Message-ID: <87r6xd1qpl.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Jens Axboe <jens.axboe@oracle.com> writes:

> Argh damn, it needs this on top of it as well. Your second problem
> likely stems from that missing bit, please retest with this one applied
> as well.
>
> diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
> index e7513e5..bddfebd 100644
> --- a/drivers/ide/ide-cd.c
> +++ b/drivers/ide/ide-cd.c
> @@ -716,7 +716,7 @@ static int cdrom_decode_status(ide_drive
>  		ide_error(drive, "request sense failure", stat);
>  		return 1;
>  
> -	} else if (blk_pc_request(rq)) {
> +	} else if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC) {
>  		/* All other functions, except for READ. */
>  		unsigned long flags;
>  

no more strange messages but, once again, i am not able to read movie
dvd's with the above patch applied. there is nothing in syslog. i am
attaching the mplayer strace in case it might be useful:


--=-=-=
Content-Disposition: inline; filename=mplayer.out
Content-Description: mtrace strace

execve("/usr/local/bin/mplayer", ["mplayer", "dvd://"], [/* 37 vars */]) = 0
uname({sys="Linux", node="trinculo", ...}) = 0
brk(0)                                  = 0x89ba000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f89000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75823, ...}) = 0
mmap2(NULL, 75823, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f76000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgtk-x11-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\234\4"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=3043556, ...}) = 0
mmap2(NULL, 3055436, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7c8c000
mmap2(0xb7f6b000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2df) = 0xb7f6b000
mmap2(0xb7f73000, 12108, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f73000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgdk-x11-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0pM\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=528580, ...}) = 0
mmap2(NULL, 527936, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7c0b000
mmap2(0xb7c89000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7e) = 0xb7c89000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libatk-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0l\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=102504, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7c0a000
mmap2(NULL, 105996, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bf0000
mmap2(0xb7c08000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17) = 0xb7c08000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgdk_pixbuf-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3007\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=88600, ...}) = 0
mmap2(NULL, 87528, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bda000
mmap2(0xb7bef000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15) = 0xb7bef000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`3\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=145136, ...}) = 0
mmap2(NULL, 147584, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bb5000
mmap2(0xb7bd8000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22) = 0xb7bd8000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libpangocairo-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300+\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=29256, ...}) = 0
mmap2(NULL, 32220, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7bad000
mmap2(0xb7bb4000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7bb4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libfontconfig.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300R\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=171940, ...}) = 0
mmap2(NULL, 171364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b83000
mmap2(0xb7ba5000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x22) = 0xb7ba5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXext.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`&\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=52848, ...}) = 0
mmap2(NULL, 56060, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b75000
mmap2(0xb7b82000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc) = 0xb7b82000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXrender.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\23"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=29092, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7b74000
mmap2(NULL, 32040, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b6c000
mmap2(0xb7b73000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7b73000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXinerama.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\10"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=6676, ...}) = 0
mmap2(NULL, 9564, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b69000
mmap2(0xb7b6b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb7b6b000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXi.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\22\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=27052, ...}) = 0
mmap2(NULL, 30112, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b61000
mmap2(0xb7b68000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7b68000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXrandr.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\v\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=10028, ...}) = 0
mmap2(NULL, 13020, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b5d000
mmap2(0xb7b60000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2) = 0xb7b60000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXcursor.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\"\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=33336, ...}) = 0
mmap2(NULL, 36232, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b54000
mmap2(0xb7b5c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7b5c000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXfixes.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\17"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=14396, ...}) = 0
mmap2(NULL, 17388, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b4f000
mmap2(0xb7b53000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb7b53000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libpango-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P\214\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=233948, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7b4e000
mmap2(NULL, 237092, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7b14000
mmap2(0xb7b4c000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x37) = 0xb7b4c000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libcairo.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320~\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=395804, ...}) = 0
mmap2(NULL, 398868, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7ab2000
mmap2(0xb7b12000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5f) = 0xb7b12000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libX11.so.6", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\22\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=812672, ...}) = 0
mmap2(NULL, 816788, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb79ea000
mmap2(0xb7aaf000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc4) = 0xb7aaf000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgobject-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300i\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=237156, ...}) = 0
mmap2(NULL, 237380, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb79b0000
mmap2(0xb79e9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x39) = 0xb79e9000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgmodule-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\r\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9784, ...}) = 0
mmap2(NULL, 8720, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb79ad000
mmap2(0xb79af000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2) = 0xb79af000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libdl.so.2", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\f\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9592, ...}) = 0
mmap2(NULL, 12404, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb79a9000
mmap2(0xb79ab000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb79ab000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libglib-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\322\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=596608, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb79a8000
mmap2(NULL, 596204, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7916000
mmap2(0xb79a7000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x91) = 0xb79a7000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/libdvdnav.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2201\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=214229, ...}) = 0
mmap2(NULL, 195728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb78e6000
mmap2(0xb7915000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2f) = 0xb7915000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libpthread.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360G\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=85010, ...}) = 0
mmap2(NULL, 70104, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb78d4000
mmap2(0xb78e2000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb78e2000
mmap2(0xb78e4000, 4568, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb78e4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libmad.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\25\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=85564, ...}) = 0
mmap2(NULL, 88624, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb78be000
mmap2(0xb78d3000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb78d3000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libdv.so.4", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P6\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=109656, ...}) = 0
mmap2(NULL, 159328, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7897000
mmap2(0xb78b0000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x19) = 0xb78b0000
mmap2(0xb78b2000, 48736, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb78b2000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/liblzo.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 !\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=124640, ...}) = 0
mmap2(NULL, 123516, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7878000
mmap2(0xb7896000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e) = 0xb7896000
mprotect(0xbfab6000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN) = 0
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/libxvidcore.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\234"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=756104, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7877000
mmap2(NULL, 1165832, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb775a000
mmap2(0xb7803000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xa9) = 0xb7803000
mmap2(0xb7804000, 469512, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7804000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libpng12.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3209\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=146240, ...}) = 0
mmap2(NULL, 145140, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7736000
mmap2(0xb7759000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x23) = 0xb7759000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libz.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\26"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=78500, ...}) = 0
mmap2(NULL, 81456, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7722000
mmap2(0xb7735000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12) = 0xb7735000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libjpeg.so.62", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360#\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=127488, ...}) = 0
mmap2(NULL, 130444, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7702000
mmap2(0xb7721000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1e) = 0xb7721000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libasound.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\371\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=784036, ...}) = 0
mmap2(NULL, 787060, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7641000
mmap2(0xb76fd000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xbb) = 0xb76fd000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libmp3lame.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240h\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=426340, ...}) = 0
mmap2(NULL, 625728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb75a8000
mmap2(0xb760e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x66) = 0xb760e000
mmap2(0xb7610000, 199744, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7610000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/libfaac.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\26"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=73588, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb75a7000
mmap2(NULL, 68588, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7596000
mmap2(0xb75a4000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb75a4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\345"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=263040, ...}) = 0
mmap2(NULL, 264196, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7555000
mmap2(0xb758d000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x38) = 0xb758d000
mmap2(0xb7595000, 2052, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7595000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libcdda_interface.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\31"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=54248, ...}) = 0
mmap2(NULL, 57212, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7547000
mmap2(0xb7554000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xc) = 0xb7554000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libcdda_paranoia.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \24\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=28940, ...}) = 0
mmap2(NULL, 31952, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb753f000
mmap2(0xb7546000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb7546000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libstdc++.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\310\3"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=884436, ...}) = 0
mmap2(NULL, 910980, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7460000
mmap2(0xb7534000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd3) = 0xb7534000
mmap2(0xb7539000, 22148, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7539000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libungif.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\23\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=27492, ...}) = 0
mmap2(NULL, 30512, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7458000
mmap2(0xb745f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb745f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libfreetype.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0Pl\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=434840, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7457000
mmap2(NULL, 433700, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb73ed000
mmap2(0xb7454000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x67) = 0xb7454000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libaa.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300A\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=104292, ...}) = 0
mmap2(NULL, 110164, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb73d2000
mmap2(0xb73ea000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x18) = 0xb73ea000
mmap2(0xb73ec000, 3668, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb73ec000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libGL.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\17\1\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=425320, ...}) = 0
mmap2(NULL, 433608, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7368000
mmap2(0xb73cb000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x62) = 0xb73cb000
mmap2(0xb73d1000, 3528, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb73d1000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXxf86dga.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\23\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=18144, ...}) = 0
mmap2(NULL, 17016, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7363000
mmap2(0xb7367000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb7367000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXv.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\f\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=14252, ...}) = 0
mmap2(NULL, 17148, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb735e000
mmap2(0xb7362000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb7362000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXxf86vm.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\v\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=16016, ...}) = 0
mmap2(NULL, 18908, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7359000
mmap2(0xb735d000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb735d000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libSDL-1.2.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220b\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=429004, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7358000
mmap2(NULL, 724528, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb72a7000
mmap2(0xb730e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x67) = 0xb730e000
mmap2(0xb7310000, 294448, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7310000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libvga.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\207"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=354620, ...}) = 0
mmap2(NULL, 390844, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7247000
mmap2(0xb7297000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x50) = 0xb7297000
mmap2(0xb729e000, 34492, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb729e000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libdirectfb-0.9.so.25", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \245\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=351848, ...}) = 0
mmap2(NULL, 356132, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb71f0000
mmap2(0xb7245000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x54) = 0xb7245000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libartsc.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\21\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=19184, ...}) = 0
mmap2(NULL, 22212, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb71ea000
mmap2(0xb71ef000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb71ef000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgthread-2.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \21\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=14028, ...}) = 0
mmap2(NULL, 12892, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb71e6000
mmap2(0xb71e9000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb71e9000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libesd.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\37\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=32568, ...}) = 0
mmap2(NULL, 35604, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb71dd000
mmap2(0xb71e5000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb71e5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libaudiofile.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3405\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=142408, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb71dc000
mmap2(NULL, 145468, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb71b8000
mmap2(0xb71d9000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20) = 0xb71d9000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/libopenal.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\00004\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=691252, ...}) = 0
mmap2(NULL, 206228, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7185000
mmap2(0xb71b3000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2e) = 0xb71b3000
mmap2(0xb71b4000, 13716, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb71b4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libaudio.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000A\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=84640, ...}) = 0
mmap2(NULL, 87900, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb716f000
mmap2(0xb7184000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb7184000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXt.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \276\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=320344, ...}) = 0
mmap2(NULL, 320916, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7120000
mmap2(0xb716b000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4b) = 0xb716b000
mmap2(0xb716e000, 1428, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb716e000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libgcc_s.so.1", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240\30"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=40512, ...}) = 0
mmap2(NULL, 43716, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7115000
mmap2(0xb711f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x9) = 0xb711f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=1245676, ...}) = 0
mmap2(NULL, 1251484, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6fe3000
mmap2(0xb710b000, 28672, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x128) = 0xb710b000
mmap2(0xb7112000, 10396, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7112000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6fe2000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libpangoft2-1.0.so.0", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 J\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=171160, ...}) = 0
mmap2(NULL, 174152, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6fb7000
mmap2(0xb6fe1000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x29) = 0xb6fe1000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libexpat.so.1", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340 \0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=126112, ...}) = 0
mmap2(NULL, 124920, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6f98000
mmap2(0xb6fb5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1d) = 0xb6fb5000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXau.so.6", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\n\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=7220, ...}) = 0
mmap2(NULL, 10164, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6f95000
mmap2(0xb6f97000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1) = 0xb6f97000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libXdmcp.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0\17\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=16672, ...}) = 0
mmap2(NULL, 19604, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6f90000
mmap2(0xb6f94000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x3) = 0xb6f94000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/librt.so.1", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0`\35\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=26516, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6f8f000
mmap2(NULL, 29264, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6f87000
mmap2(0xb6f8d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5) = 0xb6f8d000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libslang.so.2", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360\336"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=644012, ...}) = 0
mmap2(NULL, 775816, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ec9000
mmap2(0xb6f58000, 61440, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8e) = 0xb6f58000
mmap2(0xb6f67000, 128648, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6f67000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libgpm.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\30\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=18724, ...}) = 0
mmap2(NULL, 22644, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ec3000
mmap2(0xb6ec8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb6ec8000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libdrm.so.2", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320\33"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=24096, ...}) = 0
mmap2(NULL, 28168, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ebc000
mmap2(0xb6ec2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x5) = 0xb6ec2000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libfusion-0.9.so.25", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220\33"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=19860, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6ebb000
mmap2(NULL, 22876, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6eb5000
mmap2(0xb6eba000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x4) = 0xb6eba000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libdirect-0.9.so.25", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0P-\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=55608, ...}) = 0
mmap2(NULL, 56620, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6ea7000
mmap2(0xb6eb4000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xd) = 0xb6eb4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libSM.so.6", O_RDONLY)   = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20 \0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=32144, ...}) = 0
mmap2(NULL, 35048, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e9e000
mmap2(0xb6ea6000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb6ea6000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/lib/libICE.so.6", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3406\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=85060, ...}) = 0
mmap2(NULL, 95312, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e86000
mmap2(0xb6e9b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x14) = 0xb6e9b000
mmap2(0xb6e9c000, 5200, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6e9c000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e85000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e84000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e83000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6e82000
mprotect(0xb710b000, 20480, PROT_READ)  = 0
mprotect(0xb72a7000, 421888, PROT_READ|PROT_WRITE) = 0
mprotect(0xb72a7000, 421888, PROT_READ|PROT_EXEC) = 0
mprotect(0xb7534000, 12288, PROT_READ)  = 0
mprotect(0xb75a8000, 417792, PROT_READ|PROT_WRITE) = 0
mprotect(0xb75a8000, 417792, PROT_READ|PROT_EXEC) = 0
mprotect(0xb775a000, 692224, PROT_READ|PROT_WRITE) = 0
mprotect(0xb775a000, 692224, PROT_READ|PROT_EXEC) = 0
mprotect(0xb7897000, 102400, PROT_READ|PROT_WRITE) = 0
mprotect(0xb7897000, 102400, PROT_READ|PROT_EXEC) = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb6e826c0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f76000, 75823)               = 0
set_tid_address(0xb6e82708)             = 3713
rt_sigaction(SIGRTMIN, {0xb78d8450, [], SA_SIGINFO}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {0xb78d83c0, [], SA_RESTART|SA_SIGINFO}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM_INFINITY}) = 0
uname({sys="Linux", node="trinculo", ...}) = 0
futex(0xb753a4dc, FUTEX_WAKE, 2147483647) = 0
time(NULL)                              = 1160667862
gettimeofday({1160667862, 510850}, NULL) = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=21568, ...}) = 0
mmap2(NULL, 21568, PROT_READ, MAP_SHARED, 3, 0) = 0xb7f83000
close(3)                                = 0
futex(0xb7111dec, FUTEX_WAKE, 2147483647) = 0
brk(0)                                  = 0x89ba000
brk(0x89db000)                          = 0x89db000
fstat64(1, {st_mode=S_IFREG|0644, st_size=39581, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f82000
write(1, "MPlayer dev-SVN-r20170-4.1.2 (C)"..., 56MPlayer dev-SVN-r20170-4.1.2 (C) 2000-2006 MPlayer Team
) = 56
write(1, "CPU: Intel(R) Pentium(R) M proce"..., 45CPU: Intel(R) Pentium(R) M processor 1600MHz ) = 45
write(1, "(Family: 6, Model: 9, Stepping: "..., 35(Family: 6, Model: 9, Stepping: 5)
) = 35
rt_sigaction(SIGILL, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGFPE, NULL, {SIG_DFL}, 8) = 0
rt_sigaction(SIGILL, {0x80be280, [ILL], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGFPE, {0x80be1f0, [FPE], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGILL, {SIG_DFL}, NULL, 8) = 0
rt_sigaction(SIGFPE, {SIG_DFL}, NULL, 8) = 0
write(1, "CPUflags:  MMX: 1 MMX2: 1 3DNow:"..., 60CPUflags:  MMX: 1 MMX2: 1 3DNow: 0 3DNow2: 0 SSE: 1 SSE2: 1
) = 60
write(1, "Compiled for x86 CPU with extens"..., 37Compiled for x86 CPU with extensions:) = 37
write(1, " MMX", 4 MMX)                     = 4
write(1, " MMX2", 5 MMX2)                    = 5
write(1, " SSE", 4 SSE)                     = 4
write(1, " SSE2", 5 SSE2)                    = 5
write(1, "\n", 1
)                       = 1
open("/usr/local/etc/mplayer/mplayer.conf", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
mkdir("/home/romosan/.mplayer/", 0777)  = -1 EEXIST (File exists)
open("/home/romosan/.mplayer/config", O_WRONLY|O_CREAT|O_EXCL|O_LARGEFILE, 0666) = -1 EEXIST (File exists)
open("/home/romosan/.mplayer/config", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=44, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f81000
read(3, "# Write your default config opti"..., 4096) = 44
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f81000, 4096)                = 0
open("/home/romosan/.mplayer/codecs.conf", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/local/etc/mplayer/codecs.conf", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
mmap2(NULL, 790528, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6dc1000
open("/home/romosan/.mplayer/font/font.desc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
munmap(0xb6dc1000, 790528)              = 0
mmap2(NULL, 790528, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb6dc1000
open("/usr/local/share/mplayer/font/font.desc", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
munmap(0xb6dc1000, 790528)              = 0
ioctl(1, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfab39d8) = -1 ENOTTY (Inappropriate ioctl for device)
access("/home/romosan/.terminfo/x/xterm", R_OK) = -1 ENOENT (No such file or directory)
access("/etc/terminfo/x/xterm", R_OK)   = -1 ENOENT (No such file or directory)
access("/lib/terminfo/x/xterm", R_OK)   = 0
open("/lib/terminfo/x/xterm", O_RDONLY|O_LARGEFILE) = 3
read(3, "\32\1\34\0\35\0\17\0\235\1&\5", 12) = 12
read(3, "xterm|X11 terminal emulator\0", 28) = 28
read(3, "\0\1\0\0\1\0\0\0\1\0\0\0\0\1\1\0\0\0\0\0\0\0\1\0\0\1\0"..., 29) = 29
read(3, "\0", 1)                        = 1
read(3, "P\0\10\0\30\0\377\377\377\377\377\377\377\377\377\377\377"..., 30) = 30
read(3, "\0\0\4\0\6\0\10\0\31\0\36\0&\0*\0.\0\377\3779\0J\0L\0P"..., 826) = 826
read(3, "\33[Z\0\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33["..., 1318) = 1318
read(3, "", 10)                         = 0
close(3)                                = 0
ioctl(2, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfab39d8) = -1 ENOTTY (Inappropriate ioctl for device)
ioctl(2, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfab3998) = -1 ENOTTY (Inappropriate ioctl for device)
open("/home/romosan/.mplayer/input.conf", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/usr/local/etc/mplayer/input.conf", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
rt_sigaction(SIGCHLD, {0x80af100, [CHLD], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x80b0640, [TERM], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGHUP, {0x80b0640, [HUP], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x80b0640, [INT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x80b0640, [QUIT], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGPIPE, {0x80b0640, [PIPE], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGBUS, {0x80b0640, [BUS], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGSEGV, {0x80b0640, [SEGV], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGILL, {0x80b0640, [ILL], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGFPE, {0x80b0640, [FPE], SA_RESTART}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGABRT, {0x80b0640, [ABRT], SA_RESTART}, {SIG_DFL}, 8) = 0
stat64("dvd://.conf", 0xbfab4a7c)       = -1 ENOENT (No such file or directory)
stat64("/home/romosan/.mplayer/.conf", 0xbfab4a7c) = -1 ENOENT (No such file or directory)
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_START or TCSETS, {B38400 opost isig -icanon -echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig -icanon -echo ...}) = 0
write(1, "\nPlaying dvd://.\n", 17
Playing dvd://.
)     = 17
open("dv.ifo", O_RDONLY|O_LARGEFILE)    = -1 ENOENT (No such file or directory)
open("dv.rar", O_RDONLY|O_LARGEFILE)    = -1 ENOENT (No such file or directory)
open("dv.rar", O_RDONLY|O_LARGEFILE)    = -1 ENOENT (No such file or directory)
open("dv.idx", O_RDONLY|O_LARGEFILE)    = -1 ENOENT (No such file or directory)
open("dv.rar", O_RDONLY|O_LARGEFILE)    = -1 ENOENT (No such file or directory)
open("dv.rar", O_RDONLY|O_LARGEFILE)    = -1 ENOENT (No such file or directory)
brk(0x89fc000)                          = 0x89fc000
open("/home/romosan/.mplayer/sub/dv.ifo", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
brk(0x89fb000)                          = 0x89fb000
open("/home/romosan/.mplayer/sub/dv.rar", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/home/romosan/.mplayer/sub/dv.rar", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/home/romosan/.mplayer/sub/dv.idx", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/home/romosan/.mplayer/sub/dv.rar", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
open("/home/romosan/.mplayer/sub/dv.rar", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
futex(0xb79ac070, FUTEX_WAKE, 2147483647) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75823, ...}) = 0
mmap2(NULL, 75823, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6e6f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/usr/local/lib/libdvdcss.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 \21\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=72768, ...}) = 0
mmap2(NULL, 31240, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7f7a000
mmap2(0xb7f81000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb7f81000
close(3)                                = 0
munmap(0xb6e6f000, 75823)               = 0
write(2, "libdvdread: Using libdvdcss vers"..., 57libdvdread: Using libdvdcss version 1.2.9 for DVD access
) = 57
stat64("/dev/dvd", {st_mode=S_IFBLK|0660, st_rdev=makedev(22, 0), ...}) = 0
getuid32()                              = 1000
socket(PF_FILE, SOCK_STREAM, 0)         = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
socket(PF_FILE, SOCK_STREAM, 0)         = 3
fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(3, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(3, {sa_family=AF_FILE, path="/var/run/nscd/socket"}, 110) = -1 ENOENT (No such file or directory)
close(3)                                = 0
open("/etc/nsswitch.conf", O_RDONLY)    = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=465, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7f79000
read(3, "# /etc/nsswitch.conf\n#\n# Example"..., 4096) = 465
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f79000, 4096)                = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75823, ...}) = 0
mmap2(NULL, 75823, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6e6f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnss_compat.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\21\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=30428, ...}) = 0
mmap2(NULL, 33392, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e66000
mmap2(0xb6e6d000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6) = 0xb6e6d000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnsl.so.1", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p5\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=76548, ...}) = 0
mmap2(NULL, 87808, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e50000
mmap2(0xb6e62000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x11) = 0xb6e62000
mmap2(0xb6e64000, 5888, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb6e64000
close(3)                                = 0
munmap(0xb6e6f000, 75823)               = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=75823, ...}) = 0
mmap2(NULL, 75823, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb6e6f000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnss_nis.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@\34\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=34320, ...}) = 0
mmap2(NULL, 37420, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e46000
mmap2(0xb6e4e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7) = 0xb6e4e000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libnss_files.so.2", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200\33"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=38372, ...}) = 0
mmap2(NULL, 41620, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb6e3b000
mmap2(0xb6e44000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8) = 0xb6e44000
close(3)                                = 0
munmap(0xb6e6f000, 75823)               = 0
open("/etc/passwd", O_RDONLY)           = 3
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
_llseek(3, 0, [0], SEEK_CUR)            = 0
fstat64(3, {st_mode=S_IFREG|0644, st_size=1465, ...}) = 0
mmap2(NULL, 1465, PROT_READ, MAP_SHARED, 3, 0) = 0xb7f79000
_llseek(3, 1465, [1465], SEEK_SET)      = 0
munmap(0xb7f79000, 1465)                = 0
close(3)                                = 0
open("/dev/dvd", O_RDONLY|O_LARGEFILE)  = -1 ENOMEDIUM (No medium found)
write(2, "libdvdread: Could not open /dev/"..., 52libdvdread: Could not open /dev/dvd with libdvdcss.
) = 52
write(2, "libdvdread: Can\'t open /dev/dvd "..., 44libdvdread: Can't open /dev/dvd for reading
) = 44
write(2, "Couldn\'t open DVD device: /dev/d"..., 35Couldn't open DVD device: /dev/dvd
) = 35
write(2, "[file] No filename\n", 19[file] No filename
)    = 19
write(2, "Failed to open dvd://.\n", 23Failed to open dvd://.
) = 23
select(1, [0], NULL, NULL, {0, 0})      = 0 (Timeout)
select(1, [0], NULL, NULL, {0, 0})      = 0 (Timeout)
write(1, "\n", 1
)                       = 1
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig -icanon -echo ...}) = 0
ioctl(0, SNDCTL_TMR_START or TCSETS, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
write(1, "\nExiting... (End of file)\n", 26
Exiting... (End of file)
) = 26
munmap(0xb7f82000, 4096)                = 0
exit_group(0)                           = ?
Process 3713 detached

--=-=-=


--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |

--=-=-=--
