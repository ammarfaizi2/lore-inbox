Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129908AbQKVBgx>; Tue, 21 Nov 2000 20:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130022AbQKVBgn>; Tue, 21 Nov 2000 20:36:43 -0500
Received: from p3EE3C754.dip.t-dialin.net ([62.227.199.84]:45316 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129908AbQKVBg1> convert rfc822-to-8bit; Tue, 21 Nov 2000 20:36:27 -0500
Date: Wed, 22 Nov 2000 02:06:18 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: [2.2.17] oops in /proc/scsi/scsi
Message-ID: <20001122020618.A1411@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing around with Kurt Garloff's rescan-scsi-bus.sh, more
precisely, I moved an entire bus from my Tekram DC-390U (with sym53c8xx
driver) to my Tekram DC-390 (with tmscsim driver). Then, I ran that
script which effectively sends a lot of stuff to /proc/scsi/scsi (scsi
add-single-device).

I ran that script several times since it did not collect all devices,
and at one time, I got two oopsen that I decoded.

The script is available at: http://www.garloff.de/kurt/linux/

The Kernel is a patched 2.2.17, but I think it has no SCSI-related
patches apart from an updated (2.0e3) tmscsim driver. Here's the full patch
list:

* ide.2.2.17.all.20000904
* i²c 2.5.4
* lm_sensors 2.5.4
* dc390 2.0e3
* serial 5.05
* NFSv3: linux-2.2.17-nfsv3-0.23.1.dif dhiggen-over-0.23.1 restore_rsize
* ReiserFS v3.5.27

These are the oopses:

ksymoops 2.3.5 on i586 2.2.17ma3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.17ma3/ (default)
     -m /boot/System.map-2.2.17ma3 (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel NULL pointer dereference at virtual address 00000052
current->tss.cr3 = 05463000, %%cr3 = 05463000
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[sr_finish+112/388]
EFLAGS: 00010206
eax: 00000000   ebx: 00000054   ecx: 00000005   edx: c7f9cc00
esi: c267bd50   edi: c7f9cc40   ebp: 00000001   esp: c267bd3c
ds: 0018   es: 0018   ss: 0018
Process rescan-scsi-bus (pid: 18301, process nr: 122, stackpage=c267b000)
Stack: 00000000 c7e3c000 c02a9980 c267bd4c 00307273 c01fedaf c33a0820 00000008 
c010a058 c01fedf3 00000000 00000000 c7e3c000 00000001 c5902140 c02caee0 
c5902148 c0132793 c5902140 c267bda4 c267bda4 c0001a00 00020000 c5780280 
Call Trace: [scan_scsis+491/1076] [common_interrupt+24/32] [scan_scsis+559/1076] [get_new_inode+147/312] [vsprintf+720/764] [wake_up_process+64/76] [__wake_up+59/68] 
Code: 80 48 52 20 a1 ac 99 2a c0 80 4c 18 16 08 a1 ac 99 2a c0 80 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   80 48 52 20               orb    $0x20,0x52(%eax)
Code;  00000004 Before first symbol
   4:   a1 ac 99 2a c0            mov    0xc02a99ac,%eax
Code;  00000009 Before first symbol
   9:   80 4c 18 16 08            orb    $0x8,0x16(%eax,%ebx,1)
Code;  0000000e Before first symbol
   e:   a1 ac 99 2a c0            mov    0xc02a99ac,%eax
Code;  00000013 Before first symbol
  13:   80 00 00                  addb   $0x0,(%eax)

Unable to handle kernel NULL pointer dereference at virtual address 00000032
current->tss.cr3 = 02394000, %%cr3 = 02394000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[proc_print_scsidevice+35/504]
EFLAGS: 00010246
eax: 00000000   ebx: c2577d40   ecx: c154f328   edx: c2577d40
esi: 00000329   edi: c7e3c000   ebp: c154f000   esp: c0551e78
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 18466, process nr: 140, stackpage=c0551000)
Stack: 00000000 00000002 00000000 c2577d40 00000329 c7e3c000 c154f000 c154f000 
c0271d8a c33a086a c33a0852 c4ae0ac0 00000212 c1f564c0 c0200e21 c2577d40 
c154f000 c0551ef0 00000329 c11462a0 00000100 00000000 00000c00 c1f56380 
Call Trace: [scsi_device_types+3946/5792] [scsi_proc_info+121/1876] [do_anonymous_page+45/128] [do_no_page+54/212] [dispatch_scsi_info+64/188] [proc_readscsi+150/268] [proc_readscsi+45/268] 
Code: 66 8b 40 32 25 ff ff 00 00 50 68 20 5c 27 c0 8b 5c 24 50 03 

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   66 8b 40 32               mov    0x32(%eax),%ax
Code;  00000004 Before first symbol
   4:   25 ff ff 00 00            and    $0xffff,%eax
Code;  00000009 Before first symbol
   9:   50                        push   %eax
Code;  0000000a Before first symbol
   a:   68 20 5c 27 c0            push   $0xc0275c20
Code;  0000000f Before first symbol
   f:   8b 5c 24 50               mov    0x50(%esp,1),%ebx
Code;  00000013 Before first symbol
  13:   03 00                     add    (%eax),%eax


1 warning issued.  Results may not be reliable.

-- 
Matthias Andree
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
