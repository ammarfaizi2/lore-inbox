Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbSKONjb>; Fri, 15 Nov 2002 08:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbSKONjb>; Fri, 15 Nov 2002 08:39:31 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:41932 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S264859AbSKONja>; Fri, 15 Nov 2002 08:39:30 -0500
Message-ID: <3DD50989.6040409@hannes-reinecke.de>
Date: Fri, 15 Nov 2002 15:49:45 +0100
From: Hannes Reinecke <mail@hannes-reinecke.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.47: Oops on mount() (Alpha164 SX) 
Content-Type: multipart/mixed;
 boundary="------------090804000400070106070409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090804000400070106070409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

after (again) trying to run a recent kernel (2.5.47) on my alpha, 
mount() oopses in __copy_user() (See attached decoded Oops trace).
Initial mount of the root-filesystem works; /sbin/mount gives:

/dev/sdc1 on / type ext2 (rw,errors=remount-ro)
proc on /proc type proc (rw)

Apart from this system boots up, only the root-fs is mounted read-only 
(since the /sbin/mount failed). Hence the entry for /proc is a lie, 
since proc is actually _not_ mounted.

This happened since at least 2.5.41; kernels before that were even 
refusing to boot. System is AlphaPC164 SX, recently upgraded Debian 3, 
kernel compiled with gcc-2.95.4, mount-2.11w; all of which should be 
recent enough, at least according to Changes document ...

If someone in the know could have a look at this I'd be very grateful.
At the moment it's a bit annoying; the last kernel to actually _run_ on 
this machine are the 2.4.XX series.

Please cc me directly; I'not (anymore) on lkml.

Best regards,

Hannes


--------------090804000400070106070409
Content-Type: text/plain;
 name="mount.oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mount.oops"

Unable to handle kernel paging request at virtual address 000000012002a000
mount(229): Oops 0
pc = [<fffffc000043ba40>]  ra = [<fffffc00003890e0>]  ps = 0000    Not tainted
v0 = 00000000000002a0  t0 = 0000000000000000  t1 = 000000012002a2a0
t2 = 0000000000000000  t3 = 00000000000002a0  t4 = fffffc000057a858
t5 = fffffc001f38bd60  t6 = 000000012002a000  t7 = fffffc001f444000
s0 = 00000001200282a0  s1 = fffffc001f38a000  s2 = fffffc001f447ef8
s3 = 0000000120028320  s4 = 00000000c0ed0000  s5 = 000000011ffffeed
s6 = 0000000120028230
a0 = fffffc0000bacd90  a1 = 0000000000000000  a2 = 0000000000002000
a3 = 00000000c0ed0000  a4 = 0000000120028320  a5 = 000000011ffffb88
t8 = 0000000000002000  t9 = 0000020000144d20  t10= 0000000000000008
t11= 00000200001bd960  pv = fffffc000043b940  at = fffffc0000389148
gp = fffffc000064a268  sp = fffffc001f447ea8
Trace:fffffc00003899c0 fffffc00003130e4 
Code: f41ffff5  c3e00013  e480000a  2ffe0000  47ff041f  2ffe0000 <a4270000> 4081
1524 
Error (Oops_code_to_file): Unable to open mkstemp file '/tmp/ksymoops.usm2Gf'

/usr/src/ksymoops-2.4.7/ksymoops: Read-only file system


>>RA;  fffffc00003890e0 <copy_mount_options+40/140>

>>PC;  fffffc000043ba40 <__copy_user+100/1d4>   <=====

Trace; fffffc00003899c0 <sys_mount+40/160>
Trace; fffffc00003130e4 <entSys+a4/c0>

Unable to handle kernel paging request at virtual address 000000012002a000
mount(230): Oops 0
pc = [<fffffc000043ba40>]  ra = [<fffffc00003890e0>]  ps = 0000    Not tainted
v0 = 00000000000002a0  t0 = 0000000000000000  t1 = 000000012002a2a0
t2 = 0000000000000000  t3 = 00000000000002a0  t4 = fffffc000057a858
t5 = fffffc001f453d60  t6 = 000000012002a000  t7 = fffffc001f178000
s0 = 00000001200282a0  s1 = fffffc001f452000  s2 = fffffc001f17bef8
s3 = 0000000120028320  s4 = 00000000c0ed0000  s5 = 000000011ffffeee
s6 = 0000000120028230
a0 = fffffc0000baecd0  a1 = 0000000000000000  a2 = 0000000000002000
a3 = 00000000c0ed0000  a4 = 0000000120028320  a5 = 000000011ffffb88
t8 = 0000000000002000  t9 = 0000020000144d20  t10= 0000000000000008
t11= 00000200001bd960  pv = fffffc000043b940  at = fffffc0000389148
gp = fffffc000064a268  sp = fffffc001f17bea8
Trace:fffffc00003899c0 fffffc00003130e4 
Code: f41ffff5  c3e00013  e480000a  2ffe0000  47ff041f  2ffe0000 <a4270000> 4081
1524 
Error (Oops_code_to_file): Unable to open mkstemp file '/tmp/ksymoops.7yNjvH'

/usr/src/ksymoops-2.4.7/ksymoops: Read-only file system


>>RA;  fffffc00003890e0 <copy_mount_options+40/140>

>>PC;  fffffc000043ba40 <__copy_user+100/1d4>   <=====

Trace; fffffc00003899c0 <sys_mount+40/160>
Trace; fffffc00003130e4 <entSys+a4/c0>


1 warning and 8 errors issued.  Results may not be reliable.
:

--------------090804000400070106070409--

