Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbTHLLAs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 07:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269981AbTHLLAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 07:00:48 -0400
Received: from dns2.comtenidos.com ([62.37.225.57]:2224 "EHLO
	smtp.comtenidos.com") by vger.kernel.org with ESMTP id S269133AbTHLLAo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 07:00:44 -0400
Message-ID: <3F38C8CD.1010108@terra.es>
Date: Tue, 12 Aug 2003 13:00:29 +0200
From: Alex Dumont <adumont@terra.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: adumont@uni2.es
Subject: OOPS in 2.4.18: "Unable to handle kernel NULL pointer dereference
 at virtual address 0000007c" (access_process_vm)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I would like to report a Oops we had yesterday on one of our system.

I'm not sure it's the right place to report this. If i'm wrong, i 
apologize in advance.

Otherwise, maybe you could tell me if this has been corrected yet in a 
newer version of the kernel (>2.4.18)

FYI, the OS is RedHad 7.3, running RH kernel 2.4.18-27.7.xsmp .

--[Start of OOPS output]----------------
Unable to handle kernel NULL pointer dereference at virtual address 0000007c
 printing eip:
c01255fd
*pde = 00000000
Oops: 0000
iptable_nat ip_conntrack ipt_TOS iptable_mangle ip_tables autofs smbfs 
nfs lockd sunrpc eepro100 ext3 jbd aacraid megaraid sd_mod scsi_mod
CPU:    0
EIP:    0010:[<c01255fd>]    Not tainted
EFLAGS: 00010202

EIP is at access_process_vm [kernel] 0x2d (2.4.18-27.7.xsmp)
eax: 00000000   ebx: 00000000   ecx: bffffe03   edx: c4d24000
esi: e3a04580   edi: c9ebe000   ebp: c9ebe000   esp: c5ddfef8
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 15112, stackpage=c5ddf000)
Stack: c9ebe166 c9ebe000 00000000 cc9b5c80 00000001 e06b3f00 00000212 
e06b3f00
       c46c5870 00000000 e3a04580 c9ebe000 c9ebe000 c01641e7 c4d24000 
bffffe03
       c9ebe000 00000029 00000000 00000029 e5392180 000007ff c4d24000 
c9ebe000
Call Trace: [<c01641e7>] proc_pid_cmdline [kernel] 0x67 (0xc5ddff2c))
[<c016454c>] proc_info_read [kernel] 0x4c (0xc5ddff58))
[<c0144567>] fput [kernel] 0xc7 (0xc5ddff64))
[<c01435a6>] sys_read [kernel] 0x96 (0xc5ddff7c))
[<c0142f37>] sys_open [kernel] 0x57 (0xc5ddffac))
[<c0108ca3>] system_call [kernel] 0x33 (0xc5ddffc0))


Code: f6 40 7c 01 74 07 3d a0 1d 30 c0 75 08 c7 44 24 08 00 00 00
--[End of OOPS output]----------------

I feeded ksymoops (on teh same system) with the text of the OOPS:

--[Start of ksymoops output]----------------
[root@m3lnxsva03 admin]# ksymoops
ksymoops 2.4.4 on i686 2.4.18-27.7.xsmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-27.7.xsmp/ (default)
     -m /boot/System.map-2.4.18-27.7.xsmp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/aacraid.o) for aacraid
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/megaraid.o) for megaraid
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
ksymoops: No such file or directory
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
ksymoops: No such file or directory
/usr/bin/find: /lib/modules/2.4.18-27.7.xsmp/build: No such file or 
directory
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a 
unique module object.  Trace may not be reliable.
Warning (map_ksym_to_module): cannot match loaded module aacraid to a 
unique module object.  Trace may not be reliable.
Reading Oops report from the terminal
Unable to handle kernel NULL pointer dereference at virtual address 0000007c
c01255fd
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01255fd>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
ds: 0018   es: 0018   ss: 0018
Process ps (pid: 15112, stackpage=c5ddf000)
Stack: c9ebe166 c9ebe000 00000000 cc9b5c80 00000001 e06b3f00 00000212 
e06b3f00
       c46c5870 00000000 e3a04580 c9ebe000 c9ebe000 c01641e7 c4d24000 
bffffe03
       c9ebe000 00000029 00000000 00000029 e5392180 000007ff c4d24000 
c9ebe000
Call Trace: [<c01641e7>] proc_pid_cmdline [kernel] 0x67 (0xc5ddff2c))
[<c016454c>] proc_info_read [kernel] 0x4c (0xc5ddff58))
[<c0144567>] fput [kernel] 0xc7 (0xc5ddff64))
[<c01435a6>] sys_read [kernel] 0x96 (0xc5ddff7c))
[<c0142f37>] sys_open [kernel] 0x57 (0xc5ddffac))
[<c0108ca3>] system_call [kernel] 0x33 (0xc5ddffc0))
Code: f6 40 7c 01 74 07 3d a0 1d 30 c0 75 08 c7 44 24 08 00 00 00

 >>EIP; c01255fd <access_process_vm+2d/1f0>   <=====
Trace; c01641e7 <proc_pid_cmdline+67/f0>
Trace; c016454c <proc_info_read+4c/100>
Trace; c0144567 <fput+c7/f0>
Trace; c01435a6 <sys_read+96/110>
Trace; c0142f37 <sys_open+57/a0>
Trace; c0108ca3 <system_call+33/38>
Code;  c01255fd <access_process_vm+2d/1f0>
00000000 <_EIP>:
Code;  c01255fd <access_process_vm+2d/1f0>   <=====
   0:   f6 40 7c 01               testb  $0x1,0x7c(%eax)   <=====
Code;  c0125601 <access_process_vm+31/1f0>
   4:   74 07                     je     d <_EIP+0xd> c012560a 
<access_process_vm+3a/1f0>
Code;  c0125603 <access_process_vm+33/1f0>
   6:   3d a0 1d 30 c0            cmp    $0xc0301da0,%eax
Code;  c0125608 <access_process_vm+38/1f0>
   b:   75 08                     jne    15 <_EIP+0x15> c0125612 
<access_process_vm+42/1f0>
Code;  c012560a <access_process_vm+3a/1f0>
   d:   c7 44 24 08 00 00 00      movl   $0x0,0x8(%esp,1)
Code;  c0125611 <access_process_vm+41/1f0>
  14:   00


3 warnings and 7 errors issued.  Results may not be reliable.
--[End of ksymoops output]----------------

Should you need it, don't hesitate to ask me more information about the 
system. In particular i have captured the output of the "Magig-SysRq 
T,P,M (ShowTasks, ShowPc, ShowMem)".

Could you please CC to adumont@uni2.es any answer to this mail (as i'm 
not suscribed to the list).

I'll like to thank you in advance for the time you dedicated reading 
this mail, and for your help.

Best Regards,

Alex Dumont


