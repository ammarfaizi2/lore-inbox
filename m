Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129601AbQKXUhb>; Fri, 24 Nov 2000 15:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQKXUhV>; Fri, 24 Nov 2000 15:37:21 -0500
Received: from pandora.worldonline.nl ([195.241.48.140]:59532 "HELO
        pandora.worldonline.nl") by vger.kernel.org with SMTP
        id <S129601AbQKXUhG>; Fri, 24 Nov 2000 15:37:06 -0500
Date: Thu, 23 Nov 2000 22:45:09 +0100
From: Wouter Verheijen <wouter.verheijen@worldmail.nl>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel oops at bootup (2.2.17, Mandrake 7.2)
Message-ID: <20001123224509.A1607@wouter.verheijen.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I just bought Linux Mandrake 7.2. The problem described applies to (at
least) the kernel used to boot the installation.
It OCCURS just after the detection of the buses and harddisks:
	hda: ....
	hdc: ....
	hdd: ....
	Unable to handle kernel NULL pointer dereference at virtual address 00000014
[see attached OOPS-TRACE, not absolutely sure this kernel matches this
System.map.]

Kernel version: 2.2.17
Kernel 2.2.14, 2.0, and 2.4-pre7 are known to WORK on my machine. I am
not sure if something was BROKEN in this specific release, or because
of certain options customized by Mandrake (for the installation)?

SYSTEM DESCRIPTION:
 Intel Pentium 133
 Host bridge: VIA Technologies VT 82C585 Apollo VP1/VPX (rev 2)
 48MB RAM
 NE2000 ethernet adapter
I also tried with BIOS safe options (e.g. no power management)

I hope you can point me out where to look for the problem. If you need
more information, please contact me.

Best regards,
-- 
Wouter Verheijen
wouter.verheijen@worldmail.nl


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpuinfo

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 2
model name	: Pentium 75 - 200
stepping	: 6
cpu MHz		: 132.875605
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8
bogomips	: 53.04


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=oopstrace

ksymoops 0.7c on i586 2.2.14-15mdk.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m /boot/System.map-2.2.17-21mdk (specified)

Unable to handle kernel NULL pointer dereference at virtual address 00000014
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0108c59>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000000   ebx: 00000202     ecx: fffffff4       edx: fffffe80
esi: 00000004   edi: c02404d8     ebp: c0240498       esp: e2f19ee8
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 1, process nr: 1, stackpage=c2f19000)
Stack:  c0108c73 fffffff4 0000600a c016c67c fffffff4 0000004b 00000008 c01eea40
               c02404d8 00000000 00000039 00000053 00000001 08181e23 c0181e45 c02404d8
               00000008 c02404d8 00000000 c0240498 00000246 00000021 0053cfd8 c2f152e0
Call Trace: [<c0108c7>] [<c016c67c>] [<c0181e45>] [<c0181ff1>] [<c017d504>] [c017ddbf>] [<c0106000>]
        [<c010600>] [<c010615e>] [<c01065f3>]
Code: 8b 40 14 ff d0 83 c4 04 53 9d 5b c3 8d 76 00 53 8b 5c 24 08

>>EIP; c0108c59 <copy_segments+45/98>   <=====
Trace; 0c0108c7 Before first symbol
Trace; c016c67c <tcp_make_synack+100/334>
Trace; c0181e45 <drive_is_flashcard+b5/128>
Trace; c0181ff1 <ide_output_data+29/88>
Trace; c017d504 <unix_dgram_recvmsg+10c/154>
Trace; 0c010600 Before first symbol
Trace; c010615e <do_linuxrc+c6/d4>
Trace; c01065f3 <amd_get_mtrr+17/68>
Code;  c0108c59 <copy_segments+45/98>
00000000 <_EIP>:
Code;  c0108c59 <copy_segments+45/98>   <=====
   0:   8b 40 14                  mov    0x14(%eax),%eax   <=====
Code;  c0108c5c <copy_segments+48/98>
   3:   ff d0                     call   *%eax
Code;  c0108c5e <copy_segments+4a/98>
   5:   83 c4 04                  add    $0x4,%esp
Code;  c0108c61 <copy_segments+4d/98>
   8:   53                        push   %ebx
Code;  c0108c62 <copy_segments+4e/98>
   9:   9d                        popf   
Code;  c0108c63 <copy_segments+4f/98>
   a:   5b                        pop    %ebx
Code;  c0108c64 <copy_segments+50/98>
   b:   c3                        ret    
Code;  c0108c65 <copy_segments+51/98>
   c:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c0108c68 <copy_segments+54/98>
   f:   53                        push   %ebx
Code;  c0108c69 <copy_segments+55/98>
  10:   8b 5c 24 08               mov    0x8(%esp,1),%ebx


--9jxsPFA5p3P2qPhR--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
