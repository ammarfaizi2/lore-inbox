Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSHIR2c>; Fri, 9 Aug 2002 13:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSHIR2c>; Fri, 9 Aug 2002 13:28:32 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:154 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315267AbSHIR2b>;
	Fri, 9 Aug 2002 13:28:31 -0400
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200208091732.g79HW4q02868@eng2.beaverton.ibm.com>
Subject: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
To: linux-kernel@vger.kernel.org
Date: Fri, 9 Aug 2002 10:32:04 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get following BUG() while trying to "rmmod" qlogic driver on 2.5.30.
Is this a known problem ? Any ideas to fix it ?

Thanks,
Badari

kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0160d0f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: f67ff7c0   ecx: f67f44fc   edx: c3c3d220
esi: f67f44fc   edi: f67ff7c0   ebp: ffffffd9   esp: db46de90
ds: 0018   es: 0018   ss: 0018
Stack: f67f44a0 c0160d95 f67ff7c0 f67ff7e8 f67ff7c0 f67ff7e8 f8860700 c016157e 
       f69a7e80 f67ff7c0 f88607e0 f88607e0 0000000f c01948f5 f8860878 c03179a0 
       c031b508 f88607e0 c015fef5 f88607e0 f88607e0 c0309fec f88607e0 c0309ffc 
Call Trace: [<c0160d95>] [<c016157e>] [<c01948f5>] [<c015fef5>] [<c020c52f>] 
   [<f89ac8a0>] [<c01e870a>] [<f899444a>] [<f89ac8a0>] [<c011859e>] [<c0117992>] 
   [<c0107173>] 
Code: 0f 0b 05 01 00 db 2a c0 f0 ff 03 f0 fe 0d 80 0e 38 c0 0f 88 

>>EIP; c0160d0f <d_unhash+f/70>   <=====
Trace; c0160d95 <driverfs_rmdir+25/90>
Trace; c016157e <driverfs_remove_dir+8e/b2>
Trace; c01948f5 <put_device+65/82>
Trace; c015fef5 <driverfs_remove_partitions+65/a0>
Trace; c020c52f <sd_detach+af/110>
Trace; f89ac8a0 <END_OF_CODE+385cf3c4/????>
Trace; c01e870a <scsi_unregister_host+21a/4e0>
Trace; f899444a <END_OF_CODE+385b6f6e/????>
Trace; f89ac8a0 <END_OF_CODE+385cf3c4/????>
Trace; c011859e <free_module+1e/d0>
Trace; c0117992 <sys_delete_module+122/250>
Trace; c0107173 <syscall_call+7/b>
Code;  c0160d0f <d_unhash+f/70>
00000000 <_EIP>:
Code;  c0160d0f <d_unhash+f/70>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0160d11 <d_unhash+11/70>
   2:   05 01 00 db 2a            add    $0x2adb0001,%eax
Code;  c0160d16 <d_unhash+16/70>
   7:   c0                        (bad)  
Code;  c0160d17 <d_unhash+17/70>
   8:   f0 ff 03                  lock incl (%ebx)
Code;  c0160d1a <d_unhash+1a/70>
   b:   f0 fe 0d 80 0e 38 c0      lock decb 0xc0380e80
Code;  c0160d21 <d_unhash+21/70>
  12:   0f 88 00 00 00 00         js     18 <_EIP+0x18> c0160d27 <d_unhash+27/70>



