Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131312AbRCSBPk>; Sun, 18 Mar 2001 20:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131316AbRCSBPa>; Sun, 18 Mar 2001 20:15:30 -0500
Received: from mail.inf.elte.hu ([157.181.161.6]:3495 "HELO mail.inf.elte.hu")
	by vger.kernel.org with SMTP id <S131312AbRCSBPR>;
	Sun, 18 Mar 2001 20:15:17 -0500
Date: Mon, 19 Mar 2001 02:14:35 +0100 (CET)
From: BERECZ Szabolcs <szabi@inf.elte.hu>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] kernel BUG at printk.c:458! -- 2.4.2-ac20
Message-ID: <Pine.A41.4.31.0103190047360.115440-100000@pandora.inf.elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I was copying some files from ext2fs to reiserfs, and then this bug
occured:

kernel BUG at printk.c:458!

invalid operand: 0000
CPU:	0
EIP:	0010:[<c01136ee>]
EFLAGS:	00010286
eax: 0000001c	ebx: c11f290c	ecx: c01eea20	edx: 00000296
esi: c0e22000	edi: c0e2216b	ebp: 00000000	esp: c057fe78
ds: 0018   es: 0018   ss: 0018
Process xmms (pid: 11695, stackpage: c057f000)
Stack:	c01bea04 000001ca c0169eac c0e22041 c015e71f c0e22000 c0e22568 c0e22168
	00000000 c057ffbc 00000000 4157ff68 c15a0aa0 00000000 00000007 c0e2256b
	c0e2216b c18806e4 00000000 c04e2000 c04e2000 c0699320 c04e2000 c2855e23
Call Trace: [<c0169eac>] [<c015e71f>] [<c2855e23>] [<c0111212>] [<c0128a3e>] [<c0128a64>] [<c013b09b>]
	[<c015cbf5>] [<c0116ec4>] [<c0119736>] [<c0116def>] [<c0116d27>] [<c0116c30>] [<c010a152>] [<c0108df0>]

Code: 0f 0b 83 c4 08 b9 20 ea 1e c0 ff 0d 20 ea 1e c0 0f 88 16 16
 <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


ksymoops:

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in vmlinux.  Ignoring ksyms_base entry
kernel BUG at printk.c:458!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01136ee>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001c   ebx: c11f290c     ecx: c01eea20       edx: 00000296
esi: c0e22000   edi: c0e2216b     ebp: 00000000       esp: c057fe78
ds: 0018   es: 0018   ss: 0018
Stack:  c01bea04 000001ca c0169eac c0e22041 c015e71f c0e22000 c0e22568 c0e22168
        00000000 c057ffbc 00000000 4157ff68 c15a0aa0 00000000 00000007 c0e2256b
        c0e2216b c18806e4 00000000 c04e2000 c04e2000 c0699320 c04e2000 c2855e23
Call Trace: [<c0169eac>] [<c015e71f>] [<c2855e23>] [<c0111212>] [<c0128a3e>] [<c0128a64>] [<c013b09b>]
        [<c015cbf5>] [<c0116ec4>] [<c0119736>] [<c0116def>] [<c0116d27>] [<c0116c30>] [<c010a152>] [<c0108df0>]
Code: 0f 0b 83 c4 08 b9 20 ea 1e c0 ff 0d 20 ea 1e c0 0f 88 16 16

>>EIP; c01136ee <acquire_console_sem+1e/40>   <=====
Trace; c0169eac <con_flush_chars+10/24>
Trace; c015e71f <n_tty_receive_buf+e2b/edc>
Trace; c2855e23 <[reiserfs]reiserfs_get_unused_objectid+53/c4>
Trace; c0111212 <schedule+25e/388>
Trace; c0128a3e <__free_pages+1a/1c>
Trace; c0128a64 <free_pages+24/28>
Trace; c013b09b <poll_freewait+3b/44>
Trace; c015cbf5 <flush_to_ldisc+dd/e4>
Trace; c0116ec4 <__run_task_queue+4c/68>
Trace; c0119736 <tqueue_bh+16/1c>
Trace; c0116def <bh_action+1b/60>
Trace; c0116d27 <tasklet_hi_action+3b/60>
Trace; c0116c30 <do_softirq+40/64>
Trace; c010a152 <do_IRQ+a2/b0>
Trace; c0108df0 <ret_from_intr+0/20>
Code;  c01136ee <acquire_console_sem+1e/40>    00000000 <_EIP>:
Code;  c01136ee <acquire_console_sem+1e/40>       0:   0f 0b                     ud2a      <=====
Code;  c01136f0 <acquire_console_sem+20/40>       2:   83 c4 08                  add    $0x8,%esp
Code;  c01136f3 <acquire_console_sem+23/40>       5:   b9 20 ea 1e c0            mov    $0xc01eea20,%ecx
Code;  c01136f8 <acquire_console_sem+28/40>       a:   ff 0d 20 ea 1e c0         decl   0xc01eea20
Code;  c01136fe <acquire_console_sem+2e/40>      10:   0f 88 16 16 00 00         js     162c <_EIP+0x162c> c0114d1a <sys_query_module+11a/14c>

 <0>Kernel panic: Aiee, killing interrupt handler!
1 warning issued.  Results may not be reliable.


ver_linux:

Linux kama3 2.4.2-ac20 #1 Wed Mar 14 21:02:11 CET 2001 i586 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.9.5.0.37
util-linux
util-linux             Note: /usr/bin/fdformat is obsolete and is no longer available.
util-linux             Please use /usr/bin/superformat instead (make sure you have the
util-linux             fdutils package installed first).  Also, there had been some
util-linux             major changes from version 4.x.  Please refer to the documentation.
util-linux
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0d
PPP                    2.4.0
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.58
Kbd                    0.96
Sh-utils               2.0.11
Modules Loaded         snd-pcm-oss snd-pcm-plugin reiserfs snd-mixer-oss snd-card-fm801 snd-mpu401-uart snd-rawmidi snd-seq-device snd-opl3 snd-hwdep snd-fm801 snd-pcm snd-timer snd-ac97-codec snd-mixer snd soundcore



from 'dpkg -s util-linux':
Version: 2.10s-2


I had to reboot, so maybe the modules aren't correct.


Bye,
Szabi


