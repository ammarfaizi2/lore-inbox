Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWEVOkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWEVOkp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 10:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWEVOkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 10:40:45 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:16317 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750873AbWEVOko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 10:40:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Content-ID:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Message-Id;
  b=zXlNJ7D7ddWrbLKsRKaG9yqkTepgpyXxZVB7in6gCcSyAFhuCaeiTz0Wtdn7UtxAeDDbgDGlGCvn5F8ZRfMthYcu+ppsSTwzFHKG9JxdoGrWrCLIbUraA5leFNXZWOBQ4rtfhBvwRoqGiLH7iEmmh9zImMAsg+oKDUjNjD68E9k=  ;
Content-ID: <Pine.LNX.4.58.0605220914570.664@ucontrol.mobiledns.com>
From: Blaisorblade <blaisorblade@yahoo.it>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Fwd: [BUG] 2.6.16 extra ptrace trap on syscall exit
Date: Mon, 22 May 2006 16:40:36 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k1ccEqBJsYdLu8+"
Message-Id: <200605221640.36998.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--Boundary-00=_k1ccEqBJsYdLu8+
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline



=2D---------  Forwarded Message  ----------

Subject: [BUG] 2.6.16 extra ptrace trap on syscall exit
Date: Monday 22 May 2006 15:22
=46rom: Steven James <pyro@linuxlabs.com>
To: Roland McGrath <roland@redhat.com>
Cc: User-mode-linux-devel@lists.sourceforge.net, Blaisorblade=20
<blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

Greetings,

While working on a syscall emulator similar in structure to
user-mode-linux, I found that for many but not all system calls, the
ptracing parent is notified of the system call exit twice on x86_64 hosts.

This can be trivially demonstrated by running strace on a test program
that makes a non-existant system call such as the attached ptrace_test.c
(see output below)

=46urther testing shows that the bug only occurs when ptracing a 64 bit
process. 32 bit target processes ptrace fine.

This problem also appears to crash user-mode-linux guest kernels running
on x86_64.

=46rom Blaisorblade:
>I have uml/64-bit (AMD64) not working on 2.6.16/64bit, while uml-32bit
>works fine on it, and the same uml/64-bit binaries work fine on 2.6.15. I

haven't

>tracked it down fully, but could it be related? Possibly yes because I

now

>seem to recall you run 64-bit host. So you likely found our bug!

I confirm the problem does not occur on the 2.6.15.7 kernel.

strace ./ptrace_test on 2.6.16.16:
strace ./ptrace_test
execve("./ptrace_test", ["./ptrace_test"], [/* 24 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"prime", ...}) =3D 0
brk(0)                                  =3D 0x501000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D
0x2b2cf0826000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D142523, ...}) =3D 0
mmap(NULL, 142523, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x2b2cf0827000
close(3)                                =3D 0
open("/lib64/tls/libc.so.6", O_RDONLY)  =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\305\1\356"...,
640) =3D 640
lseek(3, 624, SEEK_SET)                 =3D 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\4\0\0\0"..., 32) =3D
32
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1613968, ...}) =3D 0
mmap(0x33ee000000, 2305992, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x33ee000000
mprotect(0x33ee12a000, 1085384, PROT_NONE) =3D 0
mmap(0x33ee229000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x129000) =3D 0x33ee229000
mmap(0x33ee22f000, 16328, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x33ee22f000
close(3)                                =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D
0x2b2cf084a000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D
0x2b2cf084b000
mprotect(0x33ee229000, 16384, PROT_READ) =3D 0
mprotect(0x33edd14000, 4096, PROT_READ) =3D 0
arch_prctl(0x1002, 0x2b2cf084ab00)      =3D 0
munmap(0x2b2cf0827000, 142523)          =3D 0
write(1, "Pyro was here!\n", 15Pyro was here!
)        =3D 15
write(1, "last write returned 15, (errno=3D0"..., 34last write returned 15,
(errno=3D0)
) =3D 34
syscall_500(0x1, 0x22, 0xffffffffffffffff, 0, 0x1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) =3D -1 (errno 38)
syscall_500(0x1, 0x22, 0xffffffffffffffff, 0, 0x1, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) =3D -1 (errno 38)
inval(1) returned -1, (errno=3D38)
exit_group(0, 0, 0x33ee065280, 0x2, 0x3c <unfinished ... exit status 0>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=3D

strace ./ptrac_test32 on 2.6.16.16:
strace ./ptrace_test32
execve("./ptrace_test32", ["./ptrace_test32"], [/* 24 vars */]) =3D 0
[ Process PID=3D3538 runs in 32 bit mode. ]
uname({sys=3D"Linux", node=3D"prime", ...}) =3D 0
brk(0)                                  =3D 0x804a000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(0x3, 0xffffbf18)                =3D 0
old_mmap(0x22cbb00000000, 8589934593, PROT_READ|PROT_WRITE, 0xf /* MAP_???
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_POPULATE|MAP_NONBLOCK|MAP_GROW=
SD
OWN|MAP_DENYWRITE|MAP_EXECUTABLE|MAP_LOCKED|0xfffe06c0, 64768,
 0x1af3ef00000000) =3D 0xfffffffff7fcd000
close(3)                                =3D 0
open("/lib/tls/libc.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\357"..., 512)
=3D 512
fstat64(0x3, 0xffffbfac)                =3D 0
old_mmap(0x100000000000, 146028888067,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 0x4
/* MAP_???
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_DEN=
YW
RITE|MAP_LOCKED|0x47dc0680, 1205695736, 0x847dd0435) =3D 0xfffffffff7fcc000
old_mmap(0x12acbc47dda000, 8804682956805, PROT_READ|PROT_WRITE, MAP_FILE,
0, 0) =3D 0x47dda000
mprotect(0x47efe000, 27836, PROT_NONE)  =3D 0
old_mmap(0x400047eff000, 8873402433539, PROT_READ|PROT_WRITE, MAP_FILE, 0,
0) =3D 0x47eff000
old_mmap(0x1cbc47f03000, 214748364803,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8,
MAP_FILE, 0, 0) =3D 0x47f03000
close(3)                                =3D 0
old_mmap(0x100000000000, 146028888067,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN|PROT_GROWSUP|0xfcfffff8, 0x4
/* MAP_???
*/|MAP_FIXED|MAP_ANONYMOUS|MAP_NORESERVE|MAP_NONBLOCK|MAP_GROWSDOWN|MAP_DEN=
YW
RITE|MAP_LOCKED|0x47dc0680, 2832, 0x2047dce4a2) =3D 0xfffffffff7fcb000
mprotect(0x47eff000, 8192, PROT_READ)   =3D 0
mprotect(0x47dd6000, 4096, PROT_READ)   =3D 0
set_thread_area(0xffffc724)             =3D 0
munmap(0xf7fcd000, 142523)              =3D 0
write(1, "Pyro was here!\n", 15Pyro was here!
)        =3D 15
write(1, "last write returned 15, (errno=3D0"..., 34last write returned 15,
(errno=3D0)
) =3D 34
syscall_500(0x1, 0xffffc9c8, 0x80484fe, 0x80484fe, 0x1, 0xffffc5b0,
0xffffc9c8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0) =3D -1 (errno 38)
write(1, "inval(1) returned -1, (errno=3D38)"..., 33inval(1) returned -1,
(errno=3D38)
) =3D 33
exit_group(0)                           =3D ?
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

and strace ./ptrace_test on 2.6.15.7:
strace ./ptrace_test
execve("./ptrace_test", ["./ptrace_test"], [/* 24 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"prime", ...}) =3D 0
brk(0)                                  =3D 0x501000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D
0x2aaaaaaab000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D142523, ...}) =3D 0
mmap(NULL, 142523, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x2aaaaaaac000
close(3)                                =3D 0
open("/lib64/tls/libc.so.6", O_RDONLY)  =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0`\305\1\356"...,
640) =3D 640
lseek(3, 624, SEEK_SET)                 =3D 624
read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\4\0\0\0"..., 32) =3D
32
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1613968, ...}) =3D 0
mmap(0x33ee000000, 2305992, PROT_READ|PROT_EXEC,
MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x33ee000000
mprotect(0x33ee12a000, 1085384, PROT_NONE) =3D 0
mmap(0x33ee229000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x129000) =3D 0x33ee229000
mmap(0x33ee22f000, 16328, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x33ee22f000
close(3)                                =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D
0x2aaaaaacf000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =3D
0x2aaaaaad0000
mprotect(0x33ee229000, 16384, PROT_READ) =3D 0
mprotect(0x33edd14000, 4096, PROT_READ) =3D 0
arch_prctl(0x1002, 0x2aaaaaacfb00)      =3D 0
munmap(0x2aaaaaaac000, 142523)          =3D 0
write(1, "Pyro was here!\n", 15Pyro was here!
)        =3D 15
write(1, "last write returned 15, (errno=3D0"..., 34last write returned 15,
(errno=3D0)
) =3D 34
syscall_500(0x1, 0x22, 0x33ee0b8642, 0, 0x1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) =3D -1 (errno 38)
write(1, "inval(1) returned -1, (errno=3D38)"..., 33inval(1) returned -1,
(errno=3D38)
) =3D 33
exit_group(0, 0, 0x33ee065280, 0x2, 0x3c <unfinished ... exit status 0>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

G'day,
sjames



by Linux Labs International, Inc.
   Steven James, CTO

55 Marietta Street
Suite 1830
Atlanta, Ga 30303
866 824 9737 support

=2D------------------------------------------------------

=2D-=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_k1ccEqBJsYdLu8+
Content-Type: TEXT/X-CSRC;
  charset="us-ascii";
  NAME="ptrace_test.c"
Content-Transfer-Encoding: BASE64
Content-Disposition: ATTACHMENT; FILENAME="ptrace_test.c"

I2luY2x1ZGUgPHN0ZGlvLmg+DQojaW5jbHVkZSA8ZXJybm8uaD4NCiNpbmNs
dWRlIDx1bmlzdGQuaD4NCg0KI2luY2x1ZGUgPGxpbnV4L3VuaXN0ZC5oPg0K
I2RlZmluZSBfX05SX2ludmFsCTUwMA0KDQpfc3lzY2FsbDEobG9uZywgaW52
YWwsIGxvbmcsIHZhbCk7DQoNCmludCBtYWluKGludCBhcmdjLCBjaGFyICph
cmd2W10pIHsNCglpbnQgcmV0Ow0KCWNoYXIgKm1zZyA9ICJQeXJvIHdhcyBo
ZXJlIVxuIjsNCgljaGFyIGJ1ZmZlclsxMDI0XTsNCg0KCXJldCA9IHdyaXRl
KDEsIG1zZywgc3RybGVuKG1zZykpOw0KCXJldCA9IHNwcmludGYoIGJ1ZmZl
ciwgImxhc3Qgd3JpdGUgcmV0dXJuZWQgJWQsIChlcnJubz0lZClcbiIsIHJl
dCwgZXJybm8pOw0KCXdyaXRlKDEsIGJ1ZmZlciwgcmV0KTsNCg0KCXJldCA9
IGludmFsKDEpOw0KCXJldCA9IHNwcmludGYoIGJ1ZmZlciwgImludmFsKDEp
IHJldHVybmVkICVkLCAoZXJybm89JWQpXG4iLCByZXQsIGVycm5vKTsNCgl3
cml0ZSgxLCBidWZmZXIsIHJldCk7DQoNCglyZXR1cm4gMDsNCn0NCg==

--Boundary-00=_k1ccEqBJsYdLu8+--

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
