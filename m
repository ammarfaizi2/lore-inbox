Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129248AbQLDXCd>; Mon, 4 Dec 2000 18:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129257AbQLDXCW>; Mon, 4 Dec 2000 18:02:22 -0500
Received: from magic.adaptec.com ([208.236.45.80]:33959 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S129248AbQLDXCQ>; Mon, 4 Dec 2000 18:02:16 -0500
Message-ID: <E9EF680C48EAD311BDF400C04FA07B612D4D71@ntcexc02.ntc.adaptec.com>
From: "Boerner, Brian" <Brian_Boerner@adaptec.com>
To: "'linux-kernel@vger.redhat.com'" <linux-kernel@vger.kernel.org>
Subject: aacraid for 2.4.0
Date: Mon, 4 Dec 2000 17:31:04 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of you, specifically customers of Dell Computer have been asking about
the aacraid driver and the 2.4.0 kernel. Development is underway, however I
have run into a stumbling block and am not sure how to proceed. The driver
is generating a segmentation fault and produces and oops. I have included
that for your viewing pleasure. From the output of ksymoops, it appears to
be dying in AAC_AnnounceDriver. This plagues me because this function only
does two things. One is print the name of the driver and the date it was
built on. The other is call schedule(). Does anyone know why calling
schedule in the 2.4.x stream would cause me heartache? I've put in a bunch
of prints to see if I get past the announce routine, but I do not. Any ideas
or pointers from more experienced 2.4 porters is greatly appreciated. I'm
really cutting it down to the wire now. :-)

-bmb-


enomem.ntc.adaptec.com:bmb% more output.txt 
ksymoops 2.3.5 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m ./linux-2.4.0-test11/System.map (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000025
c881c054
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c881c054>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 00000025   ebx: c881c000   ecx: 00000000   edx: 00000000
esi: 00000001   edi: 00000000   ebp: c88296a0   esp: c6b51e74
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 711, stackpage=c6b51000)
Stack: c881c07e 00000001 c8822c00 c6bb6da0 c6bb66a0 c7f57260 00000000
c6b10150 
       c0120899 c6bb66a0 0000000c 00000000 c6bb66a0 080545a0 ffffffff
00000000 
       c01a8bf8 c88296a0 00000000 080545a0 00000000 c6b10150 00000014
c0123180 
Call Trace: [<c881c07e>] [<c8822c00>] [<c0120899>] [<c01a8bf8>] [<c88296a0>]
[<c0123180>] [<c012345
1>] 
       [<c881c000>] [<c881cb85>] [<c88296a0>] [<c88296a0>] [<c881c000>]
[<c0118c65>] [<c881c060>] [
<c0108f77>] 
Code: 00 00 00 00 00 00 00 00 b8 00 00 00 83 ec 34 68 00 2c 82 c8 

>>EIP; c881c054 <[aacraid]AAC_AnnounceDriver+0/8>   <=====
Trace; c881c07e <[aacraid]AAC_DetectHostAdapter+22/3d8>
Trace; c8822c00 <[aacraid].rodata.start+440/32fc>
Trace; c0120899 <do_no_page+49/a0>
Trace; c01a8bf8 <scsi_register_host+48/2d0>
Trace; c88296a0 <[aacraid]driver_template+0/6c>
Trace; c0123180 <do_generic_file_read+250/530>
Trace; c0123451 <do_generic_file_read+521/530>
Trace; c881c000 <_end+852054c/85205a0>
Trace; c881cb85 <[aacraid]init_this_scsi_driver+19/44>
Trace; c88296a0 <[aacraid]driver_template+0/6c>
Trace; c88296a0 <[aacraid]driver_template+0/6c>
Trace; c881c000 <_end+852054c/85205a0>
Trace; c0118c65 <sys_init_module+515/5d0>
Trace; c881c060 <[aacraid]AAC_DetectHostAdapter+4/3d8>
Trace; c0108f77 <system_call+33/38>
Code;  c881c054 <[aacraid]AAC_AnnounceDriver+0/8>   <=====
00000000 <_EIP>:   <=====
Code;  c881c05c <[aacraid]AAC_DetectHostAdapter+0/3d8>
   8:   b8 00 00 00 83            mov    $0x83000000,%eax
Code;  c881c061 <[aacraid]AAC_DetectHostAdapter+5/3d8>
   d:   ec                        in     (%dx),%al
Code;  c881c062 <[aacraid]AAC_DetectHostAdapter+6/3d8>
   e:   34 68                     xor    $0x68,%al
Code;  c881c064 <[aacraid]AAC_DetectHostAdapter+8/3d8>
  10:   00 2c 82                  add    %ch,(%edx,%eax,4)
Code;  c881c067 <[aacraid]AAC_DetectHostAdapter+b/3d8>
  13:   c8 00 00 00               enter  $0x0,$0x0

enomem.ntc.adaptec.com:bmb% 
Brian M. Boerner
System Software Developer
Adaptec, Inc.
Nashua, NH 03060
(603) 579-4625


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
