Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTELQib (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 12:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbTELQib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 12:38:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:24495 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262254AbTELQiZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 12:38:25 -0400
Date: Mon, 12 May 2003 07:36:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 708] New: loading emu10k1-gp segfaults
Message-ID: <27230000.1052750207@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

           Summary: loading emu10k1-gp segfaults
    Kernel Version: 2.5.69
            Status: NEW
          Severity: normal
             Owner: vojtech@suse.cz
         Submitter: ken@krwtech.com


Distribution: custom
Hardware Environment: Dual Athlon 1800MP on S2460 (AMD MP chipset) with SB Live
5.1, gravis 4 button game pad (gameport, non USB)
Software Environment: gcc 3.2.3, glibc 2.3.2, module-init-tools 0.9.10
Problem Description:

When trying to auto-load the joystick driver, the emu10k1-gp module segfaults:

May 12 11:58:25 death kernel: Unable to handle kernel paging request at virtual
address 84815e57
May 12 11:58:25 death kernel:  printing eip:
May 12 11:58:25 death kernel: e0a3d30b
May 12 11:58:25 death kernel: *pde = 00000000
May 12 11:58:25 death kernel: Oops: 0002 [#1]
May 12 11:58:25 death kernel: CPU:    0
May 12 11:58:25 death kernel: EIP:    0060:[_end+541628007/1067754332]   
Tainted: PF
May 12 11:58:25 death kernel: EFLAGS: 00010206
May 12 11:58:25 death kernel: EIP is at gameport_register_device+0x5b/0x80
[gameport]
May 12 11:58:25 death kernel: eax: e0a3dd5d   ebx: e0a3dd40   ecx: e0a3dd5d  
edx: e0a3dd80
May 12 11:58:25 death kernel: esi: e0a474b8   edi: e0a47500   ebp: c0486bdc  
esp: c473bf80
May 12 11:58:25 death kernel: ds: 007b   es: 007b   ss: 0068
May 12 11:58:25 death kernel: Process modprobe (pid: 17051, threadinfo=c473a000
task=d5cf06a0)
May 12 11:58:25 death kernel: Stack: c0486bfc c0486bdc c0486bfc c0486bdc
e0a3a014 e0a474b8 c013b1f6 c058f308
May 12 11:58:25 death kernel:        00000001 e0a47500 0804e050 00000004
0804eab0 00000000 00000000 c473a000
May 12 11:58:25 death kernel:        c010977b 0804eab0 0000382a 0804e050
00000000 00000000 bffffa68 00000080
May 12 11:58:25 death kernel: Call Trace:
May 12 11:58:25 death kernel:  [_end+541614960/1067754332] +0x14/0x1a [analog]
May 12 11:58:25 death kernel:  [_end+541669396/1067754332] analog_dev+0x0/0x48
[analog]
May 12 11:58:25 death kernel:  [sys_init_module+406/592] sys_init_module+0x196/0x250
May 12 11:58:25 death kernel:  [_end+541669468/1067754332] +0x0/0x900 [analog]
May 12 11:58:25 death kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 12 11:58:25 death kernel:
May 12 11:58:25 death kernel: Code: 00 81 fa 80 dd a3 e0 75 dc 83 c4 08 5b 5e c3
89 74 24 04 89

it is then impossible to try to remove the analog or gameport drivers. 

When trying to load the emu10k1-gp driver directly afterward:
May 12 12:01:56 death kernel:  <6>input: Analog 2-axis 4-button joystick at
pci00:0b.1/gameport0 [TSC timer, 1516 MHz cl
ock, 836 ns res]
May 12 12:01:56 death kernel: Unable to handle kernel paging request at virtual
address 8481fd36
May 12 12:01:56 death kernel:  printing eip:
May 12 12:01:56 death kernel: e0a3d1eb
May 12 12:01:56 death kernel: *pde = 00000000
May 12 12:01:56 death kernel: Oops: 0002 [#2]
May 12 12:01:56 death kernel: CPU:    1
May 12 12:01:56 death kernel: EIP:    0060:[_end+541627719/1067754332]   
Tainted: PF
May 12 12:01:56 death kernel: EFLAGS: 00010292
May 12 12:01:56 death kernel: EIP is at gameport_find_dev+0x3b/0x60 [gameport]
May 12 12:01:56 death kernel: eax: e0a4743c   ebx: e0a3dd78   ecx: e0a4743c  
edx: e0a3dd88
May 12 12:01:56 death kernel: esi: d22a7d5c   edi: 00000008   ebp: dfe11500  
esp: c3895ee4
May 12 12:01:56 death kernel: ds: 007b   es: 007b   ss: 0068
May 12 12:01:56 death kernel: Process modprobe (pid: 17093, threadinfo=c3894000
task=d5544cc0)
May 12 12:01:56 death kernel: Stack: d22a7d5c e0a474b8 d22a7da8 dfe1159c
e0a49124 d22a7d5c e0a491fe dfe117d8
May 12 12:01:56 death kernel:        e0a491f3 d22a7d58 dfe117d8 00000008
dfe11500 e0a497e0 00000000 c04ba8e0
May 12 12:01:56 death kernel:        c02137fe dfe11500 e0a49780 e0a49808
dfe1154c ffffffed c027d0a5 dfe1154c
May 12 12:01:57 death kernel: Call Trace:
May 12 12:01:57 death kernel:  [_end+541669396/1067754332] analog_dev+0x0/0x48
[analog]
May 12 12:01:57 death kernel:  [_end+541676672/1067754332] +0x124/0x190 [emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541676890/1067754332] +0xb/0x2d [emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541676879/1067754332] +0x0/0x2d [emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541678396/1067754332] emu_driver+0x0/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [pci_device_probe+94/112] pci_device_probe+0x5e/0x70
May 12 12:01:57 death kernel:  [_end+541678300/1067754332] +0x0/0x60 [emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541678436/1067754332] emu_driver+0x28/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [bus_match+69/128] bus_match+0x45/0x80
May 12 12:01:57 death kernel:  [_end+541678436/1067754332] emu_driver+0x28/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541678436/1067754332] emu_driver+0x28/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [driver_attach+92/96] driver_attach+0x5c/0x60
May 12 12:01:57 death kernel:  [_end+541678436/1067754332] emu_driver+0x28/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541678484/1067754332] emu_driver+0x58/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [bus_add_driver+161/192] bus_add_driver+0xa1/0xc0
May 12 12:01:57 death kernel:  [_end+541678436/1067754332] emu_driver+0x28/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541678556/1067754332] +0x0/0x900 [emu10k1_gp]
May 12 12:01:57 death kernel:  [pci_register_driver+68/96]
pci_register_driver+0x44/0x60
May 12 12:01:57 death kernel:  [_end+541678436/1067754332] emu_driver+0x28/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541651823/1067754332] +0x13/0x3d [emu10k1_gp]
May 12 12:01:57 death kernel:  [_end+541678396/1067754332] emu_driver+0x0/0xa0
[emu10k1_gp]
May 12 12:01:57 death kernel:  [sys_init_module+406/592] sys_init_module+0x196/0x250
May 12 12:01:57 death kernel:  [_end+541678556/1067754332] +0x0/0x900 [emu10k1_gp]
May 12 12:01:57 death kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
May 12 12:01:57 death kernel:
May 12 12:01:57 death kernel: Code: 00 81 fa 88 dd a3 e0 75 dc 83 c4 08 5b 5e c3
8d b6 00 00 00

snippet from /etc/modprobe.conf

options analog js=auto
install binfmt-0000 /bin/true
install char-major-10 /bin/true
install char-major-10-1 /bin/true
install dummy0 /sbin/modprobe -o dummy0 --ignore-install dummy
install dummy1 /sbin/modprobe -o dummy1 --ignore-install dummy
install eth0 /bin/true
install hid /sbin/modprobe --ignore-install hid && { /sbin/modprobe keybdev;
/sbin/modprobe mousedev; /bin/true; }
install input /sbin/modprobe --ignore-install input && { /sbin/modprobe joydev;
/sbin/modprobe emu10k1-gp; /sbin/modprob
e analog; /bin/true; }
install net-pf-10 /bin/true
install net-pf-19 /bin/true
install net-pf-3 /bin/true
install net-pf-4 /bin/true
install net-pf-5 /bin/true
install net-pf-6 /bin/true
install ov518_decomp { /sbin/modprobe ov511; }; /sbin/modprobe --ignore-install
ov518_decomp
install usbmouse /sbin/modprobe --ignore-install usbmouse && { /sbin/modprobe
hid; /bin/true; }
install wacom /sbin/modprobe --ignore-install wacom && { /sbin/modprobe evdev;
/bin/true; }
remove hid { /sbin/modprobe -r keybdev; /sbin/modprobe -r mousedev; };
/sbin/modprobe -r --ignore-remove hid
remove input { /sbin/modprobe -r joydev; /sbin/modprobe -r emu10k1-gp;
/sbin/modprobe -r analog; }; /sbin/modprobe -r --
ignore-remove input

relative parts of .config:
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=m
CONFIG_GAMEPORT=m
CONFIG_SOUND_GAMEPORT=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_INPUT_JOYDUMP=m


Steps to reproduce:
autoload joystick module or load emu10k1-gp module directly


