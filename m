Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSFRAuS>; Mon, 17 Jun 2002 20:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSFRAuR>; Mon, 17 Jun 2002 20:50:17 -0400
Received: from surf.viawest.net ([216.87.64.26]:50940 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S317209AbSFRAuL>;
	Mon, 17 Jun 2002 20:50:11 -0400
Date: Mon, 17 Jun 2002 17:50:07 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.22 Floppy Oops
Message-ID: <20020618005007.GA2001@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.22 (i686)
X-uptime: 5:42pm  up  1:57,  2 users,  load average: 0.12, 0.03, 0.01
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        This oops is reproducible on 2.5.22 with the floppy driver built as a
module. Steps involved were:

        compile 2.5.22, and install with make bzlilo.

        reboot to 2.5.22.

        make bzdisk, to write the image to floppy.

        When the call to dd is made, boom:

generic_make_request: Trying to access nonexistent block-device fd(2,0) (0)
Unable to handle kernel NULL pointer dereference at virtual address 00000094
 printing eip:
c01bfa47
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bfa47>]    Not tainted
EFLAGS: 00010002
eax: 00000000   ebx: 00000094   ecx: dbca6000   edx: dbca7e2c
esi: 00000000   edi: c1455618   ebp: dfdb17e8   esp: dbca7e00
ds: 0018   es: 0018   ss: 0018
Process dd (pid: 525, threadinfo=dbca6000 task=dd2cfac0)
Stack: dbca7e2c dbca7e48 e1176403 00000000 dfdb17e8 00000000 dbca7e48 dfdb17e8 
       00000200 00000001 c0130200 00000001 00000000 dbca7e34 dbca7e34 c1455618 
       00000400 00000000 00000000 00000000 dfdb17e8 00000000 00000000 00000001 
Call Trace: [<e1176403>] [<c0130200>] [<e1176340>] [<e117648a>] [<e11765e0>] 
   [<e117a204>] [<c01400e3>] [<c0130200>] [<e11761f6>] [<e1170200>] [<c014026d>] 
   [<c014376b>] [<c01404f2>] [<c017a1f4>] [<c01395f1>] [<c0139502>] [<c01398e7>] 
   [<c0106dab>] 

Code: 39 9e 94 00 00 00 74 40 ff 41 10 8b 53 04 8b 86 94 00 00 00 
 <6>note: dd[525] exited with preempt_count 2

floppy driver state
-------------------
now=5886 last interrupt=5586 diff=300 last called handler=e1170370
timeout_message=lock fdc
last output bytes:
 0  0 0
 0  0 0
 0  0 0
 8 80 5585
 8 80 5585
 8 80 5585
 8 80 5585
 e 80 5585
13 80 5586
 0 90 5586
1a 90 5586
 0 90 5586
12 90 5586
 0 90 5586
14 90 5586
18 80 5586
 8 80 5586
 8 80 5586
 8 80 5586
 8 80 5586
last result at 5586
last redo_fd_request at 5586

status=80
fdc_busy=1
cont=00000000
CURRENT=00000000
command_status=-1

floppy0: floppy timeout called
no cont in shutdown!
floppy0: timeout handler died: floppy shutdown

ksymoops 2.4.5 on i686 2.5.22.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.22/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000094
c01bfa47
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bfa47>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000094   ecx: dbca6000   edx: dbca7e2c
esi: 00000000   edi: c1455618   ebp: dfdb17e8   esp: dbca7e00
ds: 0018   es: 0018   ss: 0018
Stack: dbca7e2c dbca7e48 e1176403 00000000 dfdb17e8 00000000 dbca7e48 dfdb17e8 
       00000200 00000001 c0130200 00000001 00000000 dbca7e34 dbca7e34 c1455618 
       00000400 00000000 00000000 00000000 dfdb17e8 00000000 00000000 00000001 
Call Trace: [<e1176403>] [<c0130200>] [<e1176340>] [<e117648a>] [<e11765e0>] 
   [<e117a204>] [<c01400e3>] [<c0130200>] [<e11761f6>] [<e1170200>] [<c014026d>] 
   [<c014376b>] [<c01404f2>] [<c017a1f4>] [<c01395f1>] [<c0139502>] [<c01398e7>] 
   [<c0106dab>] 
Code: 39 9e 94 00 00 00 74 40 ff 41 10 8b 53 04 8b 86 94 00 00 00 


>>EIP; c01bfa47 <generic_unplug_device+17/80>   <=====

>>ecx; dbca6000 <_end+1b9a95dc/2051b5dc>
>>edx; dbca7e2c <_end+1b9ab408/2051b5dc>
>>edi; c1455618 <_end+1158bf4/2051b5dc>
>>ebp; dfdb17e8 <_end+1fab4dc4/2051b5dc>
>>esp; dbca7e00 <_end+1b9ab3dc/2051b5dc>

Trace; e1176403 <[floppy]__floppy_read_block_0+b3/f0>
Trace; c0130200 <shrink_cache+1a0/3e0>
Trace; e1176340 <[floppy]floppy_rb0_complete+0/10>
Trace; e117648a <[floppy]floppy_read_block_0+4a/60>
Trace; e11765e0 <[floppy]floppy_revalidate+140/170>
Trace; e117a204 <[floppy]floppy_fops+0/18>
Trace; c01400e3 <check_disk_change+b3/c0>
Trace; c0130200 <shrink_cache+1a0/3e0>
Trace; e11761f6 <[floppy]floppy_open+336/390>
Trace; e1170200 <[floppy]floppy_interrupt+70/180>
Trace; c014026d <do_open+12d/310>
Trace; c014376b <permission+7b/90>
Trace; c01404f2 <blkdev_open+22/30>
Trace; c017a1f4 <devfs_open+84/200>
Trace; c01395f1 <dentry_open+e1/190>
Trace; c0139502 <filp_open+52/60>
Trace; c01398e7 <sys_open+37/80>
Trace; c0106dab <syscall_call+7/b>

Code;  c01bfa47 <generic_unplug_device+17/80>
0000000000000000 <_EIP>:
Code;  c01bfa47 <generic_unplug_device+17/80>   <=====
   0:   39 9e 94 00 00 00         cmp    %ebx,0x94(%esi)   <=====
Code;  c01bfa4d <generic_unplug_device+1d/80>
   6:   74 40                     je     48 <_EIP+0x48> c01bfa8f <generic_unplug_device+5f/80>
Code;  c01bfa4f <generic_unplug_device+1f/80>
   8:   ff 41 10                  incl   0x10(%ecx)
Code;  c01bfa52 <generic_unplug_device+22/80>
   b:   8b 53 04                  mov    0x4(%ebx),%edx
Code;  c01bfa55 <generic_unplug_device+25/80>
   e:   8b 86 94 00 00 00         mov    0x94(%esi),%eax


        .config available on request.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

