Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRKFEeG>; Mon, 5 Nov 2001 23:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281456AbRKFEd5>; Mon, 5 Nov 2001 23:33:57 -0500
Received: from [202.73.165.30] ([202.73.165.30]:384 "EHLO
	maravillo.q-linux.com") by vger.kernel.org with ESMTP
	id <S281450AbRKFEdi>; Mon, 5 Nov 2001 23:33:38 -0500
Date: Tue, 6 Nov 2001 12:31:37 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Cc: mike.maravillo@q-linux.com
Subject: Re: 2.4.13-ac6: videodev/__release_region oops!
Message-ID: <20011106123137.A1254@maravillo.q-linux.com>
In-Reply-To: <20011106045014.A1361@maravillo.q-linux.com> <13664.1005011063@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <13664.1005011063@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Tue, Nov 06, 2001 at 12:44:23PM +1100
Organization: Q Linux Solutions, Inc.
X-Accepted-File-Formats: ASCII .rtf .ps - *NO* MS Office files please
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointers Keith!  Here's my second shot at it...

ksymoops 2.4.1 on i586 2.4.13-ac6.  Options used
     -V (default)
     -k /var/log/ksymoops/20011106121445.ksyms (specified)
     -l /var/log/ksymoops/20011106121445.modules (specified)
     -o /lib/modules/2.4.13-ac6/ (default)
     -m /boot/System.map-2.4.13-ac6 (default)

Warning (compare_maps): mismatch on symbol proc_scsi  , scsi_mod says d00fc9e4, /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o says d00fc448.  Ignoring /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_devicelist  , scsi_mod says d00fca10, /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o says d00fc474.  Ignoring /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hostlist  , scsi_mod says d00fca0c, /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o says d00fc470.  Ignoring /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol scsi_hosts  , scsi_mod says d00fca14, /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o says d00fc478.  Ignoring /lib/modules/2.4.13-ac6/kernel/drivers/scsi/scsi_mod.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says d001a8e0, /lib/modules/2.4.13-ac6/kernel/drivers/md/md.o says d001a700.  Ignoring /lib/modules/2.4.13-ac6/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says d001a0e0, /lib/modules/2.4.13-ac6/kernel/drivers/md/md.o says d0019f00.  Ignoring /lib/modules/2.4.13-ac6/kernel/drivers/md/md.o entry
Unable to handle kernel paging request at virtual address 05c80741
c0118012
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0118012>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 09b20b27   ebx: c0002014   ecx: 105e11e6   edx: 05c8073d
esi: ec000fff   edi: ec000000   ebp: cb98f000   esp: cb6f5f50
ds: 0018   es: 0018   ss: 0018
Process rmmod (pid: 1129, stackpage=cb6f5000)
Stack: d0130000 00001000 c1430800 d0129062 c0239ff8 ec000000 00001000 02430800 
       c1430800 d012dae0 00000000 c01b663e c1430800 d0123000 cb98f000 d012949a 
       d012dae0 c011589e d0123000 cb98f000 00000000 c0114cfc d0123000 00000000 
Call Trace: [<d0130000>] [<d0129062>] [<d012dae0>] [<c01b663e>] [<d012949a>] 
   [<d012dae0>] [<c011589e>] [<c0114cfc>] [<c0106dd3>] 
Code: 8b 42 04 39 f8 77 f0 8b 4a 08 39 f1 72 e9 83 7a 0c 00 78 05 

>>EIP; c0118012 <__release_region+22/70>   <=====
Trace; d0130000 <[bttv]__ksymtab_bttv_write_gpio+0/8>
Trace; d0129062 <[bttv]bttv_remove+1e2/210>
Trace; d012dae0 <[bttv]bttv_pci_driver+0/40>
Trace; c01b663e <pci_unregister_driver+2e/50>
Trace; d012949a <[bttv]cleanup_module+a/10>
Trace; d012dae0 <[bttv]bttv_pci_driver+0/40>
Trace; c011589e <free_module+1e/b0>
Trace; c0114cfc <sys_delete_module+11c/1e0>
Trace; c0106dd3 <system_call+33/40>
Code;  c0118012 <__release_region+22/70>
00000000 <_EIP>:
Code;  c0118012 <__release_region+22/70>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  c0118015 <__release_region+25/70>
   3:   39 f8                     cmp    %edi,%eax
Code;  c0118017 <__release_region+27/70>
   5:   77 f0                     ja     fffffff7 <_EIP+0xfffffff7> c0118009 <__release_region+19/70>
Code;  c0118019 <__release_region+29/70>
   7:   8b 4a 08                  mov    0x8(%edx),%ecx
Code;  c011801c <__release_region+2c/70>
   a:   39 f1                     cmp    %esi,%ecx
Code;  c011801e <__release_region+2e/70>
   c:   72 e9                     jb     fffffff7 <_EIP+0xfffffff7> c0118009 <__release_region+19/70>
Code;  c0118020 <__release_region+30/70>
   e:   83 7a 0c 00               cmpl   $0x0,0xc(%edx)
Code;  c0118024 <__release_region+34/70>
  12:   78 05                     js     19 <_EIP+0x19> c011802b <__release_region+3b/70>


6 warnings issued.  Results may not be reliable.

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
