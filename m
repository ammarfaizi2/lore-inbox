Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRAQVsR>; Wed, 17 Jan 2001 16:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129745AbRAQVsH>; Wed, 17 Jan 2001 16:48:07 -0500
Received: from jane.hollins.EDU ([192.160.94.78]:53002 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S129664AbRAQVsB>;
	Wed, 17 Jan 2001 16:48:01 -0500
Message-ID: <3A66130E.8010004@hollins.edu>
Date: Wed, 17 Jan 2001 16:47:58 -0500
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-pre8 i686; en-US; m18) Gecko/20010116
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in 2.4.1-pre8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've got a Dell Precision 420 (dual P3/800 w/1gb RDRAM).

I'm consistently getting an oops when accessing any smbfs mount whether 
running 'ls' inside the smbfs mount or hitting TAB for filename 
completion of a directory in an smbfs mount.  I have another machine 
(dual P2/300 w/320MB memory) that does not have this problem.  The P2 
has an eepro100 ethernet card whereas the Dell has the built-in 3c920 
(3c905c emulation).

Below is the ksymoops output.  The oops screen I manually typed onto my 
other computer because the /var/log/messages file gets corrupted when 
this occurs and I don't know how to save the oops screen on the computer 
itself.  SAR-S, SAR-U say they're doing to do their action but do not 
actually sync or remount the disks.  CAD does not reboot the computer. 
SAR-B does reboot the machine though.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
c012b2fb
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012b2fb>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000001   ebx: 00000000   ecx: c02ea430   edx: 0003ff9e
esi: c2093878   edi: 00000000   ebp: f7e00004   esp: f73b3e18
ds: 0018   es: 0018   ss: 0018
Process ls (pid: 862, stackpage=f73b3000)
Stack: c02ea430 c02ea690 f73b3e4c 00000000 c2093878 f7e00004 f73b3e4c 
00000001
      c012e829 c2093878 00000000 00000001 f7300004 c2093878 c019344a 
f7918e9c
      c0000000 00000012 00000000 fe1ec014 0000001a 00000012 c019218b 
00000000
Call Trace: [<c012e829>] [<c019344a>] [<c019218b>] [<f8957a20>] 
[<f8959188>] [<c018fde6>] [<f8959048>]
      [<f895903c>] [<c0191364>] [<c0192259>] [<c0191569>] [<c014e338>] 
[<c014e140>] [<c0109113>]
Code: 8b 07 ff 47 18 89 70 04 89 06 89 7e 04 89 37 89 7e 08 8b 55

 >>EIP; c012b2fb <add_to_page_cache_unique+bb/120>   <=====
Trace; c012e829 <grab_cache_page+79/a0>
Trace; c019344a <smb_trans2_request+18a/1f0>
Trace; c019218b <smb_add_to_cache+fb/180>
Trace; f8957a20 <__module_using_checksums+3b52/???
Trace; f8959188 <__module_using_checksums+52ba/???
Trace; c018fde6 <smb_proc_readdir_long+456/4d0>
Trace; f8959048 <__module_using_checksums+517a/???
Trace; f895903c <__module_using_checksums+516e/???
Trace; c0191364 <smb_proc_readdir+24/40>
Trace; c0192259 <smb_refill_dircache+29/70>
Trace; c0191569 <smb_readdir+d9/190>
Trace; c014e338 <sys_getdents64+b8/170>
Trace; c014e140 <filldir64+0/140>
Trace; c0109113 <system_call+33/38>
Code;  c012b2fb <add_to_page_cache_unique+bb/120>
00000000 <_EIP>:
Code;  c012b2fb <add_to_page_cache_unique+bb/120>   <=====
  0:   8b 07                     mov    (%edi),%eax   <=====
Code;  c012b2fd <add_to_page_cache_unique+bd/120>
  2:   ff 47 18                  incl   0x18(%edi)
Code;  c012b300 <add_to_page_cache_unique+c0/120>
  5:   89 70 04                  mov    %esi,0x4(%eax)
Code;  c012b303 <add_to_page_cache_unique+c3/120>
  8:   89 06                     mov    %eax,(%esi)
Code;  c012b305 <add_to_page_cache_unique+c5/120>
  a:   89 7e 04                  mov    %edi,0x4(%esi)
Code;  c012b308 <add_to_page_cache_unique+c8/120>
  d:   89 37                     mov    %esi,(%edi)
Code;  c012b30a <add_to_page_cache_unique+ca/120>
  f:   89 7e 08                  mov    %edi,0x8(%esi)
Code;  c012b30d <add_to_page_cache_unique+cd/120>
  12:   8b 55 00                  mov    0x0(%ebp),%edx

Ethernet is compiled into the kernel as is smbfs (not as modules).  I've 
compiled this kernel with 4GB bigmem support (otherwise I only get 8xxMB 
total).

If anyone needs more please let me know.

--Scott

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
