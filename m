Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262248AbSJ0CxS>; Sat, 26 Oct 2002 22:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJ0CxS>; Sat, 26 Oct 2002 22:53:18 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.181.130.16]:48275 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262248AbSJ0CxQ> convert rfc822-to-8bit; Sat, 26 Oct 2002 22:53:16 -0400
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.44-ac4
Date: Sun, 27 Oct 2002 03:58:59 +0100
User-Agent: KMail/1.4.7
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Patrick Mochel <mochel@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200210270358.59928.Dieter.Nuetzel@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

radeon.o and sg.o NOT removable.

Module                  Size  Used by    Not tainted
sg                         0   0  (deleted)

Badness in put_device at drivers/base/core.c:139

void put_device(struct device * dev)
{
        down(&device_sem);
        if (!atomic_dec_and_test(&dev->refcount)) {
                up(&device_sem);
                return;
        }
        list_del_init(&dev->node);
        list_del_init(&dev->g_list);
        up(&device_sem);

>>>        WARN_ON(dev->state == DEVICE_REGISTERED);

        if (dev->state == DEVICE_GONE)
                device_del(dev);
}


ksymoops 2.4.7 on i686 2.5.44-ac4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44-ac4/ (default)
     -m /boot/System.map (specified)

Warning (compare_ksyms_lsmod): module sg is in lsmod but not in ksyms, 
probably no symbols exported
Call Trace: [<c01c1392>]  [<fd4fbe9a>]  [<fd50075c>]  [<fd50076c>]  
[<fd500640>]  [<c01e1f2c>]  [<fd4fbf2f>]  [<fd500640>]  [<c011f02c>]  
[<c011e358>]  [<c010754f>]
Call Trace: [<c01c1392>]  [<fd4fbe9a>]  [<fd50075c>]  [<fd50076c>]  
[<fd500640>]  [<c01e36ba>]  [<c01e1f2c>]  [<fd4fbf2f>]  [<fd500640>]  
[<c011f02c>]  [<c011e358>]  [<c010754f>]
Call Trace: [<c01c1392>]  [<fd4fbe9a>]  [<fd50075c>]  [<fd50076c>]  
[<fd500640>]  [<c01e36ba>]  [<c01e1f2c>]  [<fd4fbf2f>]  [<fd500640>]  
[<c011f02c>]  [<c011e358>]  [<c010754f>]
Call Trace: [<c01c1392>]  [<fd4fbe9a>]  [<fd50075c>]  [<fd50076c>]  
[<fd500640>]  [<c01e36ba>]  [<c01e1f2c>]  [<fd4fbf2f>]  [<fd500640>]  
[<c011f02c>]  [<c011e358>]  [<c010754f>]
Call Trace: [<c01c1392>]  [<fd4fbe9a>]  [<fd50075c>]  [<fd50076c>]  
[<fd500640>]  [<c01e1f2c>]  [<fd4fbf2f>]  [<fd500640>]  [<c011f02c>]  
[<c011e358>]  [<c010754f>]
Unable to handle kernel paging request at virtual address f90fa03c
c01c1e7d
*pde = 30a3f067
Oops: 0000
CPU:    1
EIP:    0060:[<c01c1e7d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246
eax: fd5006b0   ebx: c02c0820   ecx: fd500698   edx: f90fa03c
esi: fd500688   edi: fd500688   ebp: 00000000   esp: dfe6ff4c
ds: 0068   es: 0068   ss: 0068
Stack: c02c0820 fd500688 c02c0824 c01c20cb fd500688 fd500688 c02c0820 00000001
       c01c2596 fd500688 fd500688 fd4f9000 c01c2669 fd500688 fd4f9000 fd4fbf73
       fd500688 c011f02c dfe6e000 fd4f9000 f90f6000 c011e358 fd4f9000 00000001
Call Trace: [<fd500688>]  [<c01c20cb>]  [<fd500688>]  [<fd500688>]  
[<c01c2596>]  [<fd500688>]  [<fd500688>]  [<c01c2669>]  [<fd500688>]  
[<fd4fbf73>]  [<fd500688>]  [<c011f02c>]  [<c011e358>]  [<c010754f>]
Code: 8b 32 39 c2 74 2b 8d 5a e8 53 e8 e4 f3 ff ff 83 c4 04 85 c0


Trace; c01c1392 <put_device+a2/c0>
Trace; fd4fbe9a <[radeon].data.end+439107b/43b81e1>
Trace; fd50075c <[radeon].data.end+439593d/43b81e1>
Trace; fd50076c <[radeon].data.end+439594d/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c01e1f2c <scsi_unregister_device+5c/170>
Trace; fd4fbf2f <[radeon].data.end+4391110/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c011f02c <free_module+1c/f0>
Trace; c011e358 <sys_delete_module+248/2f0>
Trace; c010754f <syscall_call+7/b>
Trace; c01c1392 <put_device+a2/c0>
Trace; fd4fbe9a <[radeon].data.end+439107b/43b81e1>
Trace; fd50075c <[radeon].data.end+439593d/43b81e1>
Trace; fd50076c <[radeon].data.end+439594d/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c01e36ba <scsi_host_get_next+5a/70>
Trace; c01e1f2c <scsi_unregister_device+5c/170>
Trace; fd4fbf2f <[radeon].data.end+4391110/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c011f02c <free_module+1c/f0>
Trace; c011e358 <sys_delete_module+248/2f0>
Trace; c010754f <syscall_call+7/b>
Trace; c01c1392 <put_device+a2/c0>
Trace; fd4fbe9a <[radeon].data.end+439107b/43b81e1>
Trace; fd50075c <[radeon].data.end+439593d/43b81e1>
Trace; fd50076c <[radeon].data.end+439594d/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c01e36ba <scsi_host_get_next+5a/70>
Trace; c01e1f2c <scsi_unregister_device+5c/170>
Trace; fd4fbf2f <[radeon].data.end+4391110/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c011f02c <free_module+1c/f0>
Trace; c011e358 <sys_delete_module+248/2f0>
Trace; c010754f <syscall_call+7/b>
Trace; c01c1392 <put_device+a2/c0>
Trace; fd4fbe9a <[radeon].data.end+439107b/43b81e1>
Trace; fd50075c <[radeon].data.end+439593d/43b81e1>
Trace; fd50076c <[radeon].data.end+439594d/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c01e36ba <scsi_host_get_next+5a/70>
Trace; c01e1f2c <scsi_unregister_device+5c/170>
Trace; fd4fbf2f <[radeon].data.end+4391110/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c011f02c <free_module+1c/f0>
Trace; c011e358 <sys_delete_module+248/2f0>
Trace; c010754f <syscall_call+7/b>
Trace; c01c1392 <put_device+a2/c0>
Trace; fd4fbe9a <[radeon].data.end+439107b/43b81e1>
Trace; fd50075c <[radeon].data.end+439593d/43b81e1>
Trace; fd50076c <[radeon].data.end+439594d/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c01e1f2c <scsi_unregister_device+5c/170>
Trace; fd4fbf2f <[radeon].data.end+4391110/43b81e1>
Trace; fd500640 <[radeon].data.end+4395821/43b81e1>
Trace; c011f02c <free_module+1c/f0>
Trace; c011e358 <sys_delete_module+248/2f0>
Trace; c010754f <syscall_call+7/b>

>>EIP; c01c1e7d <driver_detach+d/50>   <=====

>>eax; fd5006b0 <[radeon].data.end+4395891/43b81e1>
>>ebx; c02c0820 <scsi_driverfs_bus_type+0/80>
>>ecx; fd500698 <[radeon].data.end+4395879/43b81e1>
>>edx; f90fa03c <[pppoe].data.end+1b9d/6b61>
>>esi; fd500688 <[radeon].data.end+4395869/43b81e1>
>>edi; fd500688 <[radeon].data.end+4395869/43b81e1>
>>esp; dfe6ff4c <_end+1fafb01c/38cb90d0>

Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; c01c20cb <bus_remove_driver+3b/80>
Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; c01c2596 <put_driver+56/80>
Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; c01c2669 <driver_unregister+49/4e>
Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; fd4fbf73 <[radeon].data.end+4391154/43b81e1>
Trace; fd500688 <[radeon].data.end+4395869/43b81e1>
Trace; c011f02c <free_module+1c/f0>
Trace; c011e358 <sys_delete_module+248/2f0>
Trace; c010754f <syscall_call+7/b>

Code;  c01c1e7d <driver_detach+d/50>
00000000 <_EIP>:
Code;  c01c1e7d <driver_detach+d/50>   <=====
   0:   8b 32                     mov    (%edx),%esi   <=====
Code;  c01c1e7f <driver_detach+f/50>
   2:   39 c2                     cmp    %eax,%edx
Code;  c01c1e81 <driver_detach+11/50>
   4:   74 2b                     je     31 <_EIP+0x31> c01c1eae 
<driver_detach+3e/50>
Code;  c01c1e83 <driver_detach+13/50>
   6:   8d 5a e8                  lea    0xffffffe8(%edx),%ebx
Code;  c01c1e86 <driver_detach+16/50>
   9:   53                        push   %ebx
Code;  c01c1e87 <driver_detach+17/50>
   a:   e8 e4 f3 ff ff            call   fffff3f3 <_EIP+0xfffff3f3> c01c1270 
<get_device+0/80>
Code;  c01c1e8c <driver_detach+1c/50>
   f:   83 c4 04                  add    $0x4,%esp
Code;  c01c1e8f <driver_detach+1f/50>
  12:   85 c0                     test   %eax,%eax

Regards,
	Dieter
