Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSFAOC2>; Sat, 1 Jun 2002 10:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSFAOC1>; Sat, 1 Jun 2002 10:02:27 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:42637 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S317020AbSFAOCY>;
	Sat, 1 Jun 2002 10:02:24 -0400
Subject: nfs problem 2.4.19-pre9
From: Kenneth Johansson <ken@canit.se>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-Q+xKZzlL4wxfemWx3rOB"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Jun 2002 16:02:23 +0200
Message-Id: <1022940144.1186.35.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Q+xKZzlL4wxfemWx3rOB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have had a problem for some time that processes get stuck in D state
and I now have a way to get this to happen at will.

One way to do this is to copy a file from one nfs mounted directory to
another. It dose not happen on the same mount and not when copying from
nfs to a local disk. To make this even more complex it works with cp and
mv but not in mc(midnight commander F6 ).

The nfs mounts is from the same server and same disk on that server,
mounted using automount.

linux version is 
client 2.4.19-pre9
server 2.4.19-pre8 using reiserfs on a raid1 partition.

here is a calltrace on mc when it is dead.
Trace; c0129875 <__lock_page+a1/c8>
Trace; c01298b1 <lock_page+15/1c>
Trace; c0129faa <do_generic_file_read+28e/464>
Trace; c012a466 <generic_file_read+7e/130>
Trace; c012a360 <file_read_actor+0/88>
Trace; c0173a2d <nfs_file_read+9d/ac>
Trace; c01372f7 <sys_read+8f/100>
Trace; c01088cb <system_call+33/38>

The nfs mount is unusable after this. Every process that uses it enters
D state.

I have attached a strace of mc when moving file /home/ken/3 to
/delta/kernel/
mc 4.5.55




And now to something completely different.
(please forward to gconf people)

I also found what I would call a serious problem with gconf during the
testing. It goes something like this.

1. have homedir on nfs
2. pull network cable when gconf app active(nautilus, galeon ..)
3. Shutdown
4. insert network cable. restart
5. watch all gconf apps fail to start.

gconf 1.0.9


--=-Q+xKZzlL4wxfemWx3rOB
Content-Disposition: attachment; filename=mc.log
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=mc.log; charset=ISO-8859-1

eteuid32()                             =3D 1000
stat64("/delta/kernel", {st_mode=3DS_IFDIR|S_ISGID|0755, st_size=3D240, ...=
}) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[23;28H\33[m\17\17\33[37;44m          \16"..., 1176) =3D 1176
gettimeofday({1022936718, 201427}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[28;26H\33[m\17\17\33[30;47mTarget   /d"..., 45) =3D 45
gettimeofday({1022936718, 202476}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
lstat64("/home/ken/2", {st_mode=3DS_IFREG|0664, st_size=3D1048576, ...}) =
=3D 0
lstat64("/delta/kernel/2", 0xbffff88c)  =3D -1 ENOENT (No such file or dire=
ctory)
rename("/home/ken/2", "/delta/kernel/2") =3D -1 EXDEV (Invalid cross-device=
 link)
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 203840}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 204324}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
stat64("/delta/kernel/2", 0xbfffd78c)   =3D -1 ENOENT (No such file or dire=
ctory)
lstat64("/home/ken/2", {st_mode=3DS_IFREG|0664, st_size=3D1048576, ...}) =
=3D 0
gettimeofday({1022936718, 205249}, NULL) =3D 0
open("/home/ken/2", O_RDONLY|O_LARGEFILE) =3D 4
fstat64(4, {st_mode=3DS_IFREG|0664, st_size=3D1048576, ...}) =3D 0
open("/delta/kernel/2", O_WRONLY|O_CREAT|O_TRUNC|O_LARGEFILE, 0600) =3D 7
fstat64(7, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[30;26HFile\33[5C[\33[40C]   0%", 28) =3D 28
gettimeofday({1022936718, 207295}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
read(4, "RIFF\324\355;\24AVI LISTp\"\0\0hdrlavih8\0\0\0"..., 8192) =3D 8192
gettimeofday({1022936718, 209270}, NULL) =3D 0
gettimeofday({1022936718, 209332}, NULL) =3D 0
write(7, "RIFF\324\355;\24AVI LISTp\"\0\0hdrlavih8\0\0\0"..., 8192) =3D 819=
2
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 209986}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[30;80H1\33[30;82H", 17)   =3D 17
gettimeofday({1022936718, 211172}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
read(4, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192) =
=3D 8192
gettimeofday({1022936718, 211684}, NULL) =3D 0
gettimeofday({1022936718, 211744}, NULL) =3D 0
write(7, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 8192)=
 =3D 8192
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 212366}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[30;36H\33[1m\33[37;40m \33[43C\33[m\17\33["..., 47) =3D 47
gettimeofday({1022936718, 213603}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
read(4, "\177\177\177\177\177\177\177\177\177\177\177\177\177\177"..., 8192=
) =3D 8192
gettimeofday({1022936718, 908626}, NULL) =3D 0
gettimeofday({1022936718, 908709}, NULL) =3D 0
write(7, "\177\177\177\177\177\177\177\177\177\177\177\177\177\177"..., 819=
2) =3D 8192
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 909309}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 909890}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
read(4, "}}~~~~~~}}~~\177\200\200\200\200\201\202\202\203\202\202"..., 8192=
) =3D 8192
gettimeofday({1022936718, 910396}, NULL) =3D 0
gettimeofday({1022936718, 910456}, NULL) =3D 0
write(7, "}}~~~~~~}}~~\177\200\200\200\200\201\202\202\203\202\202"..., 819=
2) =3D 8192
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 910892}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[30;80H3\33[30;82H", 17)   =3D 17
gettimeofday({1022936718, 912201}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
read(4, "\177\200\201\201\202\202\202\201\201\177~}||}~\177\201"..., 8192) =
=3D 8192
gettimeofday({1022936718, 912711}, NULL) =3D 0
gettimeofday({1022936718, 912771}, NULL) =3D 0
write(7, "\177\200\201\201\202\202\202\201\201\177~}||}~\177\201"..., 8192)=
 =3D 8192
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
gettimeofday({1022936718, 913260}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
select(1024, [0], NULL, NULL, {0, 0})   =3D 0 (Timeout)
write(1, "\33[30;37H\33[1m\33[37;40m \33[42C\33[m\17\33["..., 47) =3D 47
gettimeofday({1022936718, 914553}, NULL) =3D 0
rt_sigaction(SIGINT, {0x8077c78, [], 0x4000000}, NULL, 8) =3D 0
select(1024, [0 3], NULL, NULL, {0, 0}) =3D 0 (Timeout)
rt_sigaction(SIGINT, {SIG_IGN}, NULL, 8) =3D 0
read(4,=20

--=-Q+xKZzlL4wxfemWx3rOB--

