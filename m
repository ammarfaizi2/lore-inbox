Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136790AbREBDCb>; Tue, 1 May 2001 23:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136794AbREBDCV>; Tue, 1 May 2001 23:02:21 -0400
Received: from mail1.mia.bellsouth.net ([205.152.144.13]:14815 "EHLO
	mail1.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S136790AbREBDCH>; Tue, 1 May 2001 23:02:07 -0400
Message-ID: <3AEF78F2.CFF81E16@bellsouth.net>
Date: Tue, 01 May 2001 23:03:14 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@nl.linux.org>
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] (updated) ext2 directories in pagecache
In-Reply-To: <20010429203512Z92376-12380+28@humbolt.nl.linux.org>
Content-Type: multipart/mixed;
 boundary="------------95506487F904297F76BDD90B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------95506487F904297F76BDD90B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Daniel,
This combination against 2.4.4 won't allow directories to be moved.
Ex: mv a b #fails with I/O error.  See attached strace.
But with ext2-dir-patch-S4 by itself, mv works as it should.
Later,
Albert

Daniel Phillips wrote:
> 
> > Patch is on ftp.math.psu.edu/pub/viro/ext2-dir-patch-S4.gz
> 
> Here is my ext2 directory index as a patch against your patch:
> 
>     http://kernelnewbies.org/~phillips/htree/dx.pcache-2.4.4
> 
> Changes:
> 
>     - COMBSORT macro replaced by custom sort code
>     - Most #ifdef CONFIG_EXT2_INDEX's changed to if (<constant>)
> 
> To do:
> 
>   - Split up the split code
>   - Finalize hash function
>   - Test/debug big endian
>   - Fall back to linear search if bad index detected
>   - Fail gracefully on random data
>   - Remove the tracing and test options
> 
> To apply:
> 
>     cd source/tree
>     zcat ext2-dir-patch-S4.gz | patch -p1
>     cat dx.pcache-2.4.4 | patch -p0
> 
> To create an indexed directory:
> 
>     mount /dev/hdxxx /test -o index
>     mkdir /test/foo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------95506487F904297F76BDD90B
Content-Type: text/plain; charset=us-ascii;
 name="c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="c"

execve("/bin/mv", ["mv", "a", "b"], [/* 47 vars */]) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40007000
mprotect(0x40000000, 21025, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
mprotect(0x8048000, 52997, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
stat("/etc/ld.so.cache", {st_mode=S_IFREG|0644, st_size=44476, ...}) = 0
open("/etc/ld.so.cache", O_RDONLY)      = 3
mmap(NULL, 44476, PROT_READ, MAP_SHARED, 3, 0) = 0x40008000
close(3)                                = 0
stat("/etc/ld.so.preload", {st_mode=S_IFREG|0644, st_size=1, ...}) = 0
open("/etc/ld.so.preload", O_RDONLY)    = 3
mmap(NULL, 2, PROT_READ|PROT_WRITE, MAP_PRIVATE, 3, 0) = 0x40013000
close(3)                                = 0
munmap(0x40013000, 2)                   = 0
open("/lib/libc.so.5", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000*\1\000"..., 4096) = 4096
mmap(NULL, 786432, PROT_NONE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40013000
mmap(0x40013000, 555135, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x40013000
mmap(0x4009b000, 21344, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x87000) = 0x4009b000
mmap(0x400a1000, 204364, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x400a1000
close(3)                                = 0
mprotect(0x40013000, 555135, PROT_READ|PROT_WRITE|PROT_EXEC) = 0
munmap(0x40008000, 44476)               = 0
mprotect(0x8048000, 52997, PROT_READ|PROT_EXEC) = 0
mprotect(0x40013000, 555135, PROT_READ|PROT_EXEC) = 0
mprotect(0x40000000, 21025, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
geteuid()                               = 0
getuid()                                = 0
getgid()                                = 0
getegid()                               = 0
brk(0x80568bc)                          = 0x80568bc
brk(0x8057000)                          = 0x8057000
geteuid()                               = 0
ioctl(0, TCGETS, {B38400 opost isig icanon echo ...}) = 0
stat("b", 0xbffff76c)                   = -1 ENOENT (No such file or directory)
lstat("a", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("b", 0x8056660)                   = -1 ENOENT (No such file or directory)
rename("a", "b")                        = -1 EIO (Input/output error)
write(2, "mv: ", 4mv: )                     = 4
write(2, "cannot move `a\' to `b\'", 22cannot move `a' to `b') = 22
stat("/etc/locale/C/libc.cat", 0xbffff2f0) = -1 ENOENT (No such file or directory)
stat("/usr/share/locale/C/libc.cat", 0xbffff2f0) = -1 ENOENT (No such file or directory)
stat("/usr/share/locale/libc/C", 0xbffff2f0) = -1 ENOENT (No such file or directory)
stat("/usr/share/locale/C/libc.cat", 0xbffff2f0) = -1 ENOENT (No such file or directory)
stat("/usr/local/share/locale/C/libc.cat", 0xbffff2f0) = -1 ENOENT (No such file or directory)
write(2, ": I/O error", 11: I/O error)             = 11
write(2, "\n", 1
)                       = 1
_exit(1)                                = ?

--------------95506487F904297F76BDD90B--

