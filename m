Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281217AbRK0SUS>; Tue, 27 Nov 2001 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282453AbRK0SUJ>; Tue, 27 Nov 2001 13:20:09 -0500
Received: from att-lp2.wirelessmatrixcorp.com ([66.46.106.131]:56337 "HELO
	wirelessmatrixcorp.com") by vger.kernel.org with SMTP
	id <S281217AbRK0SUB>; Tue, 27 Nov 2001 13:20:01 -0500
Date: Tue, 27 Nov 2001 11:19:53 -0700
From: Bill Currie <billc@wirelessmatrixcorp.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.16 alpha scsi oops on large transfer
Message-ID: <20011127111953.A17351@wirelessmatrixcorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a highly repeatable (3/3) kernel oops on large scsi transfers (eg,
copying a cdrom to the hd (actually, md0: raid 5 of sda to sdd*)). The
qlogicisp driver is obviously accessing a structure though a null pointer, and
it /looks/ like it's the Cmnd pointer:

        if (sts->hdr.entry_type == ENTRY_STATUS)
->?         Cmnd->result = isp1020_return_status(sts);
        else
            Cmnd->result = DID_ERROR << 16;

Again, I'm not subsribed to the list, so please CC any replies to me.

Bill

(NOTE: the oops was transcribed by hand (screen to paper, paper to file), but
seems accurate).

(* I've temporarily given up on the DAC960 for now: too many issues with
upgrading its firmware)

ksymoops 2.4.0 on alpha 2.4.16.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.16/ (default)
     -m /boot/System.map-2.4.16 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol generic_direct_IO_R__ver_generic_direct_IO not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says fffffc0000997930, System.map says fffffc000088aed0.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vm_max_readahead_R__ver_vm_max_readahead not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vm_min_readahead_R__ver_vm_min_readahead not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol scsi_CDs  , sr_mod says fffffffc0031d668, /lib/modules/2.4.16/kernel/drivers/scsi/sr_mod.o says fffffffc00318000.  Ignoring /lib/modules/2.4.16/kernel/drivers/scsi/sr_mod.o entry
Warning (compare_maps): mismatch on symbol usb_devfs_handle  , usbcore says fffffffc002cf880, /lib/modules/2.4.16/kernel/drivers/usb/usbcore.o says fffffffc002cf900.  Ignoring /lib/modules/2.4.16/kernel/drivers/usb/usbcore.o entry
Unable to handle kernel paging request at virtual address 0000000000000198
swapper(0): Oops 1
pc = [<fffffc0000957620>]  ra = [<fffffc0000957430>]  ps = 0007    Not tainted
Using defaults from ksymoops -t elf64-alpha -a alpha
v0 = 000000000000001e  t0 = 00000000000300f0  t1 = 000000000a440013
t2 = 0000000000000000  t3 = 0000000000000015  t4 = 0000000000000000
t5 = 0000000000000000  t6 = 0000000000000000  t7 = fffffc0000ab0000
s0 = 0000000000000000  s1 = fffffc000fe724c0  s2 = 0000000000000005
s3 = fffffc000fe72400  s4 = fffffc0000b29428  s5 = 0000000000000005
s6 = 0000000000000000
a0 = fffffc000fe44100  a1 = fffffd0dfc0080c0  a2 = fffffc0000ab3ed8
a3 = 0000000000000000  a4 = 00000000000000ff  a5 = 0000000000000000
t8 = 0000000000000000  t9 = 0000000000000103  t10= 000000000000000c
t11= 0000000000000000  pv = fffffc0000822800  at = 0000000000015f00
gp = fffffc0000b7eb38  sp = fffffc0000ab3df8
Trace:fffffc00009572ac fffffc000081fc44 fffffc0000816644 fffffc0000823b84 fffffc0000816c78 fffffc0000810e08 fffffc0000812570 fffffc00008280a0 fffffc0000812550 fffffc000086ebe4 fffffc00008100a4 fffffc000081001c
Code: a3300048 a390004c a0100050 a2b00054 a2900058 a270005c <b0290198> b049019c

>>PC;  fffffc0000957620 <isp1020_intr_handler+350/4c0>   <=====
Trace; fffffc00009572ac <do_isp1020_intr_handler+2c/50>
Trace; fffffc000081fc44 <lca_clock_print+4/e0>
Trace; fffffc0000816644 <handle_irq+134/1d0>
Trace; fffffc0000823b84 <dp264_srm_device_interrupt+34/50>
Trace; fffffc0000816c78 <do_entInt+d8/170>
Trace; fffffc0000810e08 <ret_from_sys_call+0/10>
Trace; fffffc0000812570 <cpu_idle+70/80>
Trace; fffffc00008280a0 <do_check_pgt_cache+0/140>
Trace; fffffc0000812550 <cpu_idle+50/80>
Trace; fffffc000086ebe4 <do_select+274/2e0>
Trace; fffffc00008100a4 <rest_init+44/60>
Trace; fffffc000081001c <_stext+1c/20>
Code;  fffffc0000957608 <isp1020_intr_handler+338/4c0>
0000000000000000 <_PC>:
Code;  fffffc0000957608 <isp1020_intr_handler+338/4c0>
   0:   48 00 30 a3       ldl  t11,72(a0)
Code;  fffffc000095760c <isp1020_intr_handler+33c/4c0>
   4:   4c 00 90 a3       ldl  at,76(a0)
Code;  fffffc0000957610 <isp1020_intr_handler+340/4c0>
   8:   50 00 10 a0       ldl  v0,80(a0)
Code;  fffffc0000957614 <isp1020_intr_handler+344/4c0>
   c:   54 00 b0 a2       ldl  a5,84(a0)
Code;  fffffc0000957618 <isp1020_intr_handler+348/4c0>
  10:   58 00 90 a2       ldl  a4,88(a0)
Code;  fffffc000095761c <isp1020_intr_handler+34c/4c0>
  14:   5c 00 70 a2       ldl  a3,92(a0)
Code;  fffffc0000957620 <isp1020_intr_handler+350/4c0>   <=====
  18:   98 01 29 b0       stl  t0,408(s0)   <=====
Code;  fffffc0000957624 <isp1020_intr_handler+354/4c0>
  1c:   9c 01 49 b0       stl  t1,412(s0)

Kernel panic: Aiee, killing interrupt handler!

7 warnings issued.  Results may not be reliable.
