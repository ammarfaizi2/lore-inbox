Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRAFLTc>; Sat, 6 Jan 2001 06:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRAFLTN>; Sat, 6 Jan 2001 06:19:13 -0500
Received: from 213-167-219-235.flat.galactica.it ([213.167.219.235]:25348 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S130510AbRAFLTG>; Sat, 6 Jan 2001 06:19:06 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0: apache doesn't start
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 06 Jan 2001 12:19:59 +0100
Message-ID: <873dex7wrk.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have 2.4.0 running, with devfs enabled and devfsd providing
compatibility.
I've tried to clean-up as much as possible in the process of
activating devfsd, but something escapes my knowledge:

it seems that shm is now mounted by devfs in /dev/shm, instead of
being mounted by means of /etc/fstab wherever one needs it.
previously shm was reported as having a definite size (something like
8 Gigabyte ?), now it is reported as 0 (like all other pseudo fs).

And here comes apache that can't perform some operations in shm and
dies as soon as it starts:

root@penny:/var/log/apache # tail error.log 
[Sat Jan  6 11:19:09 2001] [error] Cannot resolve host name ik5pvx.dyndns.org --- ignoring!
[Sat Jan  6 11:19:09 2001] [emerg] (28)No space left on device: could not call shmget

this is the last part of 'strace apache'

uname({sys="Linux", node="penny", ...}) = 0
socket(PF_UNIX, SOCK_STREAM, 0)         = 0
connect(0, {sin_family=AF_UNIX, path="                                                                                       /var/run/.nscd_socket"}, 110) = 0
write(0, "\2\0\0\0\4\0\0\0\6\0\0\0", 12) = 12
write(0, "penny\0", 6)                  = 6
read(0, "\0\0\0\0\1\0\0\0\26\0\0\0\0\0\0\0\2\0\0\0\4\0\0\0\3\0\0"..., 32) = 32
readv(0, [{"penny.ik5pvx.ampr.org\0", 22}, {"", 0}, {"\300\250\27\1,\206\322\361\300\250\26\1", 12}, {"\204\252\t\10tk\23\10\300\230\23\10\216\3363@D\225 @\""..., 48}], 4) = 34
close(0)                                = 0
open("/etc/hosts", O_RDONLY)            = 0
shmat(0, 0x1, 0x1ptrace: umoven: Input/output error
)                      = ?
shmat(0, 0x1, 0x2ptrace: umoven: Input/output error
)                      = ?
fstat64(0, 0xbffff3bc)                  = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4065f000
read(0, "127.0.0.1\t\tlocalhost\n#44.134.210"..., 4096) = 496
read(0, "", 4096)                       = 0
close(0)                                = 0
munmap(0x4065f000, 4096)                = 0
socket(PF_INET, SOCK_DGRAM, IPPROTO_IP) = 0
connect(0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("0.0.0.0")}}, 28) = 0
send(0, "^\216\1\0\0\1\0\0\0\0\0\0\5penny\6ik5pvx\4ampr\3o"..., 39, 0) = 39
gettimeofday({978779897, 895616}, NULL) = 0
poll([{fd=0, events=POLLIN, revents=POLLIN}], 1, 5000) = 1
recvfrom(0, "^\216\205\200\0\1\0\3\0\1\0\3\5penny\6ik5pvx\4ampr\3o"..., 1024, 0, {sin_family=AF_INET, sin_port=htons(53), sin_addr=inet_addr("127.0.0.1")}}, [16]) = 164
close(0)                                = 0
gettimeofday({978779897, 904972}, NULL) = 0
select(0, NULL, NULL, NULL, {0, 95028}) = 0 (Timeout)
open("/etc/apache/mime.types", O_RDONLY|0x8000) = 0
fstat64(0, 0xbfffd764)                  = 0
brk(0x813d000)                          = 0x813d000
fstat64(0, 0xbfffd57c)                  = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4065f000
read(0, "################################"..., 4096) = 4096
read(0, "t/x-csh\t\t\t\t\tcsh\ntext/x-csrc\t\t\t\t\t"..., 4096) = 468
read(0, "", 4096)                       = 0
close(0)                                = 0
munmap(0x4065f000, 4096)                = 0
open("/var/log/apache/rewrite.log", O_WRONLY|O_APPEND|O_CREAT|0x8000, 0644) = 0
shmat(0, 0x40209f20, 0ptrace: umoven: Input/output error
)                 = ?
close(0)                                = 0
brk(0x8140000)                          = 0x8140000
open("/var/log/apache/access.log", O_WRONLY|O_APPEND|O_CREAT|0x8000, 0644) = 0
shmat(0, 0x40209f20, 0ptrace: umoven: Input/output error
)                 = ?
close(0)                                = 0
open("/var/log/apache/cookie.log", O_WRONLY|O_APPEND|O_CREAT|0x8000, 0644) = 0
shmat(0, 0x40209f20, 0ptrace: umoven: Input/output error
)                 = ?
close(0)                                = 0
chdir("/")                              = 0
fork()                                  = 2617
_exit(0)                                = ?


now....
how do I use shm with devfs active ?

Pf


-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.0 #1 Fri Jan 5 22:35:41 CET 2001 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
