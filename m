Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSGETuf>; Fri, 5 Jul 2002 15:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317549AbSGETue>; Fri, 5 Jul 2002 15:50:34 -0400
Received: from [213.4.129.129] ([213.4.129.129]:23408 "EHLO tsmtp7.mail.isp")
	by vger.kernel.org with ESMTP id <S317547AbSGETub>;
	Fri, 5 Jul 2002 15:50:31 -0400
Date: Fri, 5 Jul 2002 17:08:23 +0200
From: Diego Calleja <diegocg@teleline.es>
To: linux-kernel@vger.kernel.org
Cc: xfree86@xfree86.org, jwz@netscape.org, vizzie@airmail.net
Subject: XFree + "stonerview" screensaver -> Xfree oops
Message-Id: <20020705170823.1b5551c7.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Fri__5_Jul_2002_17:08:23_+0200_081e9e20"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Fri__5_Jul_2002_17:08:23_+0200_081e9e20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I'm using the Xfree version existing in unstable debian (4.1.0-16), X
-version shows 4.1.0.1.

This bug is reproducible between several trees: stable, -ac, -aa1 from
several releases.

Output of lspci -v attached (voodoo 3 pci video board)

I can reproduce the bug (not always but very usual):
-I don't touch anything.
-xscreensaver-gl starts
-_only_, when the screensaver called "stonerview" starts, and after a
while, the image stops, and an oops is generated:

-----------------------------------------------------------------------
---------- ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /boot/System.map-2.4.19-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul  5 16:33:36 localhost kernel: Unable to handle kernel NULL pointer
dereference at virtual address 0000001c Jul  5 16:33:36 localhost
kernel: c01b41aa Jul  5 16:33:36 localhost kernel: *pde = 00a63067
Jul  5 16:33:36 localhost kernel: Oops: 0000
Jul  5 16:33:36 localhost kernel: CPU:    0
Jul  5 16:33:36 localhost kernel: EIP:    0010:[sock_poll+30/40]    Not
tainted Jul  5 16:33:36 localhost kernel: EFLAGS: 00210282
Jul  5 16:33:36 localhost kernel: eax: 00000000   ebx: c0b4db20   ecx:
00000000   edx: c1bd35b4 Jul  5 16:33:36 localhost kernel: esi: c0b4db20
  edi: 00000000   ebp: c1845f70   esp: c1845f28 Jul  5 16:33:36
localhost kernel: ds: 0018   es: 0018   ss: 0018 Jul  5 16:33:36
localhost kernel: Process XFree86 (pid: 310, stackpage=c1845000) Jul  5
16:33:36 localhost kernel: Stack: c0b4db20 c1bd35b4 00000000 00000000
c013e1d6 c0b4db20 00000000 00000100 Jul  5 16:33:36 localhost kernel:   
    00000020 c11fff20 00000145 00080000 c1844000 7fffffff 00000013
00000000 Jul  5 16:33:36 localhost kernel:        00000000 c149d000
00000000 c013e62c 00000017 c1845fa8 c1845fa4 c1844000 Jul  5 16:33:36
localhost kernel: Call Trace: [do_select+226/476] [sys_select+820/1156]
[system_call+51/64] Jul  5 16:33:36 localhost kernel: Code: 8b 40 1c ff
d0 83 c4 0c 5b c3 53 8b 5c 24 08 8b 43 08 8b 54 Using defaults from
ksymoops -t elf32-i386 -a i386


>>ebx; c0b4db20 <[apm].bss.end+137801/2cdce1>
>>edx; c1bd35b4 <[sb].bss.end+9ab8d5/bf0321>
>>esi; c0b4db20 <[apm].bss.end+137801/2cdce1>
>>ebp; c1845f70 <[sb].bss.end+61e291/bf0321>
>>esp; c1845f28 <[sb].bss.end+61e249/bf0321>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  00000003 Before first symbol
   3:   ff d0                     call   *%eax
Code;  00000005 Before first symbol
   5:   83 c4 0c                  add    $0xc,%esp
Code;  00000008 Before first symbol
   8:   5b                        pop    %ebx
Code;  00000009 Before first symbol
   9:   c3                        ret    
Code;  0000000a Before first symbol
   a:   53                        push   %ebx
Code;  0000000b Before first symbol
   b:   8b 5c 24 08               mov    0x8(%esp,1),%ebx
Code;  0000000f Before first symbol
   f:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  00000012 Before first symbol
  12:   8b 54 00 00               mov    0x0(%eax,%eax,1),%edx


1 warning issued.  Results may not be reliable.

-----------------------------------------------------------------------
----------

-When i watch the stopped screen, the image _always_ is the same, the
screensaver always stops at the same point Any advices of how to
debug/strace/whatever this?

(after Xfree is hanged, ctrl+alt+Fn does'nt works, so i do sysrq sync +
reboot, but this is normal...)


Regards, Diego Calleja


--Multipart_Fri__5_Jul_2002_17:08:23_+0200_081e9e20
Content-Type: application/octet-stream;
 name="lspci"
Content-Disposition: attachment;
 filename="lspci"
Content-Transfer-Encoding: base64

MDA6MDAuMCBIb3N0IGJyaWRnZTogU2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgW1NpU10gNTU3
MSAocmV2IDAxKQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMjU1
CgowMDowMS4wIElTQSBicmlkZ2U6IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIDg1
QzUwMy81NTEzIChyZXYgMDEpCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRldnNlbCwgbGF0
ZW5jeSAwCgowMDowMS4xIElERSBpbnRlcmZhY2U6IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1z
IFtTaVNdIDU1MTMgW0lERV0gKHJldiBjMSkgKHByb2ctaWYgOGEgW01hc3RlciBTZWNQIFByaVBd
KQoJU3Vic3lzdGVtOiBVbmtub3duIGRldmljZSAwMDQwOjAwMDAKCUZsYWdzOiBidXMgbWFzdGVy
LCBmYXN0IGRldnNlbCwgbGF0ZW5jeSAzMiwgSVJRIDE0CglJL08gcG9ydHMgYXQgPGlnbm9yZWQ+
CglJL08gcG9ydHMgYXQgPGlnbm9yZWQ+CglJL08gcG9ydHMgYXQgPGlnbm9yZWQ+CglJL08gcG9y
dHMgYXQgPGlnbm9yZWQ+CglJL08gcG9ydHMgYXQgMTAwMCBbc2l6ZT0xNl0KCjAwOjAxLjIgVVNC
IENvbnRyb2xsZXI6IFNpbGljb24gSW50ZWdyYXRlZCBTeXN0ZW1zIFtTaVNdIDcwMDEgKHJldiBl
MCkgKHByb2ctaWYgMTAgW09IQ0ldKQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWws
IGxhdGVuY3kgMzIsIElSUSAxMAoJTWVtb3J5IGF0IGU0MDAwMDAwICgzMi1iaXQsIG5vbi1wcmVm
ZXRjaGFibGUpIFtzaXplPTRLXQoKMDA6MGYuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiAz
RGZ4IEludGVyYWN0aXZlLCBJbmMuIFZvb2RvbyAzIChyZXYgMDEpIChwcm9nLWlmIDAwIFtWR0Fd
KQoJU3Vic3lzdGVtOiAzRGZ4IEludGVyYWN0aXZlLCBJbmMuOiBVbmtub3duIGRldmljZSAwMDU3
CglGbGFnczogZmFzdCBkZXZzZWwsIElSUSAxMQoJTWVtb3J5IGF0IGUwMDAwMDAwICgzMi1iaXQs
IG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTMyTV0KCU1lbW9yeSBhdCBlMjAwMDAwMCAoMzItYml0
LCBwcmVmZXRjaGFibGUpIFtzaXplPTMyTV0KCUkvTyBwb3J0cyBhdCA2MDAwIFtzaXplPTI1Nl0K
CUV4cGFuc2lvbiBST00gYXQgPHVuYXNzaWduZWQ+IFtkaXNhYmxlZF0gW3NpemU9NjRLXQoJQ2Fw
YWJpbGl0aWVzOiBbNjBdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAxCgo=

--Multipart_Fri__5_Jul_2002_17:08:23_+0200_081e9e20--
