Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLKXKq>; Mon, 11 Dec 2000 18:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130155AbQLKXKg>; Mon, 11 Dec 2000 18:10:36 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:43277 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S129906AbQLKXK0>; Mon, 11 Dec 2000 18:10:26 -0500
Date: Mon, 11 Dec 2000 22:39:53 +0000 (GMT)
From: Tim <tim@parrswood.manchester.sch.uk>
To: linux-kernel@vger.kernel.org
Subject: Oops in test11, test11-ac4 and test12-pre4/7 - Repost with correct
 decode
Message-ID: <Pine.LNX.4.21.0012112233120.8330-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As Keith Owens pointed out klogd mangled the decode, I haev run it through
ksymoops and got the following decode:

ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map (specified)

Unable to handle kernel paging request at virtual address d0892597
c022a366
*pde = 0ff1c063
Oops: 0000
CPU:    1
EIP:    0010:[<c022a366>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010297
eax: d0892597   ebx: ffffffff   ecx: d0892597   edx: fffffffe
esi: ffffffff   edi: c7f4a2f1   ebp: c700bee8   esp: c700be9c
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 1275, stackpage=c700b000)
Stack: d0892597 c7f4a2e3 c7b0caa0 00000006 0000004e c023ef73 00000000 00000000
       0000000a c022a568 c7f4a2e3 c023ef73 c700bedc c011e5dd c7f4a2e3 c023ef62
       0000e010 0000e01f d0892597 c147f614 c7f4a2e3 c147f454 00000008 c011e5fe
Call Trace: [<d0892597>] [<c023ef73>] [<c022a568>] [<c023ef73>]
[<c011e5dd>] [<c       [<c011e5fe>] [<c023ef5c>] [<c011e654>] [<c023ef5c>]
[<c015185c>] [<c014f3Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8 89 c6
8b 44 24 1c
>>EIP; c022a366 <vsprintf+1ee/3dc>   <=====
Trace; d0892597 <END_OF_CODE+9ae8/????>
Trace; c023ef73 <call_spurious_interrupt+8383/8b64>
Trace; c022a568 <sprintf+14/1c>
Trace; c023ef73 <call_spurious_interrupt+8383/8b64>
Trace; c011e5dd <do_resource_list+4d/84>
Trace; c023ef62 <call_spurious_interrupt+8372/8b64>
Trace; d0892597 <END_OF_CODE+9ae8/????>
Trace; c011e5fe <do_resource_list+6e/84>
Trace; c023ef5c <call_spurious_interrupt+836c/8b64>
Trace; c011e654 <get_resource_list+40/50>
Trace; c023ef5c <call_spurious_interrupt+836c/8b64>
Trace; c015185c <ioports_read_proc+24/3c>
Trace; c014f32f <proc_file_read+f7/1d0>
Trace; c0132346 <sys_read+92/c8>
Trace; c010a72b <system_call+33/38>
Code;  c022a366 <vsprintf+1ee/3dc>
00000000 <_EIP>:
Code;  c022a366 <vsprintf+1ee/3dc>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c022a369 <vsprintf+1f1/3dc>
   3:   74 07                     je     c <_EIP+0xc> c022a372
<vsprintf+1fa/3dcCode;  c022a36b <vsprintf+1f3/3dc>
   5:   40                        inc    %eax
Code;  c022a36c <vsprintf+1f4/3dc>
   6:   4a                        dec    %edx
Code;  c022a36d <vsprintf+1f5/3dc>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c022a370 <vsprintf+1f8/3dc>
   a:   75 f4                     jne    0 <_EIP>
Code;  c022a372 <vsprintf+1fa/3dc>
   c:   29 c8                     sub    %ecx,%eax
Code;  c022a374 <vsprintf+1fc/3dc>
   e:   89 c6                     mov    %eax,%esi
Code;  c022a376 <vsprintf+1fe/3dc>
  10:   8b 44 24 1c               mov    0x1c(%esp,1),%eax

Also this is the relivent part of /proc/ioports before installing the
modules:
0cf8-0cff: PCI conf1
4000-403f: Intel Corporation 82371AB PIIX4 ACPI
5000-501f: Intel Corporation 82371AB PIIX4 ACPI
c000-cfff: PCI Bus #01
d000-d01f: Intel Corporation 82371AB PIIX4 USB
  d000-d01f : usb-uhci
d400-d47f: Digital Equipment Corporation DECchip 21142/43
  d400-d47f : eth0
d800-d81f: Creative Labs SB Live! EMU10000
  d800-d81f : EMU10K1
dc00-dc07: Creative Labs SB Live!
e000-e07f: American Megatrends Inc. MegaRAID
f000-f00f: Intel Corporation 82371AB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1


-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X   
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

"A computer lets you make more mistakes faster than any invention
in human history - with the possible exceptions of handguns and tequila."
          -Mitch Ratliffe, Technology Review April, 1992

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
