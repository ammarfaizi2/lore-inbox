Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750986AbVKILzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVKILzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVKILzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:55:10 -0500
Received: from gold.veritas.com ([143.127.12.110]:50994 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750986AbVKILzJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:55:09 -0500
Date: Wed, 9 Nov 2005 11:53:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: =?iso-8859-2?Q?Pawe=B3_S=B3owik?= <wik@iq.pl>
cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at mm/prio_tree.c:78
In-Reply-To: <20051108221648.GA30824@serv13>
Message-ID: <Pine.LNX.4.61.0511091127540.27511@goblin.wat.veritas.com>
References: <20051108221648.GA30824@serv13>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1576164022-1131537236=:27511"
X-OriginalArrivalTime: 09 Nov 2005 11:55:08.0540 (UTC) FILETIME=[6E801BC0:01C5E524]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1576164022-1131537236=:27511
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 8 Nov 2005, Pawe=C5=82 S=C5=82owik wrote:
>=20
> I had an oops on my home desktop, which is:
> Linux desk 2.6.14 #1 PREEMPT Sat Oct 29 16:05:58 CEST 2005 i686
> AMD Athlon(tm) XP 2000+ AuthenticAMD GNU/Linux

Thanks for the report: interesting; uncertain comments at the end.

> Syslog excerpt:
>=20
> Nov  8 21:05:01 desk ------------[ cut here ]------------
> Nov  8 21:05:01 desk kernel BUG at mm/prio_tree.c:78!
> Nov  8 21:05:01 desk invalid operand: 0000 [#1]
> Nov  8 21:05:01 desk PREEMPT=20
> Nov  8 21:05:01 desk Modules linked in: it87 hwmon_vid lm90 hwmon i2c_isa=
 i2c_viapro i2c_core snd_seq_midi snd_emu10k1_synth snd_emux_synth snd_seq_=
virmidi snd_seq_midi_emul snd_emu10k1 snd_util_mem snd_hwdep snd_via82xx sn=
d_ac97_codec snd_ac97_bus snd_mpu401_uart snd_rawmidi uhci_hcd cryptoloop l=
oop radeon drm via_agp agpgart
> Nov  8 21:05:01 desk CPU:    0
> Nov  8 21:05:01 desk EIP:    0060:[<c014192b>]    Not tainted VLI
> Nov  8 21:05:01 desk EFLAGS: 00010212   (2.6.14)=20
> Nov  8 21:05:01 desk EIP is at vma_prio_tree_add+0xab/0xc0
> Nov  8 21:05:01 desk eax: dfd98964   ebx: c0805124   ecx: 0000010f   edx:=
 00000110
> Nov  8 21:05:01 desk esi: dfd98964   edi: 00000000   ebp: dfd93474   esp:=
 dd8ffe9c
> Nov  8 21:05:01 desk ds: 007b   es: 007b   ss: 0068
> Nov  8 21:05:01 desk Process grep (pid: 31686, threadinfo=3Ddd8fe000 task=
=3Dc0d810b0)
> Nov  8 21:05:01 desk Stack: c4c3e284 db352334 c01460c0 c0805124 dfd98964 =
c4c3b964 dfd93460 00000000=20
> Nov  8 21:05:01 desk 00000000 00000000 c2e4bae0 dfd93460 da3d9700 c080512=
4 00000000 00000001=20
> Nov  8 21:05:01 desk db352334 c0147763 db352334 b7ee3000 b7ee5000 0000011=
4 c0805124 b7ee3000=20
> Nov  8 21:05:01 desk Call Trace:
> Nov  8 21:05:01 desk [<c01460c0>] vma_adjust+0x100/0x390
> Nov  8 21:05:01 desk [<c0147763>] split_vma+0xa3/0xf0
> Nov  8 21:05:01 desk [<c01478ec>] do_munmap+0x13c/0x150
> Nov  8 21:05:01 desk [<c0146967>] do_mmap_pgoff+0x267/0x760
> Nov  8 21:05:01 desk [<c0108588>] sys_mmap2+0x78/0xb0
> Nov  8 21:05:01 desk [<c0102e81>] syscall_call+0x7/0xb
> Nov  8 21:05:01 desk Code: 8b 4a 04 89 53 28 89 42 04 89 01 89 48 04 eb d=
8 8d 43 28 89 73 34 89 43 28 89 43 2c 89 5e 34 eb c7 0f 0b 4f 00 61 b7 33 c=
0 eb 93 <0f> 0b 4e 00 61 b7 33 c0 e9 68 ff ff ff 90 8d b4 26 00 00 00 00=20
> Nov  8 21:05:01 desk <6>note: grep[31686] exited with preempt_count 1
> Nov  8 21:05:01 desk scheduling while atomic: grep/0x00000001/31686
> Nov  8 21:05:01 desk [<c0327f92>] schedule+0x612/0x620
> Nov  8 21:05:01 desk [<c0115885>] vprintk+0x1c5/0x290
> Nov  8 21:05:01 desk [<c0328c8d>] rwsem_down_read_failed+0x8d/0x170
> Nov  8 21:05:01 desk [<c0118bb2>] .text.lock.exit+0x27/0xb5
> Nov  8 21:05:01 desk [<c0103ac0>] do_invalid_op+0x0/0xd0
> Nov  8 21:05:01 desk [<c011782b>] do_exit+0xdb/0x440
> Nov  8 21:05:01 desk [<c0103ac0>] do_invalid_op+0x0/0xd0
> Nov  8 21:05:01 desk [<c010380d>] die+0x17d/0x180
> Nov  8 21:05:01 desk [<c0103b6e>] do_invalid_op+0xae/0xd0
> Nov  8 21:05:01 desk [<c016bc48>] update_atime+0x58/0xb0
> Nov  8 21:05:01 desk [<c014192b>] vma_prio_tree_add+0xab/0xc0
> Nov  8 21:05:01 desk [<c01352d3>] do_generic_mapping_read+0x313/0x5d0
> Nov  8 21:05:01 desk [<c0162440>] page_put_link+0x0/0x40
> Nov  8 21:05:01 desk [<c01fa68e>] rb_insert_color+0x8e/0xf0
> Nov  8 21:05:01 desk [<c01f96d0>] prio_tree_insert+0xb0/0x1c0
> Nov  8 21:05:01 desk [<c01030ab>] error_code+0x4f/0x54
> Nov  8 21:05:01 desk [<c014192b>] vma_prio_tree_add+0xab/0xc0
> Nov  8 21:05:01 desk [<c01460c0>] vma_adjust+0x100/0x390
> Nov  8 21:05:01 desk [<c0147763>] split_vma+0xa3/0xf0
> Nov  8 21:05:01 desk [<c01478ec>] do_munmap+0x13c/0x150
> Nov  8 21:05:01 desk [<c0146967>] do_mmap_pgoff+0x267/0x760
> Nov  8 21:05:01 desk [<c0108588>] sys_mmap2+0x78/0xb0
> Nov  8 21:05:01 desk [<c0102e81>] syscall_call+0x7/0xb
>=20
> The box is still up and running, but hangs when trying to read from
> files:
> /proc/31686/cmdline
> /proc/31686/environ
> /proc/31686/exe
> /proc/31686/maps
> /proc/31686/smaps
> Process 31686 is "unkillable" (shows up as "D (disk sleep)").

Those hangs and unkillability are just the consequence of the BUG
happening in an awkward place, I think.  Though that would be more
on an SMP system, which yours is not.  The stack backtrace naturally
contains stale addresses from before, it's hard to work out whether
there's actually something further wrong after the BUG_ON or not.

> So far, this happened only once and I dont't know, what might
> be the cause. PID 31686 is a grep command, launched from the
> "emerge" python script (emerge is Gentoo Linux package management
> utility).
>=20
> Is this an actual bug, or maybe hardware error?

I'm not sure.  There _used_ to be a bug which caused this, but Rajesh
fixed that in 2.6.10, and the fix looks like it's still there in 2.6.14.
And it needed something a lot more complex than "grep" to trigger it.

My guess at this point is that it's a hardware problem i.e. bad memory,
cpu overheating, that kind of thing.  (The BUG_ON is surprised to find
vm_pgoffs in ecx: 0000010f edx: 00000110 different: not a single-bit
error, but perhaps it could arise from a single-bit error nearby.)

Please give memtest86 an overnight run (though finding nothing won't
prove your memory okay), and be on the lookout for other strange
behaviour on this machine.  If the next strange thing that happens is
another BUG at mm/prio_tree.c:78! that will suggest a kernel bug here.

Hugh

> I would be grateful for any help / comments on this.
> I am not subscribed to the list, please CC.
> Thank you.
>=20
> --=20
> Pawe=C5=82 S=C5=82owik
> wik@iq.pl
--8323584-1576164022-1131537236=:27511--
