Return-Path: <linux-kernel-owner+willy=40w.ods.org-S324467AbUKBGVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S324467AbUKBGVB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 01:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S780746AbUKBGVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 01:21:01 -0500
Received: from chello083144090118.chello.pl ([83.144.90.118]:30980 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S780878AbUKBGUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 01:20:25 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [oops] lib/vsprintf.c
Date: Tue, 2 Nov 2004 07:19:55 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LcyhBc8ZV7EJHs9"
Message-Id: <200411020719.55570.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_LcyhBc8ZV7EJHs9
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

vsprintf.c-      case 's':
vsprintf.c-                    s = va_arg(args, char *);
vsprintf.c-                    if ((unsigned long)s < PAGE_SIZE)
vsprintf.c-                           s = "<NULL>";
vsprintf.c-
vsprintf.c:      OOPS!  =>     len = strnlen(s, precision);

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)

--Boundary-00=_LcyhBc8ZV7EJHs9
Content-Type: text/plain;
  charset="utf-8";
  name="oops-dump.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="oops-dump.txt"

Unable to handle kernel paging request at virtual address 66666666
 printing eip:
c01b6f3e
*pde = 00131313
*pte = 0c55b70f
Oops: 0000 [#1]
Modules linked in: oops videodev agpgart nvidia ipt_unclean ipt_state
ipt_REJECT iptable_nat ip_conntrack iptable_mangle iptable_filter
ip_tables vmmon snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss
snd_mixer_oss snd_ens1371 snd_rawmidi snd_seq_device snd_ac97_codec
snd_pcm snd_page_alloc gameport snd_rtctimer snd_timer snd soundcore
usbhid uhci_hcd usbcore via_rhine mii crc32 capability commoncap
processor via686a w83781d i2c_sensor i2c_isa i2c_core msr cpuid
ide_disk ext3 mbcache jbd via82cxxx ide_core
CPU:    0
EIP:    0060:[<c01b6f3e>]    Tainted: P      VLI
EFLAGS: 00010097   (2.6.10) 
EIP is at vsnprintf+0x30e/0x4f0
eax: 66666666   ebx: 0000000a   ecx: 66666666   edx: fffffffe
esi: c03bfde3   edi: 00000000   ebp: c46d3f38   esp: c46d3efc
ds: 007b   es: 007b   ss: 0068
Process insmod (pid: 26344, threadinfo=c46d2000 task=c33f2140)
Stack: c46d3f0c c014fa0a c4245da0 00000001 c46d3f9c c0134526 d0a51000 0000000f 
       ffffffff ffffffff ffffffff c03c01df 00000400 00000246 c02d9660 c46d3f54 
       c01b7147 c03bfde0 00000400 d0a53038 c46d3f98 c03bfde0 c46d3f78 c011dda2 
Call Trace:
 [<c0106d0f>] show_stack+0x7f/0xa0
 [<c0106ea6>] show_registers+0x156/0x1d0
 [<c01070a8>] die+0xc8/0x150
 [<c0118410>] do_page_fault+0x440/0x707
 [<c01069a1>] error_code+0x2d/0x38
 [<c01b7147>] vscnprintf+0x27/0x40
 [<c011dda2>] vprintk+0x42/0x140
 [<c011dd58>] printk+0x18/0x20
 [<d0a5301c>] km_init_module+0x1c/0x20 [oops]
 [<c0134724>] sys_init_module+0x134/0x1c0
 [<c0105ecd>] sysenter_past_esp+0x52/0x71
Code: fd ff ff 83 cf 40 bb 10 00 00 00 eb 88 8b 45 14 8b
55 e8 83 45 14 04 8b 08 b8 6c 45 2b c0 81 f9 ff 0f 00 00
0f 46 c8 89 c8 eb 06 <80> 38 00 74 07 40 4a 83 fa ff 75
f4 29 c8 83 e7 10 89 c3 0f 85

--Boundary-00=_LcyhBc8ZV7EJHs9
Content-Type: text/x-csrc;
  charset="utf-8";
  name="oops.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="oops.c"

#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/module.h>

MODULE_DESCRIPTION("buggy kernel module");
MODULE_LICENSE("GPL");

static int km_init_module(void)
{
    printk(KERN_DEBUG "%s init\n", 1.4);
    return 0;
}

static void km_exit_module(void)
{
    printk(KERN_DEBUG "km exit\n");
}

module_init(km_init_module);
module_exit(km_exit_module);

--Boundary-00=_LcyhBc8ZV7EJHs9--
