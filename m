Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTFUW4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 18:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTFUW4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 18:56:34 -0400
Received: from RJ116065.user.veloxzone.com.br ([200.141.116.65]:1920 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263915AbTFUW4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 18:56:24 -0400
Date: Sat, 21 Jun 2003 20:10:13 -0300 (BRT)
From: =?UTF-8?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
cc: Gerd Knorr <kraxel@bytesex.org>
Subject: 2.4.21: Reproduceable Oops doing modprobe bttv (ProLink PixelView
 PlayTVpro 9D)
Message-ID: <Pine.LNX.4.56.0306211949230.205@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.20 worked fine with bttv-0.7.106.tar.gz. Today I used
2.4.21 with the kernel modules and got a reproduceable Oops
doing modprobe bttv. lsmod shows bttv as (initializing).

modprobe -a tuner msp3400 bttv (or using separate modprobe for
each module).

/etc/modules.conf:

# I2C
alias char-major-89     i2c-dev
options i2c-core        i2c_debug=1
options i2c-algo-bit    bit_test=1

# TV
alias char-major-81     videodev
alias char-major-81-0   bttv
options bttv            card=37 tuner=2 radio=1
options tuner           type=2

I also tested with another 2.4.21 without ACPI.

ksymoops 2.4.9 on i686 2.4.21-ACPI.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-ACPI/ (default)
     -m /boot/System.map-2.4.21-ACPI (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel paging request at virtual address f689c318
f689c318
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<f689c318>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: f689c318   ebx: e28d5210   ecx: e28dd820   edx: e28d5210
esi: e28dd7fc   edi: e28dd9e2   ebp: e28dd9e0   esp: dee19e24
ds: 0018   es: 0018   ss: 0018
Process modprobe (pid: 2516, stackpage=dee19000)
Stack: e28c974a c01005ff c01fcc6b e28dd9e4 ffffffff e28dd9dc e28dd7fc e28dd9e2
       e28dd9dc 00000000 00000002 e28ddac4 e28ca46d e28d5210 e28dd9e0 000f1000
       df7893c4 e28ddac4 00000002 ffffffff c01fcce6 e28dd9e1 1d72261f e28d8ca3
Call Trace:    [<e28c974a>] [<c01fcc6b>] [<e28dd9e4>] [<e28dd9dc>] [<e28dd7fc>]
  [<e28dd9e2>] [<e28dd9dc>] [<e28ddac4>] [<e28ca46d>] [<e28d5210>] [<e28dd9e0>]
  [<e28ddac4>] [<c01fcce6>] [<e28dd9e1>] [<e28d8ca3>] [<e28d558b>] [<e28dd9dc>]
  [<e28dd820>] [<e28dd820>] [<e28dd9e1>] [<e28d8c9f>] [<e28dd820>] [<e28d1b57>]
  [<e28dd820>] [<e28dd820>] [<e28dd820>] [<e28dd910>] [<e28d267a>] [<e28dd820>]
  [<e28d9740>] [<e28d97a0>] [<c01b6b35>] [<e28d9740>] [<e28d97a0>] [<c01b6b94>]
  [<e28d97a0>] [<e28d277a>] [<e28d97a0>] [<c01182c1>] [<e28cc060>] [<c0106d27>]
Code:  Bad EIP value.


>>EIP; f689c318 <END_OF_CODE+13fff474/????>   <=====

>>esp; dee19e24 <_end+1eb63514/20554750>

Trace; e28c974a <END_OF_CODE+2c8a6/????>
Trace; c01fcc6b <vsnprintf+3db/420>
Trace; e28dd9e4 <END_OF_CODE+40b40/????>
Trace; e28dd9dc <END_OF_CODE+40b38/????>
Trace; e28dd7fc <END_OF_CODE+40958/????>
Trace; e28dd9e2 <END_OF_CODE+40b3e/????>
Trace; e28dd9dc <END_OF_CODE+40b38/????>
Trace; e28ddac4 <END_OF_CODE+40c20/????>
Trace; e28ca46d <END_OF_CODE+2d5c9/????>
Trace; e28d5210 <END_OF_CODE+3836c/????>
Trace; e28dd9e0 <END_OF_CODE+40b3c/????>
Trace; e28ddac4 <END_OF_CODE+40c20/????>
Trace; c01fcce6 <vsprintf+16/20>
Trace; e28dd9e1 <END_OF_CODE+40b3d/????>
Trace; e28d8ca3 <END_OF_CODE+3bdff/????>
Trace; e28d558b <END_OF_CODE+386e7/????>
Trace; e28dd9dc <END_OF_CODE+40b38/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28dd9e1 <END_OF_CODE+40b3d/????>
Trace; e28d8c9f <END_OF_CODE+3bdfb/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28d1b57 <END_OF_CODE+34cb3/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28dd910 <END_OF_CODE+40a6c/????>
Trace; e28d267a <END_OF_CODE+357d6/????>
Trace; e28dd820 <END_OF_CODE+4097c/????>
Trace; e28d9740 <END_OF_CODE+3c89c/????>
Trace; e28d97a0 <END_OF_CODE+3c8fc/????>
Trace; c01b6b35 <pci_announce_device+35/50>
Trace; e28d9740 <END_OF_CODE+3c89c/????>
Trace; e28d97a0 <END_OF_CODE+3c8fc/????>
Trace; c01b6b94 <pci_register_driver+44/60>
Trace; e28d97a0 <END_OF_CODE+3c8fc/????>
Trace; e28d277a <END_OF_CODE+358d6/????>
Trace; e28d97a0 <END_OF_CODE+3c8fc/????>
Trace; c01182c1 <sys_init_module+571/630>
Trace; e28cc060 <END_OF_CODE+2f1bc/????>
Trace; c0106d27 <system_call+33/38>


1 warning issued.  Results may not be reliable.
