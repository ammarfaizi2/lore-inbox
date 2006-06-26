Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933332AbWFZWvn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933332AbWFZWvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933386AbWFZWvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:51:07 -0400
Received: from pool-72-66-204-100.ronkva.east.verizon.net ([72.66.204.100]:22981
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S933332AbWFZWur (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:50:47 -0400
Message-Id: <200606262250.k5QMoZGQ004908@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm2 hrtimer code wedges at boot?
In-Reply-To: Your message of "Mon, 26 Jun 2006 17:41:07 EDT."
             <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <20060624061914.202fbfb5.akpm@osdl.org>
            <200606262141.k5QLf7wi004164@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1151362234_3805P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 26 Jun 2006 18:50:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1151362234_3805P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Jun 2006 17:41:07 EDT, Valdis.Kletnieks@vt.edu said:
> I'm seeing a 2-minute or so hang at system startup, seems to be hrtimer
> related.  This is at fairly early userspace - the initrd has run, but we're not
> into /etc/rc.sysinit yet (although the root filesystem is mounted and we have
> a kjournald for it).  Poking with sysrq-T and sysrq-R gets me this:
> 
> [  108.301806] Pid: 4, comm:              khelper
> [  108.330565] EIP: 0060:[<c0119f48>] CPU: 0
> [  108.359315] EIP is at getnstimeofday+0x9e/0xb8
> [  108.387820]  EFLAGS: 00000207    Not tainted  (2.6.17-mm2 #1)
> [  108.416344] EAX: efed073c EBX: efed073c ECX: 00000000 EDX: 0f16d9ba
> [  108.444765] ESI: a7955c5a EDI: 4a12cf06 EBP: effd0e5c DS: 007b ES: 007b
> [  108.473303] CR0: 8005003b CR2: b7d9acb0 CR3: 2ffbc000 CR4: 000006d0
> [  108.501579]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
> [  108.530366]  <c0111f3c> do_fork+0x8d/0x16a  <c0100a27> kernel_thread+0x6c/0x74
> [  108.559363]  <c0120431> __call_usermodehelper+0x2b/0x44  <c0120982> run_workqueue+0x94/0xe9
> [  108.588523]  <c0120e64> worker_thread+0xe1/0x115  <c01232b2> kthread+0xb0/0xdc
> [  108.617618]  <c01006c5> kernel_thread_helper+0x5/0xb

Seems to be a problem with time in general - another reboot, and lots of
sysrq-P, and I got these (note that this time around, rc.sysinit *did* get
started, so we're apparently just making very slow progress rather than
being hung and spinning for 90 seconds....

[   81.127021] SysRq : Show Regs
[   81.147732] 
[   81.168172] Pid: 1, comm:                 init
[   81.188564] EIP: 0060:[<c0119ffc>] CPU: 0
[   81.208879] EIP is at do_gettimeofday+0x9a/0xc5
[   81.229104]  EFLAGS: 00000217    Not tainted  (2.6.17-mm2 #1)
[   81.249441] EAX: d8ad347c EBX: f380a310 ECX: 66521e65 EDX: 226cbe02
[   81.270003] ESI: ffffffff EDI: 00000000 EBP: c16d7fa4 DS: 007b ES: 007b
[   81.290974] CR0: 8005003b CR2: b7e7f0a8 CR3: 2ffbc000 CR4: 000006d0
[   81.312250]  <c01169ae> sys_time+0xe/0x2f  <c0102261> sysenter_past_esp+0x56/0x79
[   86.545414] SysRq : Show Regs
[   86.566974] 
[   86.588290] Pid: 1, comm:                 init
[   86.609807] EIP: 0060:[<c0119ffc>] CPU: 0
[   86.631315] EIP is at do_gettimeofday+0x9a/0xc5
[   86.652737]  EFLAGS: 00000213    Not tainted  (2.6.17-mm2 #1)
[   86.674312] EAX: 1c0a39da EBX: f380a310 ECX: 56a2f30b EDX: d7a49202
[   86.696028] ESI: ffffffff EDI: 00000000 EBP: c16d7fa4 DS: 007b ES: 007b
[   86.717769] CR0: 8005003b CR2: b7e7f0a8 CR3: 2ffbc000 CR4: 000006d0
[   86.739558]  <c01169ae> sys_time+0xe/0x2f  <c0102261> sysenter_past_esp+0x56/0x79
[   88.427273] SysRq : Show Regs
[   88.449183] 
[   88.470683] Pid: 421, comm:           rc.sysinit
[   88.492222] EIP: 0060:[<c0119f40>] CPU: 0
[   88.513633] EIP is at getnstimeofday+0x96/0xb8
[   88.535030]  EFLAGS: 00000283    Not tainted  (2.6.17-mm2 #1)
[   88.556511] EAX: efed47bc EBX: efed47bc ECX: 00000000 EDX: 0b16e0d5
[   88.578361] ESI: b2c0c4bc EDI: 27c01a01 EBP: ef7d5f04 DS: 007b ES: 007b
[   88.600340] CR0: 8005003b CR2: b7e7f0a8 CR3: 2f26d000 CR4: 000006d0
[   88.622445]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
[   88.645207]  <c0111f3c> do_fork+0x8d/0x16a  <c010099b> sys_clone+0x25/0x2a
[   88.668218]  <c0102261> sysenter_past_esp+0x56/0x79 
[   94.619871] SysRq : Show Regs
[   94.642631] 
[   94.664936] Pid: 421, comm:           rc.sysinit
[   94.687452] EIP: 0060:[<c0119f48>] CPU: 0
[   94.709938] EIP is at getnstimeofday+0x9e/0xb8
[   94.732370]  EFLAGS: 00000203    Not tainted  (2.6.17-mm2 #1)
[   94.755031] EAX: efed47bc EBX: efed47bc ECX: 00000000 EDX: 0b16e0d5
[   94.777989] ESI: cd6d54bc EDI: 179d2144 EBP: ef7d5f04 DS: 007b ES: 007b
[   94.800978] CR0: 8005003b CR2: b7e7f0a8 CR3: 2f26d000 CR4: 000006d0
[   94.823986]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
[   94.847793]  <c0111f3c> do_fork+0x8d/0x16a  <c010099b> sys_clone+0x25/0x2a
[   94.871627]  <c0102261> sysenter_past_esp+0x56/0x79 
[   99.793372] SysRq : Show Regs
[   99.816696] 
[   99.839669] Pid: 1, comm:                 init
[   99.862968] EIP: 0060:[<c0119ffc>] CPU: 0
[   99.886127] EIP is at do_gettimeofday+0x9a/0xc5
[   99.909505]  EFLAGS: 00000213    Not tainted  (2.6.17-mm2 #1)
[   99.933139] EAX: bb9074fb EBX: f380a310 ECX: 317e8ecb EDX: c0228802
[   99.957174] ESI: ffffffff EDI: 00000000 EBP: c16d7fa4 DS: 007b ES: 007b
[   99.981281] CR0: 8005003b CR2: b7e7f0a8 CR3: 2ffbc000 CR4: 000006d0
[  100.005492]  <c01169ae> sys_time+0xe/0x2f  <c0102261> sysenter_past_esp+0x56/0x79
[  103.357517] SysRq : Show Regs
[  103.380851] 
[  103.403016] Pid: 421, comm:           rc.sysinit
[  103.425480] EIP: 0060:[<c0119f48>] CPU: 0
[  103.447836] EIP is at getnstimeofday+0x9e/0xb8
[  103.470260]  EFLAGS: 00000287    Not tainted  (2.6.17-mm2 #1)
[  103.493102] EAX: efed47bc EBX: efed47bc ECX: 00000000 EDX: 0b16e0d5
[  103.516288] ESI: 09ac3ebc EDI: 00eac4ec EBP: ef7d5f04 DS: 007b ES: 007b
[  103.539636] CR0: 8005003b CR2: b7e7f0a8 CR3: 2f26d000 CR4: 000006d0
[  103.563122]  <c0125c0c> ktime_get_ts+0x14/0x3f  <c0110f84> copy_process+0x395/0x1111
[  103.587133]  <c0111f3c> do_fork+0x8d/0x16a  <c010099b> sys_clone+0x25/0x2a
[  103.610981]  <c0102261> sysenter_past_esp+0x56/0x79 
[  105.595474] SysRq : Show Regs
[  105.618994] 
[  105.641896] Pid: 1, comm:                 init
[  105.664562] EIP: 0060:[<c0119ffc>] CPU: 0
[  105.687319] EIP is at do_gettimeofday+0x9a/0xc5
[  105.710233]  EFLAGS: 00000217    Not tainted  (2.6.17-mm2 #1)
[  105.733426] EAX: 0b996673 EBX: f380a310 ECX: 1edc1a9c EDX: c769d802
[  105.756826] ESI: ffffffff EDI: 00000000 EBP: c16d7fa4 DS: 007b ES: 007b
[  105.780234] CR0: 8005003b CR2: b7d1f000 CR3: 2ffbc000 CR4: 000006d0
[  105.803629]  <c01169ae> sys_time+0xe/0x2f  <c0102261> sysenter_past_esp+0x56/0x79
[  106.787956] Real Time Clock Driver v1.12ac

Every single one doing something time-related.  I'm pretty sure that the
RTC driver is a red herring - I stuck a 'set -x' in rc.sysinit, and we're
moving along nicely by that point - whatever is wedging it has broken loose
by that point.

--==_Exmh_1151362234_3805P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEoGS6cC3lWbTT17ARAmaGAJ47bTrzFx3SFkwE/sfZ5SDSvq4A3wCgl7LY
2pr+3dv/CTEhuc8+weNyRM8=
=uqaw
-----END PGP SIGNATURE-----

--==_Exmh_1151362234_3805P--
