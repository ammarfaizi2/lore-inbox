Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbWENSZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbWENSZq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 14:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbWENSZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 14:25:45 -0400
Received: from wx-out-0102.google.com ([66.249.82.195]:21476 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWENSZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 14:25:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=CP9SONGi9Sprm/oQErKw1HiuA4Z71WZBILr5FBbbm9V+pk0HhOhgoi744vlyPpdoVuENfWJdXuoJCfeEVWfjpU3mLFXaOECbgEnvDYpSbm6Woa3kwWGPlTSPTl3tuw6q0UIn5jSyIbZLTPat5zHrerdoE5VeUtmJA4Gx0I9w/iw=
Date: Sun, 14 May 2006 15:25:41 -0300
From: Alberto Bertogli <albertito@gmail.com>
To: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UML] Problems building and running 2.6.17-rc4 on x86-64
Message-ID: <20060514182541.GA4980@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I'm having some problems building and running UML using vanilla
2.6.17-rc4 under x86-64 with glibc 2.4.

First of all, it won't build because lack of definitions for some
constants in arch/um/os-Linux/sys-x86_64/registers.c. After some
digging, I found that these were defined in public setjmp headers in
previous glibc's, but have been removed in 2.4.

So I copied them from sysdeps/x86_64/jmpbuf-offsets.h, and building went
on. Probably, the same happens under i386.


Then, it built fine, but at the end several errors showed up:

-----------------8<-----------------8<-----------------8<-----------------

  SYSMAP  .tmp_System.map
  LINK linux
  Building modules, stage 2.
  MODPOST
WARNING: vmlinux - Section mismatch: reference to .init.text:do_mount_root from .bss between '__guard@@GLIBC_2.3.2' (at offset 0x603c5688) and 'stdout@@GLIBC_2.2.5'
WARNING: vmlinux - Section mismatch: reference to .init.text:parse_header from .bss between 'stdout@@GLIBC_2.2.5' (at offset 0x603c5690) and 'completed.1'
WARNING: vmlinux - Section mismatch: reference to .init.text: from .plt after '' (at offset 0x603c5278)
WARNING: vmlinux - Section mismatch: reference to .init.ramfs: from .plt after '' (at offset 0x603c5370)
WARNING: vmlinux - Section mismatch: reference to .init.text:nosmp from .plt after '' (at offset 0x603c5418)
WARNING: vmlinux - Section mismatch: reference to .init.text:maxcpus from .plt after '' (at offset 0x603c5428)
WARNING: vmlinux - Section mismatch: reference to .init.text:obsolete_checksetup from .plt after '' (at offset 0x603c5440)
WARNING: vmlinux - Section mismatch: reference to .init.text:debug_kernel from .plt after '' (at offset 0x603c5450)
WARNING: vmlinux - Section mismatch: reference to .init.text:quiet_kernel from .plt after '' (at offset 0x603c5458)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_debug_kernel from .plt after '' (at offset 0x603c5460)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_quiet_kernel from .plt after '' (at offset 0x603c5470)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_loglevel from .plt after '' (at offset 0x603c5478)
WARNING: vmlinux - Section mismatch: reference to .init.text:unknown_bootoption from .plt after '' (at offset 0x603c5488)
WARNING: vmlinux - Section mismatch: reference to .init.text:init_setup from .plt after '' (at offset 0x603c5490)
WARNING: vmlinux - Section mismatch: reference to .init.text:rdinit_setup from .plt after '' (at offset 0x603c54a8)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_rdinit_setup from .plt after '' (at offset 0x603c54c0)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_early_param from .plt after '' (at offset 0x603c54d8)
WARNING: vmlinux - Section mismatch: reference to .init.text:boot_cpu_init from .plt after '' (at offset 0x603c54f0)
WARNING: vmlinux - Section mismatch: reference to .init.text:initcall_debug_setup from .plt after '' (at offset 0x603c54f8)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_initcall_debug_setup from .plt after '' (at offset 0x603c5510)
WARNING: vmlinux - Section mismatch: reference to .init.text:do_initcalls from .plt after '' (at offset 0x603c5518)
WARNING: vmlinux - Section mismatch: reference to .init.text:load_ramdisk from .plt after '' (at offset 0x603c5540)
WARNING: vmlinux - Section mismatch: reference to .init.text:readwrite from .plt after '' (at offset 0x603c5550)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_readonly from .plt after '' (at offset 0x603c5560)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_readwrite from .plt after '' (at offset 0x603c5568)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_dev_setup from .plt after '' (at offset 0x603c5578)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_root_dev_setup from .plt after '' (at offset 0x603c5590)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_data_setup from .plt after '' (at offset 0x603c5598)
WARNING: vmlinux - Section mismatch: reference to .init.text:fs_names_setup from .plt after '' (at offset 0x603c55a8)
WARNING: vmlinux - Section mismatch: reference to .init.text:root_delay_setup from .plt after '' (at offset 0x603c55b8)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_root_data_setup from .plt after '' (at offset 0x603c55d0)WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_fs_names_setup from .plt after '' (at offset 0x603c55e0)
WARNING: vmlinux - Section mismatch: reference to .init.setup:__setup_root_delay_setup from .plt after '' (at offset 0x603c55f0)
WARNING: vmlinux - Section mismatch: reference to .init.text:get_fs_names from .plt after '' (at offset 0x603c55f8)
WARNING: vmlinux - Section mismatch: reference to .init.text:malloc from .plt after '' (at offset 0x603c5608)
WARNING: vmlinux - Section mismatch: reference to .init.text:free from .plt after '' (at offset 0x603c5610)
WARNING: vmlinux - Section mismatch: reference to .init.text:find_link from .plt after '' (at offset 0x603c5618)
WARNING: vmlinux - Section mismatch: reference to .exit.text: from .plt after '' (at offset 0x603c5368)

-----------------8<-----------------8<-----------------8<-----------------


However, the linux image was there, and I tried it.

It begins to boot, but panics right after mounting root:

[42949373.800000] kjournald starting.  Commit interval 5 seconds
[42949373.800000] EXT3-fs: mounted filesystem with ordered data mode.
[42949373.800000] VFS: Mounted root (ext3 filesystem) readonly.
[42949373.800000] Kernel panic - not syncing: handle_trap - failed to wait at end of syscall, errno = 0, status = 2943
[42949373.800000]
[42949373.800000]
[42949373.800000] Modules linked in:
[42949373.800000] Pid: 1, comm: init Not tainted 2.6.17-rc4
[42949373.800000] RIP: 0033:[<000000004000f349>]
[42949373.800000] RSP: 0000007f7fbfbfc8  EFLAGS: 00000246
[42949373.800000] RAX: 0000000000000000 RBX: 0000007f7fbfbfe0 RCX: ffffffffffffffff
[42949373.800000] RDX: 0000007f7fbfc2a0 RSI: 0000000040010900 RDI: 0000007f7fbfbfe0
[42949373.800000] RBP: 0000000000402240 R08: 0000000000000000 R09: 0000000000000000
[42949373.800000] R10: 0000000000000064 R11: 0000000000000246 R12: 0000007f7fbfc170
[42949373.800000] R13: 0000000040001530 R14: 0000000000400040 R15: 0000000000000008
[42949373.800000] Call Trace:
[42949373.800000] 6042bc38:  [<6001a10a>] panic_exit+0x2a/0x50
[42949373.800000] 6042bc48:  [<60044a8c>] notifier_call_chain+0x1c/0x30
[42949373.800000] 6042bc68:  [<6003488f>] panic+0xcf/0x170
[42949373.800000] 6042bcc8:  [<6027b4b1>] __down_read+0xa1/0xb0
[42949373.800000] 6042bce8:  [<6013f0fe>] __up_read+0x1e/0xc0
[42949373.800000] 6042bcf8:  [<600285b4>] set_signals+0x14/0x30
[42949373.800000] 6042bd08:  [<6002f0a1>] sys_uname64+0x31/0x90
[42949373.800000] 6042bd18:  [<6002acf2>] move_registers+0x42/0x80
[42949373.800000] 6042bd48:  [<6002bf65>] userspace+0x255/0x2d0
[42949373.800000] 6042bdc0:  [<60014010>] init+0x0/0x170
[42949373.800000] 6042bdd8:  [<6001a7a2>] new_thread_handler+0x102/0x140
[42949373.800000]

And I couldn't get past that. I found the error comes from
arch/um/os-Linux/skas/process.c, but I'm not sure what causes it or if
it's related to the constants defined above.

Any ideas?

Thanks,
		Alberto

