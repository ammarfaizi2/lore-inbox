Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132369AbRACPfE>; Wed, 3 Jan 2001 10:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRACPen>; Wed, 3 Jan 2001 10:34:43 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:31237 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132369AbRACPek>; Wed, 3 Jan 2001 10:34:40 -0500
Date: Wed, 3 Jan 2001 16:03:59 +0100
From: Sebastian Wenzler <wenzler@innnet.de>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel oops with Linux 2.2.16 shortly after misc cronjob start
Message-Id: <20010103160359.03f06eda.wenzler@innnet.de>
X-Mailer: Sylpheed version 0.4.9 (GTK+ 1.2.8; Linux 2.2.18; i686)
Organization: InnNet Internet Services GmbH
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1. Kernel oopses after cronjob starts

2. I recently noticed that my maschine crashes exactly on cronjob times.
It seems to me that it is mainly caused (because it happened 2 times at 4 o clock) by
the mandrake security scripts i installed (msec-0.9-14mdk) - after some network failure
(eg router going crazy or ircd crashing) between 1 and 4 o clock the included portscan(I! asume)
triggers the kernel oops. Perhaps another thing that may urge this is portsentry 1.0 that
keeps lots of ports open for scandetection.

4. Linux version 2.2.16 (root@keule.aii.at) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #2 Fri Jun 9 23:08:15 CEST 2000
The kernel includes the openwall patch.
IPV6 is enabled but not used(afaik)

5.
OOPS:
---
Dec 18 01:00:10 keule kernel: Unable to handle kernel paging request at virtual address 050b80c0 
Dec 18 01:00:10 keule kernel: current->tss.cr3 = 00101000, %%cr3 = 00101000 
Dec 18 01:00:10 keule kernel: *pde = 00000000 
Dec 18 01:00:10 keule kernel: Oops: 0000 
Dec 18 01:00:10 keule kernel: CPU:    0 
Dec 18 01:00:10 keule kernel: EIP:    0010:[dput+14/328] 
Dec 18 01:00:10 keule kernel: EFLAGS: 00010286 
Dec 18 01:00:10 keule kernel: eax: c50b813c   ebx: 050b80c0   ecx: c50b8fc0   edx: c50b81bc 
Dec 18 01:00:10 keule kernel: esi: 050b80c0   edi: c50b80c0   ebp: 00000001   esp: c09fff5c 
Dec 18 01:00:10 keule kernel: ds: 0018   es: 0018   ss: 0018 
Dec 18 01:00:10 keule kernel: Process sh (pid: 23902, process nr: 101, stackpage=c09ff000) 
Dec 18 01:00:10 keule kernel: Stack: c0123d4a c50b80c0 c6b6aec0 00000000 c50b80c0 c0124df7 c6b6aec0 c6b6aec0  
Dec 18 01:00:10 keule kernel:        c6b6aec0 c0123da6 c6b6aec0 00200087 00000000 c7395be0 c0116311 c6b6aec0  
Dec 18 01:00:10 keule kernel:        c7395be0 c09fe000 0021e57c 00000000 bffffde8 00000000 c09fe000 c011646b  
Dec 18 01:00:10 keule kernel: Call Trace: [__fput+62/72] [fput+23/72] [filp_close+82/92] [do_exit+297/628] [sys_exit+15/16] [system_call+52/56]  

---
Jan  3 04:02:35 keule kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000012 
Jan  3 04:02:35 keule kernel: current->tss.cr3 = 05e34000, %%cr3 = 05e34000 
Jan  3 04:02:35 keule kernel: *pde = 077cc067 
Jan  3 04:02:35 keule kernel: *pte = 00000000 
Jan  3 04:02:35 keule kernel: Oops: 0002 
Jan  3 04:02:35 keule kernel: CPU:    0 
Jan  3 04:02:35 keule kernel: EIP:    0010:[prune_dcache+126/300] 
Jan  3 04:02:35 keule kernel: EFLAGS: 00010282 
Jan  3 04:02:35 keule kernel: eax: c3930300   ebx: c2c05248   ecx: 00000012   edx: c2c05260 
Jan  3 04:02:35 keule kernel: esi: c2c05228   edi: c2c05220   ebp: 000000e0   esp: c67a1e90 
Jan  3 04:02:35 keule kernel: ds: 0018   es: 0018   ss: 0018 
Jan  3 04:02:35 keule kernel: Process slocate (pid: 4127, process nr: 58, stackpage=c67a1000) 
Jan  3 04:02:35 keule kernel: Stack: c01d0124 00001006 c67a1ed0 00000000 00001006 c0130be7 fffff0d9 00001006  
Jan  3 04:02:35 keule kernel:        00000000 c01eedf8 c01d0124 c01eedf8 c7962800 c5694330 c569437c 00000000  
Jan  3 04:02:35 keule kernel:        c67a1ed0 c67a1ed0 c0130c4e 00001006 00000000 c01eedf8 c01d0124 c01eedf8  
Jan  3 04:02:35 keule kernel: Call Trace: [try_to_free_inodes+199/264] [grow_inodes+30/384] [get_new_inode+173/280] [get_new_inode+185/280] [iget+88/96] [ext2_lookup+84/124] [real_lookup+79/160]  
Jan  3 04:02:35 keule kernel:        [lookup_dentry+296/488] [__namei+40/88] [sys_newlstat+14/96] [system_call+52/56]  
Jan  3 04:02:35 keule kernel: Code: 89 01 89 56 38 89 56 3c 83 7f 1c 01 0f 94 c0 31 c9 88 c1 89  
---
Dec 20 19:11:58 keule kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000025 
Dec 20 19:11:58 keule kernel: current->tss.cr3 = 00c1d000, %%cr3 = 00c1d000 
Dec 20 19:11:58 keule kernel: *pde = 0204d067 
Dec 20 19:11:58 keule kernel: *pte = 00000000 
Dec 20 19:11:58 keule kernel: Oops: 0000 
Dec 20 19:11:58 keule kernel: CPU:    0 
Dec 20 19:11:58 keule kernel: EIP:    0010:[max_select_fd+78/188] 
Dec 20 19:11:58 keule kernel: EFLAGS: 00010a13 
Dec 20 19:11:58 keule kernel: eax: 00000025   ebx: 00000000   ecx: c41bfee4   edx: 00000000 
Dec 20 19:11:58 keule kernel: esi: 00000010   edi: 00000005   ebp: 00000001   esp: c41bff08 
Dec 20 19:11:58 keule kernel: ds: 0018   es: 0018   ss: 0018 
Dec 20 19:11:58 keule kernel: Process proxyper (pid: 22976, process nr: 58, stackpage=c41bf000) 
Dec 20 19:11:58 keule kernel:        c012df22 00000005 c41bff70 c41bff6c 00000000 bfffefbc c41bffc0 bfffefa0  
Dec 20 19:11:58 keule kernel:        c73cf92c c7fec400 00000004 00000001 00000006 c41bff70 00000001 c41be000  
Dec 20 19:11:58 keule kernel: Call Trace: [sys_select+1014/1360] [old_select+86/104] [system_call+52/56]
Dec 20 19:11:58 keule kernel: Code: 0b 14 98 89 d0 8b 55 08 0b 04 9a 21 44 24 10 74 50 8b 07 f7 
---


Dec 16 13:19:34 keule kernel: Unable to handle kernel paging request at virtual address 38c4a693 
Dec 16 13:19:34 keule kernel: current->tss.cr3 = 04285000, %%cr3 = 04285000 
Dec 16 13:19:34 keule kernel: *pde = 00000000 
Dec 16 13:19:34 keule kernel: Oops: 0000 
Dec 16 13:19:34 keule kernel: CPU:    0 
Dec 16 13:19:34 keule kernel: EIP:    0010:[iput+24/508] 
Dec 16 13:19:34 keule kernel: EFLAGS: 00010206 
Dec 16 13:19:34 keule kernel: eax: 38c4a67b   ebx: 00000000   ecx: c71870b0   edx: c01cd694 
Dec 16 13:19:34 keule kernel: esi: c4d140e0   edi: c1ee62a0   ebp: bfffe4f0   esp: c542bf50 
Dec 16 13:19:34 keule kernel: ds: 0018   es: 0018   ss: 0018 
Dec 16 13:19:34 keule kernel: Process ftps (pid: 30881, process nr: 87, stackpage=c542b000) 
Dec 16 13:19:34 keule kernel: Stack: c1ee62a0 c0149cf7 c4d140e0 c4d14ee0 c014a0a5 c4d14f7c c32aee60 c0123d2b  
Dec 16 13:19:34 keule kernel:        c4d14ee0 c32aee60 c32aee60 00000000 c1ee62a0 c0124df7 c32aee60 c32aee60  
Dec 16 13:19:34 keule kernel:        c32aee60 c0123da6 c32aee60 00000004 c32aee60 fffffff7 c0123e0d c32aee60  
Dec 16 13:19:34 keule kernel: Call Trace: [sock_release+75/80] [sock_close+53/60] [__fput+31/72] [fput+23/72] [filp_close+82/92] [sys_close+93/104] [system_call+52/56]  
Dec 16 13:19:34 keule kernel: Code: 8b 40 18 85 c0 74 02 89 c3 85 db 74 0d 8b 43 08 85 c0 74 06  


7.
7.1
Red Hat Linux release 6.1 (Cartman)
vixie-cron-3.0.1-39
crontabs-1.7-7

The server uses 3 eth devices - access is limited by firewall
services are mainly
ssh,http,ircd,mysql,simap(stunnel),smtp



ls /etc/cron.daily/:
---
./   logrotate*        rdate.cron*    tmpwatch*
../  makewhatis.cron*  slocate.cron*  webalizer.cron*
---

/etc/crontab:
---
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=root
HOME=/

# run-parts
01 * * * * root run-parts /etc/cron.hourly
02 4 * * * root run-parts /etc/cron.daily
22 4 * * 0 root run-parts /etc/cron.weekly
42 4 1 * * root run-parts /etc/cron.monthly
# Mandrake-Security : if you remove this comment, remove the next line too.
0 0 * * *    root    /etc/security/msec/cron-sh/security.sh
---

7.2
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 12
cpu MHz		: 166.095
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 330.96

7.3
cat /proc/modules 
3c509                   5812   1 (autoclean)

 
--
Sebastian Wenzler
InnNet GmbH Internet-Services
http://www.InnNet.de
Gewerbering 12
D-83549 Eiselfing
Tel. 08071/9233-0
Fax 08071/9233-29
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
