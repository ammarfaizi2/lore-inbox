Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVCYMwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVCYMwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 07:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCYMwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 07:52:53 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:30915 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261538AbVCYMwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 07:52:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=TwNxAG3ex5oWaUEPFLYYJoY5i3Rj1u+trkMmRoFrVp18ZhQ3wDdXa5/o0rqxYqCA9JZyLeWjJWljVwbXFd/4smpCzQ3f4gHoVuQPIvAHVf/cqpXdIjc4ljKIJYP9Ca+OG4ZYBbah6zcvZBQd/RK9PW02KQddKPcXksc3/MTfd8E=
Message-ID: <a44ae5cd05032504521e0db1d4@mail.gmail.com>
Date: Fri, 25 Mar 2005 07:52:18 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Andrew Morton <akpm@osdl.org>, miles.lane@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
In-Reply-To: <20050325081359.C18596@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050324044114.5aa5b166.akpm@osdl.org>
	 <a44ae5cd05032420122cd610bd@mail.gmail.com>
	 <20050324202215.663bd8a9.akpm@osdl.org>
	 <20050325073846.A18596@flint.arm.linux.org.uk>
	 <20050324234544.135a1eb2.akpm@osdl.org>
	 <20050325075032.B18596@flint.arm.linux.org.uk>
	 <20050325081359.C18596@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahem.  In this case, I think it was operator error.  I reproduced the
problem and have included the entire output of ksymoops below.

Andrew, this command causes the Oops for me:

root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls
./  ../  device@
root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls -l
Segmentation fault

root@Monkey100:/sys/class/i2c-adapter/i2c-1# dmesg|ksymoops -o
/lib/modules/2.6.12-rc1-mm2 -m /boot/System.map-2.6.12-rc1-mm2
ksymoops 2.4.9 on i686 2.6.12-rc1-mm2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12-rc1-mm2 (specified)
     -m /boot/System.map-2.6.12-rc1-mm2 (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
 [<c010414e>] dump_stack+0x1e/0x20
 [<c01f0b12>] kref_get+0x42/0x50
 [<c01f005b>] kobject_get+0x1b/0x30
 [<c01986f1>] sysfs_getlink+0x41/0x150
 [<c019884f>] sysfs_follow_link+0x4f/0x60
 [<c016b46f>] generic_readlink+0x2f/0x90
 [<c01635b6>] sys_readlink+0x86/0x90
 [<c0103249>] syscall_call+0x7/0xb
 [<c010414e>] dump_stack+0x1e/0x20
 [<c01f0b12>] kref_get+0x42/0x50
 [<c01f005b>] kobject_get+0x1b/0x30
 [<c019874d>] sysfs_getlink+0x9d/0x150
 [<c019884f>] sysfs_follow_link+0x4f/0x60
 [<c016b46f>] generic_readlink+0x2f/0x90
 [<c01635b6>] sys_readlink+0x86/0x90
 [<c0103249>] syscall_call+0x7/0xb
Unable to handle kernel paging request at virtual address 00001000
c0198479
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0198479>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210246   (2.6.12-rc1-mm2)
eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: f7c0181c
esi: 00000001   edi: 00001000   ebp: e7519e94   esp: e7519e88
ds: 007b   es: 007b   ss: 0068
Stack: 00000002 e4fdea1c f7c0181c e7519eb8 c0198651 f7c0181c 00000020 f7c0181c
       e7519eb8 c039f820 e4fdea1c f7c0181c e7519edc c0198790 f7c018cc f7c0181c
       e46a3000 f7c018cc e46a3000 fffffff4 e7519f10 e7519ef8 c019884f e4fdea1c
Call Trace:
 [<c010410f>] show_stack+0x7f/0xa0
 [<c01042aa>] show_registers+0x15a/0x1c0
 [<c01044ac>] die+0xfc/0x190
 [<c011450b>] do_page_fault+0x31b/0x670
 [<c0103cf3>] error_code+0x4f/0x54
 [<c0198651>] sysfs_get_target_path+0x21/0x80
 [<c0198790>] sysfs_getlink+0xe0/0x150
 [<c019884f>] sysfs_follow_link+0x4f/0x60
 [<c016b46f>] generic_readlink+0x2f/0x90
 [<c01635b6>] sys_readlink+0x86/0x90
 [<c0103249>] syscall_call+0x7/0xb
Code: 75 f8 c9 c3 8d b4 26 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5
57 56 8b 55 08 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8<f2>
ae f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 5f


>>EIP; c0198479 <object_path_length+19/30>   <=====

>>ecx; ffffffff <__kernel_rt_sigreturn+1bbf/????>
>>edx; f7c0181c <pg0+3773581c/3fb32400>
>>ebp; e7519e94 <pg0+2704de94/3fb32400>
>>esp; e7519e88 <pg0+2704de88/3fb32400>

Trace; c010410f <show_stack+7f/a0>
Trace; c01042aa <show_registers+15a/1c0>
Trace; c01044ac <die+fc/190>
Trace; c011450b <do_page_fault+31b/670>
Trace; c0103cf3 <error_code+4f/54>
Trace; c0198651 <sysfs_get_target_path+21/80>
Trace; c0198790 <sysfs_getlink+e0/150>
Trace; c019884f <sysfs_follow_link+4f/60>
Trace; c016b46f <generic_readlink+2f/90>
Trace; c01635b6 <sys_readlink+86/90>
Trace; c0103249 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c019844e <object_depth+e/20>
00000000 <_EIP>:
Code;  c019844e <object_depth+e/20>
   0:   75 f8                     jne    fffffffa <_EIP+0xfffffffa>
Code;  c0198450 <object_depth+10/20>
   2:   c9                        leave
Code;  c0198451 <object_depth+11/20>
   3:   c3                        ret
Code;  c0198452 <object_depth+12/20>
   4:   8d b4 26 00 00 00 00      lea    0x0(%esi),%esi
Code;  c0198459 <object_depth+19/20>
   b:   8d bc 27 00 00 00 00      lea    0x0(%edi),%edi
Code;  c0198460 <object_path_length+0/30>
  12:   55                        push   %ebp
Code;  c0198461 <object_path_length+1/30>
  13:   89 e5                     mov    %esp,%ebp
Code;  c0198463 <object_path_length+3/30>
  15:   57                        push   %edi
Code;  c0198464 <object_path_length+4/30>
  16:   56                        push   %esi
Code;  c0198465 <object_path_length+5/30>
  17:   8b 55 08                  mov    0x8(%ebp),%edx
Code;  c0198468 <object_path_length+8/30>
  1a:   be 01 00 00 00            mov    $0x1,%esi
Code;  c019846d <object_path_length+d/30>
  1f:   53                        push   %ebx
Code;  c019846e <object_path_length+e/30>
  20:   31 db                     xor    %ebx,%ebx
Code;  c0198470 <object_path_length+10/30>
  22:   8b 3a                     mov    (%edx),%edi
Code;  c0198472 <object_path_length+12/30>
  24:   b9 ff ff ff ff            mov    $0xffffffff,%ecx
Code;  c0198477 <object_path_length+17/30>
  29:   89 d8                     mov    %ebx,%eax

This decode from eip onwards should be reliable

Code;  c0198479 <object_path_length+19/30>
00000000 <_EIP>:
Code;  c0198479 <object_path_length+19/30>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c019847b <object_path_length+1b/30>
   2:   f7 d1                     not    %ecx
Code;  c019847d <object_path_length+1d/30>
   4:   49                        dec    %ecx
Code;  c019847e <object_path_length+1e/30>
   5:   8b 52 24                  mov    0x24(%edx),%edx
Code;  c0198481 <object_path_length+21/30>
   8:   8d 74 31 01               lea    0x1(%ecx,%esi,1),%esi
Code;  c0198485 <object_path_length+25/30>
   c:   85 d2                     test   %edx,%edx
Code;  c0198487 <object_path_length+27/30>
   e:   75 e7                     jne    fffffff7 <_EIP+0xfffffff7>
Code;  c0198489 <object_path_length+29/30>
  10:   5b                        pop    %ebx
Code;  c019848a <object_path_length+2a/30>
  11:   89 f0                     mov    %esi,%eax
Code;  c019848c <object_path_length+2c/30>
  13:   5e                        pop    %esi
Code;  c019848d <object_path_length+2d/30>
  14:   5f                        pop    %edi
