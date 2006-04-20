Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWDTSCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWDTSCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbWDTSCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 14:02:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.193]:55354 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751207AbWDTSCG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 14:02:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sd48ir5fHAiJ/IQ7yBOVBZgC/W6SCKK1+ljU6in3goa6TDzei6R5Gaihrz1GZ4QRnjegQk6BPx+Z28ClkNzJx5eNTaIgKjPDEM3eCUbSoAsxGUYxNBS7iIqxNt5R+tGzy+DrNUeMOUhJYOAfMnTaPpxA0cv5llRodPHo7QB77Po=
Message-ID: <b3be17f30604201102jff51794r52dd3024d631051e@mail.gmail.com>
Date: Thu, 20 Apr 2006 11:02:03 -0700
From: "Robert Merrill" <grievre@gmail.com>
To: "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS bug?
In-Reply-To: <1145555789.8136.13.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b3be17f30604200937l7cfaca8evcc17f6ecd72f643e@mail.gmail.com>
	 <1145551304.8136.5.camel@lade.trondhjem.org>
	 <b3be17f30604200953i652e14a2n908f1a066ffe4e7f@mail.gmail.com>
	 <1145555789.8136.13.camel@lade.trondhjem.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/06, Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> Given that you are reporting an error with copy_from_user, then it is
> _definitely_ of interest to figure out what your glibc is telling the
> kernel to copy.

execve("./a.out", ["./a.out", "foo"], [/* 16 vars */]) = 0
uname({sys="Linux", node="soda", ...})  = 0
brk(0)                                  = 0x804a000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
old_mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7f5f000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=20397, ...}) = 0
old_mmap(NULL, 20397, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f5a000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1270928, ...}) = 0
old_mmap(NULL, 1276892, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e22000
old_mmap(0xb7f50000, 32768, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x12e000) = 0xb7f50000
old_mmap(0xb7f58000, 7132, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f58000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) = 0xb7e21000
mprotect(0xb7f50000, 20480, PROT_READ)  = 0
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e218e0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f5a000, 20397)               = 0
open("foo", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat64(3, {st_mode=S_IFDIR|0666, st_size=512, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
brk(0)                                  = 0x804a000
brk(0x806f000)                          = 0x806f000
fstat64(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 21), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7f5e000
write(1, "0\n", 20
)                      = 2
getdents64(3,  <unfinished ...>
+++ killed by SIGSEGV +++
