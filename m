Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265252AbTLLP6n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 10:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265250AbTLLP6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 10:58:43 -0500
Received: from smtp7.hy.skanova.net ([195.67.199.140]:10724 "EHLO
	smtp7.hy.skanova.net") by vger.kernel.org with ESMTP
	id S265285AbTLLP6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 10:58:01 -0500
From: Roger Larsson <roger.larsson@norran.net>
Subject: UPD: "do_IRQ: near stack overflow" when inserting CF disk
Date: Fri, 12 Dec 2003 16:52:22 +0100
User-Agent: KMail/1.5.94
To: "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David Hinds'" <dahinds@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2Qe2/5VFFlXTBII"
Message-Id: <200312121652.23036.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_2Qe2/5VFFlXTBII
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

OK, I have done some more testing....

How to avoid getting HTML messages from Outlook?
I have specified text - but I guess it automatically selects HTML when
adding attachments...

please cc me, currently not subscribed.

/RogerL

=2D---------  Forwarded Message  ----------

Subject: "do_IRQ: near stack overflow" when inserting CF disk
Date: Friday 12 December 2003 11.17
=46rom: Larsson Roger <roger.larsson@optronic.se>
To: 'Kernel Mailing List' <linux-kernel@vger.kernel.org>, 'David Hinds'=20
<dahinds@users.sourceforge.net>
Cc: "'roger.larsson@norran.net'" <roger.larsson@norran.net>

I get these three printouts when inserting a compact flash disk
(SuSE Linux 2.4.21-144-smp) - is the stack intentionally this fit?
or is it an unexpected code path?

I have had other interrupt related problems, it usually locks up :-(
This time I run with "nosmp noapic"

The ide-cs is now forced to use irq 3 (When running noapic others
seems busy... with apic and using irq 6 or 10 computer has
locked up...)

I will try irq 3 without one of the options to see if the computer still
survives...

=2D new data -

Easier said than done - they require each other!
But I noticed that reducing 'stackwarn' and 'stackdefer'
to under the level warned about helps (might be luck)

Summary:
  Some routines allocate to much stack: validate_cis?
	several subtypes in the union cisparse_t are quite
	big (>250 bytes)
  This eats stack (to much?) or only close enough to
  trigger 'stackdefer' which might stress the drivers SMPness?

/RogerL


=2D-=20
Roger Larsson
Skellefte=E5
Sweden

--Boundary-00=_2Qe2/5VFFlXTBII
Content-Type: application/octet-stream;
  charset="iso-8859-1";
  name="first.stack"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="first.stack"

ksymoops 2.4.9 on i686 2.4.21-144-smp.  Options used=0A=
     -V (default)=0A=
     -k /proc/ksyms (default)=0A=
     -l /proc/modules (default)=0A=
     -o /lib/modules/2.4.21-144-smp/ (default)=0A=
     -m /boot/System.map-2.4.21-144-smp (default)=0A=
=0A=
Warning: You did not tell me where to find symbol information.  I =
will=0A=
assume that the log matches the kernel and modules that are running=0A=
right now and I'll use the default options above for symbol =
resolution.=0A=
If the current kernel and/or modules do not match the log, you can =
get=0A=
more accurate output by telling me the kernel version and where to =
find=0A=
map, modules, ksyms etc.  ksymoops -h explains the options.=0A=
=0A=
cs: memory probe 0x0d0000-0x0dffff:WARNING: do_IRQ: near stack =
overflow: 796=0A=
cfaac9d4 c010b7ee c02e2660 0000031c c2178800 c2688ec0 c2178880 =
00000246=0A=
       cfaaca48 c010e298 c2688ec0 c2688ec0 000003e1 c2178880 00000246 =
cfaaca48=0A=
       00000000 cfaa0018 c2680018 ffffff00 c268514f 00000010 00000246 =
00000012=0A=
Call Trace:         [<c010b7ee>] (16) [<c2688ec0>] (16) [<c010e298>] =
(04)=0A=
  [<c2688ec0>] (04) [<c2688ec0>] (36) [<c268514f>] (40) [<c2693e4c>] =
(64)=0A=
  [<c2695d79>] (80) [<c2693fd4>] (96) [<c2694c22>] (1920) [<c26959c1>] =
(48)=0A=
  [<c2697bcf>] (80) [<c269701b>] (12) [<c2695900>] (04) [<c2695a10>] =
(64)=0A=
  [<c2695881>] (04) [<c2695900>] (04) [<c2695a10>] (24) [<c2693d01>] =
(64)=0A=
  [<c2695d79>] (80) [<c2693fd4>] (96) [<c2694c22>] (564) [<c0236e75>] =
(16)=0A=
  [<c0237036>] (08) [<c0236cfd>] (64) [<c0236e75>] (16) [<c0237036>] =
(08)=0A=
  [<c0236cfd>] (12) [<c02361d0>] (08) [<c0236940>] (20) [<c022fdc9>] =
(16)=0A=
  [<c0201404>] (32) [<c022460e>] (08) [<c0201af3>] (28) [<c022e459>] =
(92)=0A=
  [<c012105e>] (12) [<c0121069>] (56) [<c0236e75>] (16) [<c0237036>] =
(08)=0A=
  [<c0236cfd>] (12) [<c02361d0>] (08) [<c0236940>] (20) [<c022fdc9>] =
(48)=0A=
  [<c022460e>] (12) [<c02021a2>] (24) [<c022e459>] (92) [<c0236e75>] =
(16)=0A=
  [<c0237036>] (24) [<c0141e0f>] (48) [<c013b82b>] (68) [<c012ffb2>] =
(16)=0A=
  [<c012b71c>] (04) [<c012b5a3>] (56) [<c010b791>] (48) [<c0141e0f>] =
(48)=0A=
  [<c013b82b>] (40) [<c0141e0f>] (48) [<c013b82b>] (32) [<c013bcb2>] =
(88)=0A=
  [<c013bcb2>] (44) [<c011ed6a>] (60) [<c013d8a6>] (48) [<c011eb50>] =
(08)=0A=
  [<c01096e4>] (24) [<c2690bac>] (56) [<c011eb50>] (08) [<c01096e4>] =
(48)=0A=
  [<c22952e7>] (24) [<c017f5b8>] (140) [<c018eaee>] (68) [<c018d928>] =
(104)=0A=
  [<c01910de>] (36) [<c01913f4>] (16) [<c013f682>] (08) [<c0141e0f>] =
(24)=0A=
  [<c01919db>] (48) [<c013ab80>] (12) [<c0158d0b>] (36) [<c0158fd3>] =
(32)=0A=
  [<c012105e>] (68) [<c016a289>] (32) [<c016a2a7>] (12) [<c016a9a2>] =
(64)=0A=
  [<c016acd4>] (44) [<c016964c>] (52) [<c01095e7>] (60)=0A=
Code: <0>=0A=
Using defaults from ksymoops -t elf32-i386 -a i386=0A=
Warning (Oops_code_values): Code looks like message, not hex digits.  =
No disassembly attempted.=0A=
=0A=
=0A=
Trace; c010b7ee <do_IRQ+13e/150>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c010e298 <call_do_IRQ+5/d>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c268514f <[i82365]pcic_service+8f/d0>=0A=
Trace; c2693e4c <[pcmcia_core]read_cis_mem+16c/260>=0A=
Trace; c2695d79 <[pcmcia_core]read_cis_cache+1c9/1f0>=0A=
Trace; c2693fd4 <[pcmcia_core]get_next_tuple+94/420>=0A=
Trace; c2694c22 <[pcmcia_core]validate_cis+d2/4d0>=0A=
Trace; c26959c1 <[pcmcia_core]cis_readable+c1/110>=0A=
Trace; c2697bcf <[pcmcia_core]do_mem_probe+13f/2f0>=0A=
Trace; c269701b <[pcmcia_core]validate_mem+28b/340>=0A=
Trace; c2695900 <[pcmcia_core]cis_readable+0/110>=0A=
Trace; c2695a10 <[pcmcia_core]checksum_match+0/1a0>=0A=
Trace; c2695881 <[pcmcia_core]setup_cis_mem+41/c0>=0A=
Trace; c2695900 <[pcmcia_core]cis_readable+0/110>=0A=
Trace; c2695a10 <[pcmcia_core]checksum_match+0/1a0>=0A=
Trace; c2693d01 <[pcmcia_core]read_cis_mem+21/260>=0A=
Trace; c2695d79 <[pcmcia_core]read_cis_cache+1c9/1f0>=0A=
Trace; c2693fd4 <[pcmcia_core]get_next_tuple+94/420>=0A=
Trace; c2694c22 <[pcmcia_core]validate_cis+d2/4d0>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c02361d0 <ide_dma_intr+0/d0>=0A=
Trace; c0236940 <dma_timer_expiry+0/f0>=0A=
Trace; c022fdc9 <__ide_do_rw_disk+449/700>=0A=
Trace; c0201404 <req_new_io+84/a0>=0A=
Trace; c022460e <ide_wait_stat+ae/150>=0A=
Trace; c0201af3 <__make_request+3c3/980>=0A=
Trace; c022e459 <start_request+1c9/250>=0A=
Trace; c012105e <do_schedule+17e/360>=0A=
Trace; c0121069 <do_schedule+189/360>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c02361d0 <ide_dma_intr+0/d0>=0A=
Trace; c0236940 <dma_timer_expiry+0/f0>=0A=
Trace; c022fdc9 <__ide_do_rw_disk+449/700>=0A=
Trace; c022460e <ide_wait_stat+ae/150>=0A=
Trace; c02021a2 <generic_make_request+f2/160>=0A=
Trace; c022e459 <start_request+1c9/250>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c012ffb2 <run_all_timers+32/50>=0A=
Trace; c012b71c <bh_action+6c/70>=0A=
Trace; c012b5a3 <tasklet_hi_action+53/a0>=0A=
Trace; c010b791 <do_IRQ+e1/150>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c013bcb2 <handle_mm_fault+e2/120>=0A=
Trace; c013bcb2 <handle_mm_fault+e2/120>=0A=
Trace; c011ed6a <do_page_fault+21a/753>=0A=
Trace; c013d8a6 <__vma_link+56/c0>=0A=
Trace; c011eb50 <do_page_fault+0/753>=0A=
Trace; c01096e4 <error_code+34/3c>=0A=
Trace; c2690bac <[pcmcia_core]CardServices+45c/1a10>=0A=
Trace; c011eb50 <do_page_fault+0/753>=0A=
Trace; c01096e4 <error_code+34/3c>=0A=
Trace; c22952e7 <[ds]ds_ioctl+627/910>=0A=
Trace; c017f5b8 <padzero+28/30>=0A=
Trace; c018eaee <ext2_new_block+e1e/f20>=0A=
Trace; c018d928 <ext2_free_blocks+c8/470>=0A=
Trace; c01910de <ext2_alloc_block+6e/c0>=0A=
Trace; c01913f4 <ext2_alloc_branch+34/270>=0A=
Trace; c013f682 <truncate_list_pages+d2/210>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c01919db <ext2_get_block+3ab/440>=0A=
Trace; c013ab80 <vmtruncate+130/260>=0A=
Trace; c0158d0b <create_buffers+6b/100>=0A=
Trace; c0158fd3 <unmap_underlying_metadata+23/80>=0A=
Trace; c012105e <do_schedule+17e/360>=0A=
Trace; c016a289 <__poll_freewait+b9/c0>=0A=
Trace; c016a2a7 <poll_freewait+17/20>=0A=
Trace; c016a9a2 <do_select+222/250>=0A=
Trace; c016acd4 <sys_select+2d4/5e0>=0A=
Trace; c016964c <sys_ioctl+27c/332>=0A=
Trace; c01095e7 <system_call+33/38>=0A=
=0A=
=0A=
2 warnings issued.  Results may not be reliable.=0A=

--Boundary-00=_2Qe2/5VFFlXTBII
Content-Type: application/octet-stream;
  charset="iso-8859-1";
  name="second.stack"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="second.stack"

ksymoops 2.4.9 on i686 2.4.21-144-smp.  Options used=0A=
     -V (default)=0A=
     -k /proc/ksyms (default)=0A=
     -l /proc/modules (default)=0A=
     -o /lib/modules/2.4.21-144-smp/ (default)=0A=
     -m /boot/System.map-2.4.21-144-smp (default)=0A=
=0A=
Warning: You did not tell me where to find symbol information.  I =
will=0A=
assume that the log matches the kernel and modules that are running=0A=
right now and I'll use the default options above for symbol =
resolution.=0A=
If the current kernel and/or modules do not match the log, you can =
get=0A=
more accurate output by telling me the kernel version and where to =
find=0A=
map, modules, ksyms etc.  ksymoops -h explains the options.=0A=
=0A=
WARNING: do_IRQ: near stack overflow: 716=0A=
cfaac984 c010b7ee c02e2660 000002cc 00000001 c2688ec0 c2178880 =
00000246=0A=
       cfaac9f8 c010e298 c2688ec0 c2688ec0 000003e1 c2178880 00000246 =
cfaac9f8=0A=
       00000000 cfaa0018 c2680018 ffffff00 c268514f 00000010 00000246 =
00000010=0A=
Call Trace:         [<c010b7ee>] (16) [<c2688ec0>] (16) [<c010e298>] =
(04)=0A=
  [<c2688ec0>] (04) [<c2688ec0>] (36) [<c268514f>] (40) [<c2693e4c>] =
(64)=0A=
  [<c2695d79>] (80) [<c26957bd>] (64) [<c2690cfa>] (112) [<c2694e09>] =
(1920)=0A=
  [<c2695949>] (24) [<c012bed3>] (24) [<c2697bcf>] (80) [<c269701b>] =
(12)=0A=
  [<c2695900>] (04) [<c2695a10>] (64) [<c2695881>] (04) [<c2695900>] =
(04)=0A=
  [<c2695a10>] (24) [<c2693d01>] (64) [<c2695d79>] (80) [<c2693fd4>] =
(96)=0A=
  [<c2694c22>] (564) [<c0236e75>] (16) [<c0237036>] (08) [<c0236cfd>] =
(64)=0A=
  [<c0236e75>] (16) [<c0237036>] (08) [<c0236cfd>] (12) [<c02361d0>] =
(08)=0A=
  [<c0236940>] (20) [<c022fdc9>] (16) [<c0201404>] (32) [<c022460e>] =
(08)=0A=
  [<c0201af3>] (28) [<c022e459>] (92) [<c012105e>] (12) [<c0121069>] =
(56)=0A=
  [<c0236e75>] (16) [<c0237036>] (08) [<c0236cfd>] (12) [<c02361d0>] =
(08)=0A=
  [<c0236940>] (20) [<c022fdc9>] (48) [<c022460e>] (12) [<c02021a2>] =
(24)=0A=
  [<c022e459>] (92) [<c0236e75>] (16) [<c0237036>] (24) [<c0141e0f>] =
(48)=0A=
  [<c013b82b>] (68) [<c012ffb2>] (16) [<c012b71c>] (04) [<c012b5a3>] =
(56)=0A=
  [<c010b791>] (48) [<c0141e0f>] (48) [<c013b82b>] (40) [<c0141e0f>] =
(48)=0A=
  [<c013b82b>] (32) [<c013bcb2>] (88) [<c013bcb2>] (44) [<c011ed6a>] =
(60)=0A=
  [<c013d8a6>] (48) [<c011eb50>] (08) [<c01096e4>] (24) [<c2690bac>] =
(56)=0A=
  [<c011eb50>] (08) [<c01096e4>] (48) [<c22952e7>] (24) [<c017f5b8>] =
(140)=0A=
  [<c018eaee>] (68) [<c018d928>] (104) [<c01910de>] (36) [<c01913f4>] =
(16)=0A=
  [<c013f682>] (08) [<c0141e0f>] (24) [<c01919db>] (48) [<c013ab80>] =
(12)=0A=
  [<c0158d0b>] (36) [<c0158fd3>] (32) [<c012105e>] (68) [<c016a289>] =
(32)=0A=
  [<c016a2a7>] (12) [<c016a9a2>] (64) [<c016acd4>] (44) [<c016964c>] =
(52)=0A=
  [<c01095e7>] (60)=0A=
Code: <0>=0A=
Using defaults from ksymoops -t elf32-i386 -a i386=0A=
Warning (Oops_code_values): Code looks like message, not hex digits.  =
No disassembly attempted.=0A=
=0A=
=0A=
Trace; c010b7ee <do_IRQ+13e/150>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c010e298 <call_do_IRQ+5/d>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c268514f <[i82365]pcic_service+8f/d0>=0A=
Trace; c2693e4c <[pcmcia_core]read_cis_mem+16c/260>=0A=
Trace; c2695d79 <[pcmcia_core]read_cis_cache+1c9/1f0>=0A=
Trace; c26957bd <[pcmcia_core]get_tuple_data+8d/a0>=0A=
Trace; c2690cfa <[pcmcia_core]CardServices+5aa/1a10>=0A=
Trace; c2694e09 <[pcmcia_core]validate_cis+2b9/4d0>=0A=
Trace; c2695949 <[pcmcia_core]cis_readable+49/110>=0A=
Trace; c012bed3 <__check_region+43/50>=0A=
Trace; c2697bcf <[pcmcia_core]do_mem_probe+13f/2f0>=0A=
Trace; c269701b <[pcmcia_core]validate_mem+28b/340>=0A=
Trace; c2695900 <[pcmcia_core]cis_readable+0/110>=0A=
Trace; c2695a10 <[pcmcia_core]checksum_match+0/1a0>=0A=
Trace; c2695881 <[pcmcia_core]setup_cis_mem+41/c0>=0A=
Trace; c2695900 <[pcmcia_core]cis_readable+0/110>=0A=
Trace; c2695a10 <[pcmcia_core]checksum_match+0/1a0>=0A=
Trace; c2693d01 <[pcmcia_core]read_cis_mem+21/260>=0A=
Trace; c2695d79 <[pcmcia_core]read_cis_cache+1c9/1f0>=0A=
Trace; c2693fd4 <[pcmcia_core]get_next_tuple+94/420>=0A=
Trace; c2694c22 <[pcmcia_core]validate_cis+d2/4d0>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c02361d0 <ide_dma_intr+0/d0>=0A=
Trace; c0236940 <dma_timer_expiry+0/f0>=0A=
Trace; c022fdc9 <__ide_do_rw_disk+449/700>=0A=
Trace; c0201404 <req_new_io+84/a0>=0A=
Trace; c022460e <ide_wait_stat+ae/150>=0A=
Trace; c0201af3 <__make_request+3c3/980>=0A=
Trace; c022e459 <start_request+1c9/250>=0A=
Trace; c012105e <do_schedule+17e/360>=0A=
Trace; c0121069 <do_schedule+189/360>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c02361d0 <ide_dma_intr+0/d0>=0A=
Trace; c0236940 <dma_timer_expiry+0/f0>=0A=
Trace; c022fdc9 <__ide_do_rw_disk+449/700>=0A=
Trace; c022460e <ide_wait_stat+ae/150>=0A=
Trace; c02021a2 <generic_make_request+f2/160>=0A=
Trace; c022e459 <start_request+1c9/250>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c012ffb2 <run_all_timers+32/50>=0A=
Trace; c012b71c <bh_action+6c/70>=0A=
Trace; c012b5a3 <tasklet_hi_action+53/a0>=0A=
Trace; c010b791 <do_IRQ+e1/150>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c013bcb2 <handle_mm_fault+e2/120>=0A=
Trace; c013bcb2 <handle_mm_fault+e2/120>=0A=
Trace; c011ed6a <do_page_fault+21a/753>=0A=
Trace; c013d8a6 <__vma_link+56/c0>=0A=
Trace; c011eb50 <do_page_fault+0/753>=0A=
Trace; c01096e4 <error_code+34/3c>=0A=
Trace; c2690bac <[pcmcia_core]CardServices+45c/1a10>=0A=
Trace; c011eb50 <do_page_fault+0/753>=0A=
Trace; c01096e4 <error_code+34/3c>=0A=
Trace; c22952e7 <[ds]ds_ioctl+627/910>=0A=
Trace; c017f5b8 <padzero+28/30>=0A=
Trace; c018eaee <ext2_new_block+e1e/f20>=0A=
Trace; c018d928 <ext2_free_blocks+c8/470>=0A=
Trace; c01910de <ext2_alloc_block+6e/c0>=0A=
Trace; c01913f4 <ext2_alloc_branch+34/270>=0A=
Trace; c013f682 <truncate_list_pages+d2/210>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c01919db <ext2_get_block+3ab/440>=0A=
Trace; c013ab80 <vmtruncate+130/260>=0A=
Trace; c0158d0b <create_buffers+6b/100>=0A=
Trace; c0158fd3 <unmap_underlying_metadata+23/80>=0A=
Trace; c012105e <do_schedule+17e/360>=0A=
Trace; c016a289 <__poll_freewait+b9/c0>=0A=
Trace; c016a2a7 <poll_freewait+17/20>=0A=
Trace; c016a9a2 <do_select+222/250>=0A=
Trace; c016acd4 <sys_select+2d4/5e0>=0A=
Trace; c016964c <sys_ioctl+27c/332>=0A=
Trace; c01095e7 <system_call+33/38>=0A=
=0A=
=0A=
2 warnings issued.  Results may not be reliable.=0A=

--Boundary-00=_2Qe2/5VFFlXTBII
Content-Type: application/octet-stream;
  charset="iso-8859-1";
  name="third.stack"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="third.stack"

ksymoops 2.4.9 on i686 2.4.21-144-smp.  Options used=0A=
     -V (default)=0A=
     -k /proc/ksyms (default)=0A=
     -l /proc/modules (default)=0A=
     -o /lib/modules/2.4.21-144-smp/ (default)=0A=
     -m /boot/System.map-2.4.21-144-smp (default)=0A=
=0A=
Warning: You did not tell me where to find symbol information.  I =
will=0A=
assume that the log matches the kernel and modules that are running=0A=
right now and I'll use the default options above for symbol =
resolution.=0A=
If the current kernel and/or modules do not match the log, you can =
get=0A=
more accurate output by telling me the kernel version and where to =
find=0A=
map, modules, ksyms etc.  ksymoops -h explains the options.=0A=
=0A=
WARNING: do_IRQ: near stack overflow: 636=0A=
cfaac934 c010b7ee c02e2660 0000027c 00000001 c2688ec0 c2178880 =
00000246=0A=
       cfaac9a8 c010e298 c2688ec0 c2688ec0 000003e1 c2178880 00000246 =
cfaac9a8=0A=
       00000000 cfaa0018 c2680018 ffffff00 c268514f 00000010 00000246 =
00000001=0A=
Call Trace:         [<c010b7ee>] (16) [<c2688ec0>] (16) [<c010e298>] =
(04)=0A=
  [<c2688ec0>] (04) [<c2688ec0>] (36) [<c268514f>] (40) [<c2693e4c>] =
(64)=0A=
  [<c2695d79>] (32) [<c2688ec0>] (48) [<c2693fd4>] (96) [<c26956aa>] =
(48)=0A=
  [<c2690ddf>] (112) [<c2694c90>] (1920) [<c26959c1>] (48) [<c2697bcf>] =
(80)=0A=
  [<c269701b>] (12) [<c2695900>] (04) [<c2695a10>] (64) [<c2695881>] =
(04)=0A=
  [<c2695900>] (04) [<c2695a10>] (24) [<c2693d01>] (64) [<c2695d79>] =
(80)=0A=
  [<c2693fd4>] (96) [<c2694c22>] (564) [<c0236e75>] (16) [<c0237036>] =
(08)=0A=
  [<c0236cfd>] (64) [<c0236e75>] (16) [<c0237036>] (08) [<c0236cfd>] =
(12)=0A=
  [<c02361d0>] (08) [<c0236940>] (20) [<c022fdc9>] (16) [<c0201404>] =
(32)=0A=
  [<c022460e>] (08) [<c0201af3>] (28) [<c022e459>] (92) [<c012105e>] =
(12)=0A=
  [<c0121069>] (56) [<c0236e75>] (16) [<c0237036>] (08) [<c0236cfd>] =
(12)=0A=
  [<c02361d0>] (08) [<c0236940>] (20) [<c022fdc9>] (48) [<c022460e>] =
(12)=0A=
  [<c02021a2>] (24) [<c022e459>] (92) [<c0236e75>] (16) [<c0237036>] =
(24)=0A=
  [<c0141e0f>] (48) [<c013b82b>] (68) [<c012ffb2>] (16) [<c012b71c>] =
(04)=0A=
  [<c012b5a3>] (56) [<c010b791>] (48) [<c0141e0f>] (48) [<c013b82b>] =
(40)=0A=
  [<c0141e0f>] (48) [<c013b82b>] (32) [<c013bcb2>] (88) [<c013bcb2>] =
(44)=0A=
  [<c011ed6a>] (60) [<c013d8a6>] (48) [<c011eb50>] (08) [<c01096e4>] =
(24)=0A=
  [<c2690bac>] (56) [<c011eb50>] (08) [<c01096e4>] (48) [<c22952e7>] =
(24)=0A=
  [<c017f5b8>] (140) [<c018eaee>] (68) [<c018d928>] (104) [<c01910de>] =
(36)=0A=
  [<c01913f4>] (16) [<c013f682>] (08) [<c0141e0f>] (24) [<c01919db>] =
(48)=0A=
  [<c013ab80>] (12) [<c0158d0b>] (36) [<c0158fd3>] (32) [<c012105e>] =
(68)=0A=
  [<c016a289>] (32) [<c016a2a7>] (12) [<c016a9a2>] (64) [<c016acd4>] =
(44)=0A=
  [<c016964c>] (52) [<c01095e7>] (60)=0A=
Code: <0>=0A=
Using defaults from ksymoops -t elf32-i386 -a i386=0A=
Warning (Oops_code_values): Code looks like message, not hex digits.  =
No disassembly attempted.=0A=
=0A=
=0A=
Trace; c010b7ee <do_IRQ+13e/150>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c010e298 <call_do_IRQ+5/d>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c268514f <[i82365]pcic_service+8f/d0>=0A=
Trace; c2693e4c <[pcmcia_core]read_cis_mem+16c/260>=0A=
Trace; c2695d79 <[pcmcia_core]read_cis_cache+1c9/1f0>=0A=
Trace; c2688ec0 <[i82365].data.end+71/7211>=0A=
Trace; c2693fd4 <[pcmcia_core]get_next_tuple+94/420>=0A=
Trace; c26956aa <[pcmcia_core]get_first_tuple+8a/110>=0A=
Trace; c2690ddf <[pcmcia_core]CardServices+68f/1a10>=0A=
Trace; c2694c90 <[pcmcia_core]validate_cis+140/4d0>=0A=
Trace; c26959c1 <[pcmcia_core]cis_readable+c1/110>=0A=
Trace; c2697bcf <[pcmcia_core]do_mem_probe+13f/2f0>=0A=
Trace; c269701b <[pcmcia_core]validate_mem+28b/340>=0A=
Trace; c2695900 <[pcmcia_core]cis_readable+0/110>=0A=
Trace; c2695a10 <[pcmcia_core]checksum_match+0/1a0>=0A=
Trace; c2695881 <[pcmcia_core]setup_cis_mem+41/c0>=0A=
Trace; c2695900 <[pcmcia_core]cis_readable+0/110>=0A=
Trace; c2695a10 <[pcmcia_core]checksum_match+0/1a0>=0A=
Trace; c2693d01 <[pcmcia_core]read_cis_mem+21/260>=0A=
Trace; c2695d79 <[pcmcia_core]read_cis_cache+1c9/1f0>=0A=
Trace; c2693fd4 <[pcmcia_core]get_next_tuple+94/420>=0A=
Trace; c2694c22 <[pcmcia_core]validate_cis+d2/4d0>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c02361d0 <ide_dma_intr+0/d0>=0A=
Trace; c0236940 <dma_timer_expiry+0/f0>=0A=
Trace; c022fdc9 <__ide_do_rw_disk+449/700>=0A=
Trace; c0201404 <req_new_io+84/a0>=0A=
Trace; c022460e <ide_wait_stat+ae/150>=0A=
Trace; c0201af3 <__make_request+3c3/980>=0A=
Trace; c022e459 <start_request+1c9/250>=0A=
Trace; c012105e <do_schedule+17e/360>=0A=
Trace; c0121069 <do_schedule+189/360>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0236cfd <__ide_dma_read+11d/130>=0A=
Trace; c02361d0 <ide_dma_intr+0/d0>=0A=
Trace; c0236940 <dma_timer_expiry+0/f0>=0A=
Trace; c022fdc9 <__ide_do_rw_disk+449/700>=0A=
Trace; c022460e <ide_wait_stat+ae/150>=0A=
Trace; c02021a2 <generic_make_request+f2/160>=0A=
Trace; c022e459 <start_request+1c9/250>=0A=
Trace; c0236e75 <__ide_dma_begin+35/40>=0A=
Trace; c0237036 <__ide_dma_count+16/20>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c012ffb2 <run_all_timers+32/50>=0A=
Trace; c012b71c <bh_action+6c/70>=0A=
Trace; c012b5a3 <tasklet_hi_action+53/a0>=0A=
Trace; c010b791 <do_IRQ+e1/150>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c013b82b <do_no_page+3cb/530>=0A=
Trace; c013bcb2 <handle_mm_fault+e2/120>=0A=
Trace; c013bcb2 <handle_mm_fault+e2/120>=0A=
Trace; c011ed6a <do_page_fault+21a/753>=0A=
Trace; c013d8a6 <__vma_link+56/c0>=0A=
Trace; c011eb50 <do_page_fault+0/753>=0A=
Trace; c01096e4 <error_code+34/3c>=0A=
Trace; c2690bac <[pcmcia_core]CardServices+45c/1a10>=0A=
Trace; c011eb50 <do_page_fault+0/753>=0A=
Trace; c01096e4 <error_code+34/3c>=0A=
Trace; c22952e7 <[ds]ds_ioctl+627/910>=0A=
Trace; c017f5b8 <padzero+28/30>=0A=
Trace; c018eaee <ext2_new_block+e1e/f20>=0A=
Trace; c018d928 <ext2_free_blocks+c8/470>=0A=
Trace; c01910de <ext2_alloc_block+6e/c0>=0A=
Trace; c01913f4 <ext2_alloc_branch+34/270>=0A=
Trace; c013f682 <truncate_list_pages+d2/210>=0A=
Trace; c0141e0f <filemap_nopage+20f/240>=0A=
Trace; c01919db <ext2_get_block+3ab/440>=0A=
Trace; c013ab80 <vmtruncate+130/260>=0A=
Trace; c0158d0b <create_buffers+6b/100>=0A=
Trace; c0158fd3 <unmap_underlying_metadata+23/80>=0A=
Trace; c012105e <do_schedule+17e/360>=0A=
Trace; c016a289 <__poll_freewait+b9/c0>=0A=
Trace; c016a2a7 <poll_freewait+17/20>=0A=
Trace; c016a9a2 <do_select+222/250>=0A=
Trace; c016acd4 <sys_select+2d4/5e0>=0A=
Trace; c016964c <sys_ioctl+27c/332>=0A=
Trace; c01095e7 <system_call+33/38>=0A=
=0A=
=0A=
2 warnings issued.  Results may not be reliable.=0A=

--Boundary-00=_2Qe2/5VFFlXTBII--
