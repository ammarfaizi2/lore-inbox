Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVBOWnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVBOWnl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 17:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVBOWmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 17:42:09 -0500
Received: from mta13.mail.adelphia.net ([68.168.78.44]:23478 "EHLO
	mta13.adelphia.net") by vger.kernel.org with ESMTP id S261924AbVBOWjp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 17:39:45 -0500
Message-ID: <421279EC.80108@nodivisions.com>
Date: Tue, 15 Feb 2005 17:38:36 -0500
From: Anthony DiSante <theant@nodivisions.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: two Oopses on 2.6.10
Content-Type: multipart/mixed;
 boundary="------------010407030500020900010909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407030500020900010909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've had two recent Oopses on two different 2.6.10 kernels on an SMP system. 
  The system was being used "normally" -- a web browser, a few xterms and 
text-editors, and a VNC window running on it, in addition to some services 
(apache, ssh...).  The only thing that sticks out is that this only happens 
when someone's physically in front of the box, using its kb/mouse/monitor. 
We have this system on a KVM, and we get the jumping mouse a few times a 
day, and sometimes X and/or the whole system locks up... at first I thought 
this might be a KVM problem, but with these kernel oops I'm not sure.

The attached oops reports were created by copying the oops info from 
/var/log/messages into oops.01 and oops.02, then running:

# ksymoops -K -o /lib/modules/2.6.10-1.9_FC2smp/ -m 
/boot/System.map-2.6.10-1.9_FC2smp oops.01 >ksymoops.01

# ksymoops -K -o /lib/modules/2.6.10-1.12_FC2smp/ -m 
/boot/System.map-2.6.10-1.12_FC2smp oops.02 >ksymoops.02

Please let me know if there's any other information I need to provide.

-Anthony DiSante
http://nodivisions.com/



--------------010407030500020900010909
Content-Type: text/plain;
 name="ksymoops.01"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.01"

ksymoops 2.4.5 on i686 2.6.10-1.12_FC2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10-1.9_FC2smp/ (specified)
     -m /boot/System.map-2.6.10-1.9_FC2smp (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Jan 25 15:30:11 hostfoo kernel: eip: c0124efd
Jan 25 15:30:11 hostfoo kernel: kernel BUG at include/asm/spinlock.h:146!
Jan 25 15:30:11 hostfoo kernel: invalid operand: 0000 [#1]
Jan 25 15:30:11 hostfoo kernel: CPU:    0
Jan 25 15:30:11 hostfoo kernel: EIP:    0060:[<c02bdc7d>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Jan 25 15:30:11 hostfoo kernel: EFLAGS: 00210006   (2.6.10-1.9_FC2smp) 
Jan 25 15:30:11 hostfoo kernel: eax: c0124efd   ebx: 00200286   ecx: c02d4a00   edx: c02d4a00
Jan 25 15:30:11 hostfoo kernel: esi: c201fa00   edi: cc6bbfa0   ebp: f576be80   esp: cc6bbf18
Jan 25 15:30:11 hostfoo kernel: ds: 007b   es: 007b   ss: 0068
Jan 25 15:30:11 hostfoo kernel: Stack: cc6bbf38 c201fa60 c0124efd cc6bbf38 181712b7 c0124fe9 181712b7 c02bd6a3 
Jan 25 15:30:11 hostfoo kernel:        c2020028 c2020028 181712b7 00000001 dead4ead 4b87ad6e c0125706 da7c1a40 
Jan 25 15:30:11 hostfoo kernel:        c201fa60 f576be80 0000002e cc6bbfa0 00000000 0000002e c016231d 00000000 
Jan 25 15:30:11 hostfoo kernel:  [<c0124efd>] del_timer+0x22/0x63
Jan 25 15:30:11 hostfoo kernel:  [<c0124fe9>] del_singleshot_timer_sync+0x8/0x21
Jan 25 15:30:11 hostfoo kernel:  [<c02bd6a3>] schedule_timeout+0x9a/0xae
Jan 25 15:30:11 hostfoo kernel:  [<c0125706>] process_timeout+0x0/0x5
Jan 25 15:30:11 hostfoo kernel:  [<c016231d>] do_poll+0x88/0xa6
Jan 25 15:30:11 hostfoo kernel:  [<c0162456>] sys_poll+0x11b/0x1bd
Jan 25 15:30:11 hostfoo kernel:  [<c0161963>] __pollwait+0x0/0x95
Jan 25 15:30:11 hostfoo kernel:  [<c0121b34>] sys_gettimeofday+0x25/0x55
Jan 25 15:30:11 hostfoo kernel:  [<c0103ccb>] syscall_call+0x7/0xb
Jan 25 15:30:11 hostfoo kernel: Code: 81 00 00 00 00 01 c3 f0 ff 00 c3 56 89 c6 53 9c 5b fa 81 78 04 ad 4e ad de 74 18 ff 74 24 08 68 00 4a 2d c0 e8 c6 04 e6 ff 59 58 <0f> 0b 92 00 e0 39 2d c0 f0 fe 0e 79 13 f7 c3 00 02 00 00 74 01 


>>EIP; c02bdc7d <_spin_lock_irqsave+20/45>   <=====

>>eax; c0124efd <del_timer+22/63>
>>ebx; 00200286 Before first symbol
>>ecx; c02d4a00 <__func__.2+9dd7/2f1fb>
>>edx; c02d4a00 <__func__.2+9dd7/2f1fb>
>>esi; c201fa00 <END_OF_CODE+1bcea00/????>
>>edi; cc6bbfa0 <END_OF_CODE+c26afa0/????>
>>ebp; f576be80 <END_OF_CODE+3531ae80/????>
>>esp; cc6bbf18 <END_OF_CODE+c26af18/????>

Code;  c02bdc52 <_write_unlock+1/8>
00000000 <_EIP>:
Code;  c02bdc52 <_write_unlock+1/8>
   0:   81 00 00 00 00 01         addl   $0x1000000,(%eax)
Code;  c02bdc58 <_write_unlock+7/8>
   6:   c3                        ret    
Code;  c02bdc59 <_read_unlock+0/4>
   7:   f0 ff 00                  lock incl (%eax)
Code;  c02bdc5c <_read_unlock+3/4>
   a:   c3                        ret    
Code;  c02bdc5d <_spin_lock_irqsave+0/45>
   b:   56                        push   %esi
Code;  c02bdc5e <_spin_lock_irqsave+1/45>
   c:   89 c6                     mov    %eax,%esi
Code;  c02bdc60 <_spin_lock_irqsave+3/45>
   e:   53                        push   %ebx
Code;  c02bdc61 <_spin_lock_irqsave+4/45>
   f:   9c                        pushf  
Code;  c02bdc62 <_spin_lock_irqsave+5/45>
  10:   5b                        pop    %ebx
Code;  c02bdc63 <_spin_lock_irqsave+6/45>
  11:   fa                        cli    
Code;  c02bdc64 <_spin_lock_irqsave+7/45>
  12:   81 78 04 ad 4e ad de      cmpl   $0xdead4ead,0x4(%eax)
Code;  c02bdc6b <_spin_lock_irqsave+e/45>
  19:   74 18                     je     33 <_EIP+0x33>
Code;  c02bdc6d <_spin_lock_irqsave+10/45>
  1b:   ff 74 24 08               pushl  0x8(%esp)
Code;  c02bdc71 <_spin_lock_irqsave+14/45>
  1f:   68 00 4a 2d c0            push   $0xc02d4a00
Code;  c02bdc76 <_spin_lock_irqsave+19/45>
  24:   e8 c6 04 e6 ff            call   ffe604ef <_EIP+0xffe604ef>
Code;  c02bdc7b <_spin_lock_irqsave+1e/45>
  29:   59                        pop    %ecx
Code;  c02bdc7c <_spin_lock_irqsave+1f/45>
  2a:   58                        pop    %eax
Code;  c02bdc7d <_spin_lock_irqsave+20/45>   <=====
  2b:   0f 0b                     ud2a      <=====
Code;  c02bdc7f <_spin_lock_irqsave+22/45>
  2d:   92                        xchg   %eax,%edx
Code;  c02bdc80 <_spin_lock_irqsave+23/45>
  2e:   00 e0                     add    %ah,%al
Code;  c02bdc82 <_spin_lock_irqsave+25/45>
  30:   39 2d c0 f0 fe 0e         cmp    %ebp,0xefef0c0
Code;  c02bdc88 <_spin_lock_irqsave+2b/45>
  36:   79 13                     jns    4b <_EIP+0x4b>
Code;  c02bdc8a <_spin_lock_irqsave+2d/45>
  38:   f7 c3 00 02 00 00         test   $0x200,%ebx
Code;  c02bdc90 <_spin_lock_irqsave+33/45>
  3e:   74 01                     je     41 <_EIP+0x41>

Jan 25 15:30:12 hostfoo kernel:  <1>Unable to handle kernel paging request at virtual address 851ba4f4
Jan 25 15:30:12 hostfoo kernel: c01187f5
Jan 25 15:30:12 hostfoo kernel: *pde = 349a9001
Jan 25 15:30:12 hostfoo kernel: Oops: 0000 [#2]
Jan 25 15:30:12 hostfoo kernel: CPU:    1
Jan 25 15:30:12 hostfoo kernel: EIP:    0060:[<c01187f5>]    Not tainted VLI
Jan 25 15:30:12 hostfoo kernel: EFLAGS: 00013082   (2.6.10-1.9_FC2smp) 
Jan 25 15:30:12 hostfoo kernel: eax: 31383135   ebx: c03a9100   ecx: 00000000   edx: da7c1a40
Jan 25 15:30:12 hostfoo kernel: esi: c03a9100   edi: f4f3dd38   ebp: f4f3dd00   esp: f4f3dcf0
Jan 25 15:30:12 hostfoo kernel: ds: 007b   es: 007b   ss: 0068
Jan 25 15:30:12 hostfoo kernel: Stack: da7c1a40 e5e6a044 00000001 da7c1a40 f4f3dd48 c0118d16 f4f3dd40 c011a3f7 
Jan 25 15:30:12 hostfoo kernel:        00000000 00000001 00000380 c2027060 00000001 00000000 00000001 00000001 
Jan 25 15:30:12 hostfoo kernel:        00000000 00000001 00003082 e5e6a044 00000001 e0e7c518 f4f3dd6c c011a44f 
Jan 25 15:30:12 hostfoo kernel:  [<c0118d16>] try_to_wake_up+0x20/0x21e
Jan 25 15:30:12 hostfoo kernel:  [<c011a3f7>] scheduler_tick+0x3b3/0x3c9
Jan 25 15:30:12 hostfoo kernel:  [<c011a44f>] __wake_up_common+0x36/0x5b
Jan 25 15:30:12 hostfoo kernel:  [<c011a49d>] __wake_up+0x29/0x3c
Jan 25 15:30:12 hostfoo kernel:  [<c0268de4>] sock_def_readable+0x31/0x5e
Jan 25 15:30:12 hostfoo kernel:  [<c02b9353>] unix_stream_sendmsg+0x253/0x348
Jan 25 15:30:12 hostfoo kernel:  [<c02662b6>] sock_sendmsg+0xdb/0xf7
Jan 25 15:30:12 hostfoo kernel:  [<c01199a1>] find_busiest_group+0xf1/0x2d2
Jan 25 15:30:12 hostfoo kernel:  [<c019ca7e>] avc_has_perm_noaudit+0x37/0xdc
Jan 25 15:30:12 hostfoo kernel:  [<c012e826>] autoremove_wake_function+0x0/0x2d
Jan 25 15:30:12 hostfoo kernel:  [<c019dbf4>] inode_has_perm+0x4c/0x54
Jan 25 15:30:12 hostfoo kernel:  [<c026672f>] sock_readv_writev+0x7c/0x83
Jan 25 15:30:12 hostfoo kernel:  [<c0266794>] sock_writev+0x2a/0x31
Jan 25 15:30:12 hostfoo kernel:  [<c026676a>] sock_writev+0x0/0x31
Jan 25 15:30:12 hostfoo kernel:  [<c0152702>] do_readv_writev+0x15d/0x1de
Jan 25 15:30:12 hostfoo kernel:  [<c0109af4>] convert_fxsr_from_user+0x27/0xe9
Jan 25 15:30:12 hostfoo kernel:  [<c011a3f7>] scheduler_tick+0x3b3/0x3c9
Jan 25 15:30:12 hostfoo kernel:  [<c0109d9c>] restore_i387+0x17/0x7a
Jan 25 15:30:12 hostfoo kernel:  [<c01527fe>] vfs_writev+0x3d/0x41
Jan 25 15:30:12 hostfoo kernel:  [<c01528a0>] sys_writev+0x3c/0x62
Jan 25 15:30:12 hostfoo kernel:  [<c0103ccb>] syscall_call+0x7/0xb
Jan 25 15:30:12 hostfoo kernel: Code: ba 05 00 00 00 39 c2 0f 4d c2 c3 55 89 e5 57 89 d7 56 53 51 89 45 f0 9c 8f 07 fa 8b 55 f0 bb 00 91 3a c0 89 de 8b 42 04 8b 40 10 <03> 34 85 20 e0 3a c0 89 f0 e8 b6 53 1a 00 8b 55 f0 8b 42 04 8b 


>>EIP; c01187f5 <task_rq_lock+20/55>   <=====

>>eax; 31383135 Before first symbol
>>ebx; c03a9100 <per_cpu__runqueues+0/960>
>>edx; da7c1a40 <END_OF_CODE+1a370a40/????>
>>esi; c03a9100 <per_cpu__runqueues+0/960>
>>edi; f4f3dd38 <END_OF_CODE+34aecd38/????>
>>ebp; f4f3dd00 <END_OF_CODE+34aecd00/????>
>>esp; f4f3dcf0 <END_OF_CODE+34aeccf0/????>

Code;  c01187ca <task_timeslice+22/2d>
00000000 <_EIP>:
Code;  c01187ca <task_timeslice+22/2d>
   0:   ba 05 00 00 00            mov    $0x5,%edx
Code;  c01187cf <task_timeslice+27/2d>
   5:   39 c2                     cmp    %eax,%edx
Code;  c01187d1 <task_timeslice+29/2d>
   7:   0f 4d c2                  cmovge %edx,%eax
Code;  c01187d4 <task_timeslice+2c/2d>
   a:   c3                        ret    
Code;  c01187d5 <task_rq_lock+0/55>
   b:   55                        push   %ebp
Code;  c01187d6 <task_rq_lock+1/55>
   c:   89 e5                     mov    %esp,%ebp
Code;  c01187d8 <task_rq_lock+3/55>
   e:   57                        push   %edi
Code;  c01187d9 <task_rq_lock+4/55>
   f:   89 d7                     mov    %edx,%edi
Code;  c01187db <task_rq_lock+6/55>
  11:   56                        push   %esi
Code;  c01187dc <task_rq_lock+7/55>
  12:   53                        push   %ebx
Code;  c01187dd <task_rq_lock+8/55>
  13:   51                        push   %ecx
Code;  c01187de <task_rq_lock+9/55>
  14:   89 45 f0                  mov    %eax,0xfffffff0(%ebp)
Code;  c01187e1 <task_rq_lock+c/55>
  17:   9c                        pushf  
Code;  c01187e2 <task_rq_lock+d/55>
  18:   8f 07                     popl   (%edi)
Code;  c01187e4 <task_rq_lock+f/55>
  1a:   fa                        cli    
Code;  c01187e5 <task_rq_lock+10/55>
  1b:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
Code;  c01187e8 <task_rq_lock+13/55>
  1e:   bb 00 91 3a c0            mov    $0xc03a9100,%ebx
Code;  c01187ed <task_rq_lock+18/55>
  23:   89 de                     mov    %ebx,%esi
Code;  c01187ef <task_rq_lock+1a/55>
  25:   8b 42 04                  mov    0x4(%edx),%eax
Code;  c01187f2 <task_rq_lock+1d/55>
  28:   8b 40 10                  mov    0x10(%eax),%eax
Code;  c01187f5 <task_rq_lock+20/55>   <=====
  2b:   03 34 85 20 e0 3a c0      add    0xc03ae020(,%eax,4),%esi   <=====
Code;  c01187fc <task_rq_lock+27/55>
  32:   89 f0                     mov    %esi,%eax
Code;  c01187fe <task_rq_lock+29/55>
  34:   e8 b6 53 1a 00            call   1a53ef <_EIP+0x1a53ef>
Code;  c0118803 <task_rq_lock+2e/55>
  39:   8b 55 f0                  mov    0xfffffff0(%ebp),%edx
Code;  c0118806 <task_rq_lock+31/55>
  3c:   8b 42 04                  mov    0x4(%edx),%eax
Code;  c0118809 <task_rq_lock+34/55>
  3f:   8b                        .byte 0x8b


--------------010407030500020900010909
Content-Type: text/plain;
 name="ksymoops.02"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ksymoops.02"

ksymoops 2.4.5 on i686 2.6.10-1.12_FC2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10-1.12_FC2smp/ (specified)
     -m /boot/System.map-2.6.10-1.12_FC2smp (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Feb 11 01:34:33 hostfoo kernel:  <1>Unable to handle kernel paging request at virtual address 80899e10
Feb 11 01:34:33 hostfoo kernel: c02be356
Feb 11 01:34:33 hostfoo kernel: *pde = f6d6f424
Feb 11 01:34:33 hostfoo kernel: Oops: 0000 [#2]
Feb 11 01:34:33 hostfoo kernel: CPU:    1
Feb 11 01:34:33 hostfoo kernel: EIP:    0060:[<c02be356>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Feb 11 01:34:33 hostfoo kernel: EFLAGS: 00013087   (2.6.10-1.12_FC2smp) 
Feb 11 01:34:33 hostfoo kernel: eax: 80899e0c   ebx: 80899e0c   ecx: 00000000   edx: dedc7540
Feb 11 01:34:33 hostfoo kernel: esi: 80899e0c   edi: e185ed38   ebp: e185ed00   esp: e185ece8
Feb 11 01:34:33 hostfoo kernel: ds: 007b   es: 007b   ss: 0068
Feb 11 01:34:33 hostfoo kernel: Stack: c03aa100 c01188ab dedc7540 e2ac1044 00000001 dedc7540 e185ed48 c0118dbe 
Feb 11 01:34:33 hostfoo kernel:        00000037 00000089 00000000 00000001 00000200 c2027060 00000001 00000000 
Feb 11 01:34:33 hostfoo kernel:        00000001 00000001 00000000 00000001 00003082 e2ac1044 00000001 de88f518 
Feb 11 01:34:33 hostfoo kernel:  [<c01188ab>] task_rq_lock+0x2e/0x55
Feb 11 01:34:33 hostfoo kernel:  [<c0118dbe>] try_to_wake_up+0x20/0x21e
Feb 11 01:34:33 hostfoo kernel:  [<c011a4f7>] __wake_up_common+0x36/0x5b
Feb 11 01:34:33 hostfoo kernel:  [<c011a545>] __wake_up+0x29/0x3c
Feb 11 01:34:33 hostfoo kernel:  [<c026970c>] sock_def_readable+0x31/0x5e
Feb 11 01:34:33 hostfoo kernel:  [<c02b9aaf>] unix_stream_sendmsg+0x253/0x348
Feb 11 01:34:33 hostfoo kernel:  [<c011a545>] __wake_up+0x29/0x3c
Feb 11 01:34:33 hostfoo kernel:  [<c0266b12>] sock_sendmsg+0xdb/0xf7
Feb 11 01:34:33 hostfoo kernel:  [<c0119a49>] find_busiest_group+0xf1/0x2d2
Feb 11 01:34:33 hostfoo kernel:  [<c019d4a2>] avc_has_perm_noaudit+0x37/0xdc
Feb 11 01:34:33 hostfoo kernel:  [<c012ec8e>] autoremove_wake_function+0x0/0x2d
Feb 11 01:34:33 hostfoo kernel:  [<c019e618>] inode_has_perm+0x4c/0x54
Feb 11 01:34:33 hostfoo kernel:  [<c0266f8b>] sock_readv_writev+0x7c/0x83
Feb 11 01:34:33 hostfoo kernel:  [<c0266ff0>] sock_writev+0x2a/0x31
Feb 11 01:34:33 hostfoo kernel:  [<c0266fc6>] sock_writev+0x0/0x31
Feb 11 01:34:33 hostfoo kernel:  [<c015302a>] do_readv_writev+0x15d/0x1de
Feb 11 01:34:33 hostfoo kernel:  [<c0109b1e>] convert_fxsr_from_user+0x27/0xe9
Feb 11 01:34:33 hostfoo kernel:  [<c0109dc6>] restore_i387+0x17/0x7a
Feb 11 01:34:33 hostfoo kernel:  [<c0153126>] vfs_writev+0x3d/0x41
Feb 11 01:34:33 hostfoo kernel:  [<c01531c8>] sys_writev+0x3c/0x62
Feb 11 01:34:33 hostfoo kernel:  [<c0103ccb>] syscall_call+0x7/0xb
Feb 11 01:34:33 hostfoo kernel: Code: c0 84 d2 0f 9f c0 c3 89 c2 f0 81 28 00 00 00 01 0f 94 c0 84 c0 b9 01 00 00 00 75 09 f0 81 02 00 00 00 01 31 c9 89 c8 c3 53 89 c3 <81> 78 04 ad 4e ad de 74 18 ff 74 24 04 68 80 4d 2d c0 e8 cf fe 


>>EIP; c02be356 <_spin_lock+3/34>   <=====

>>eax; 80899e0c Before first symbol
>>ebx; 80899e0c Before first symbol
>>edx; dedc7540 <END_OF_CODE+1e974540/????>
>>esi; 80899e0c Before first symbol
>>edi; e185ed38 <END_OF_CODE+2140bd38/????>
>>ebp; e185ed00 <END_OF_CODE+2140bd00/????>
>>esp; e185ece8 <END_OF_CODE+2140bce8/????>

Code;  c02be32b <_spin_trylock+5/c>
00000000 <_EIP>:
Code;  c02be32b <_spin_trylock+5/c>
   0:   c0 84 d2 0f 9f c0 c3      rolb   $0x89,0xc3c09f0f(%edx,%edx,8)
Code;  c02be332 <_write_trylock+0/21>
   7:   89 
Code;  c02be333 <_write_trylock+1/21>
   8:   c2 f0 81                  ret    $0x81f0
Code;  c02be336 <_write_trylock+4/21>
   b:   28 00                     sub    %al,(%eax)
Code;  c02be338 <_write_trylock+6/21>
   d:   00 00                     add    %al,(%eax)
Code;  c02be33a <_write_trylock+8/21>
   f:   01 0f                     add    %ecx,(%edi)
Code;  c02be33c <_write_trylock+a/21>
  11:   94                        xchg   %eax,%esp
Code;  c02be33d <_write_trylock+b/21>
  12:   c0 84 c0 b9 01 00 00      rolb   $0x0,0x1b9(%eax,%eax,8)
Code;  c02be344 <_write_trylock+12/21>
  19:   00 
Code;  c02be345 <_write_trylock+13/21>
  1a:   75 09                     jne    25 <_EIP+0x25>
Code;  c02be347 <_write_trylock+15/21>
  1c:   f0 81 02 00 00 00 01      lock addl $0x1000000,(%edx)
Code;  c02be34e <_write_trylock+1c/21>
  23:   31 c9                     xor    %ecx,%ecx
Code;  c02be350 <_write_trylock+1e/21>
  25:   89 c8                     mov    %ecx,%eax
Code;  c02be352 <_write_trylock+20/21>
  27:   c3                        ret    
Code;  c02be353 <_spin_lock+0/34>
  28:   53                        push   %ebx
Code;  c02be354 <_spin_lock+1/34>
  29:   89 c3                     mov    %eax,%ebx
Code;  c02be356 <_spin_lock+3/34>   <=====
  2b:   81 78 04 ad 4e ad de      cmpl   $0xdead4ead,0x4(%eax)   <=====
Code;  c02be35d <_spin_lock+a/34>
  32:   74 18                     je     4c <_EIP+0x4c>
Code;  c02be35f <_spin_lock+c/34>
  34:   ff 74 24 04               pushl  0x4(%esp)
Code;  c02be363 <_spin_lock+10/34>
  38:   68 80 4d 2d c0            push   $0xc02d4d80
Code;  c02be368 <_spin_lock+15/34>
  3d:   e8                        .byte 0xe8
Code;  c02be369 <_spin_lock+16/34>
  3e:   cf                        iret   
Code;  c02be36a <_spin_lock+17/34>
  3f:   fe                        .byte 0xfe


--------------010407030500020900010909--
