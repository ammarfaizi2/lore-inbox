Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275530AbRIZTdm>; Wed, 26 Sep 2001 15:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275528AbRIZTde>; Wed, 26 Sep 2001 15:33:34 -0400
Received: from rdu26-247-195.nc.rr.com ([66.26.247.195]:13829 "EHLO antenas")
	by vger.kernel.org with ESMTP id <S275527AbRIZTdS>;
	Wed, 26 Sep 2001 15:33:18 -0400
Date: Wed, 26 Sep 2001 10:43:54 -0400
From: "Eloy A. Paris" <eloy.paris@usa.net>
To: webcam@smcc.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: 2.4.10 is toxic to my system when I use my USB webcam (was: More info. on crash)
Message-ID: <20010926104354.A2192@antenas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again Nemosoft,

I have been doing some tests to determine where the problems is. The
good news is that the problem is not in your driver. The bad news is
that 2.4.10 is toxic to my system (at least when I try to use my
Phillips webcam) and that the problem lies somewhere else.

Here's a quick summary of the tests I did:

(0) Stock 2.4.9: rock solid
(1) Stock 2.4.10: system crash after device is open()'ed
(2) 2.4.10 + pwc 8.1 (backed out pwc 8.2): system crash as in (1)
(3) 2.4.10 + changes to usbcore.o and usb-uhci.o backed out: system
    crash.
(4) 2.4.9 + pwc 8.2: rock solid

If I don't try to use my webcam, 2.4.10 seems to behave very well on
my system. It's a shame because the VM behavior of 2.4.9 is
_terrible_, one of the worst I've ever seen. But now I am back to
2.4.9 + pwc 8.2 because that's the only way to use my webcam.

I am Cc'ing linux-kernel with the hopes someone there has a clue.

Note to linux-kernel: all the background info. about my problem is in
my original report to the pwc driver author. The report is in the
message below. There's even a decoded Oops, but I don't see how it can
be useful.

There's nothing special about my system. I have run all sort of kernels
in this machine (2.0.3x, 2.2.x, 2.3.x, 2.4.x) and never had a problem.
As I mentioned, if I don't try to use my webcam 2.4.10 behaves very
well. But if I do, the system crashes pretty bad.

I am willing to go through the disgrace of fsck's if someone wants
more debugging info.

Cheers,

Eloy.-

----- Forwarded message from "Eloy A. Paris" <eloy.paris@usa.net> -----

From: "Eloy A. Paris" <eloy.paris@usa.net>
To: webcam@smcc.demon.nl
Subject: More info. on crash

Hi Nemosoft,

This is 100% reproducible. The worst thing about this is that
every time my computer crashes I have to go through a fsck that takes
about 20 minutes. The crash seems to happen in the middle of an
interrupt so nothing gets written to disk.

I spent 5 minutes copying by hand the Oops output, but I fear it will
be useless. Here it is:

ksymoops 2.4.3 on i686 2.4.10.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.10/ (default)
     -m /System.map (specified)

*pde = 00001063
Oops: 0000
CPU:    0
EIP:    0010:[<c88fd441>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: 00000000   ebx: c57334a8   ecx: 00000003   edx: c0d66400
esi: 00000000   edi: c57336a0   ebp: c6e030c0   esp: c01d5eec
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c01d5000)
Stack: c57334a8 c57336a0 c57337a0 00000000 00000010 c2049120 00000000 00000001
       c88fd5c9 c57337a0 c57336a0 00000000 c57334a8 c57337a0 00000000 00000000
       c88fd863 c57337a0 00000000 c88fd81d c57337a0 c57336a8 c4b572e0 04000001
Call Trace: [<c88fd5c9>] [<c88fd863>] [<c88fd81d>] [<c0107cef>] [<c0107e4e>]
   [<c0105150>] [<c0105150>] [<c0109c28>] [<c0105150>] [<c0105150>] [<c0105173>]
   [<c01051d9>] [<c0105000>] [<c0105027>]
Code: 8b 46 dc 8d 6e d8 a9 00 00 80 00 74 39 25 ff ff 7f ff 89 46

>>EIP; c88fd440 <END_OF_CODE+3f38e/????>   <=====
Trace; c88fd5c8 <END_OF_CODE+3f516/????>
Trace; c88fd862 <END_OF_CODE+3f7b0/????>
Trace; c88fd81c <END_OF_CODE+3f76a/????>
Trace; c0107cee <handle_IRQ_event+2e/58>
Trace; c0107e4e <do_IRQ+6e/b0>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0109c28 <call_do_IRQ+6/e>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105172 <default_idle+22/28>
Trace; c01051d8 <cpu_idle+40/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105026 <rest_init+26/28>
Code;  c88fd440 <END_OF_CODE+3f38e/????>
00000000 <_EIP>:
Code;  c88fd440 <END_OF_CODE+3f38e/????>   <=====
   0:   8b 46 dc                  mov    0xffffffdc(%esi),%eax   <=====
Code;  c88fd442 <END_OF_CODE+3f390/????>
   3:   8d 6e d8                  lea    0xffffffd8(%esi),%ebp
Code;  c88fd446 <END_OF_CODE+3f394/????>
   6:   a9 00 00 80 00            test   $0x800000,%eax
Code;  c88fd44a <END_OF_CODE+3f398/????>
   b:   74 39                     je     46 <_EIP+0x46> c88fd486 <END_OF_CODE+3f3d4/????>
Code;  c88fd44c <END_OF_CODE+3f39a/????>
   d:   25 ff ff 7f ff            and    $0xff7fffff,%eax
Code;  c88fd452 <END_OF_CODE+3f3a0/????>
  12:   89 46 00                  mov    %eax,0x0(%esi)

 <0>Kernel panic: Aiee, killing interrupt hander!

To tigger the crash, I do the following:

# insmod usbcore
# insmod usb-uhci
# insmod videodev
# insmod pwc
# camE

The the following gets written to the console:

camE v1.2 - (c) 1999, 2000 Gerd Knorr, Tom Gilbert
grabber config: size 640x480, input 0, norm 0, jpeg quality 80
Unable to handle paging request at virtual address ffffffdc
*pde = 00001063
[Oops output]

This is what I found in my syslog:

[...]
Sep 25 20:18:45 antenas kernel: usb.c: registered new driver usbdevfs
Sep 25 20:18:45 antenas kernel: usb.c: registered new driver hub
Sep 25 20:19:04 antenas kernel: usb-uhci.c: $Revision: 1.268 $ time 21:42:27 Sep 23 2001
Sep 25 20:19:04 antenas kernel: usb-uhci.c: High bandwidth mode enabled
Sep 25 20:19:04 antenas kernel: PCI: Found IRQ 11 for device 00:07.2
Sep 25 20:19:04 antenas kernel: PCI: Sharing IRQ 11 with 00:03.0
Sep 25 20:19:04 antenas kernel: PCI: Sharing IRQ 11 with 00:03.1
Sep 25 20:19:04 antenas kernel: usb-uhci.c: USB UHCI at I/O 0xece0, IRQ 11
Sep 25 20:19:04 antenas kernel: usb-uhci.c: Detected 2 ports
Sep 25 20:19:04 antenas kernel: usb.c: new USB bus registered, assigned bus number 1
Sep 25 20:19:04 antenas kernel: hub.c: USB hub found
Sep 25 20:19:04 antenas kernel: hub.c: 2 ports detected
Sep 25 20:19:04 antenas kernel: usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
Sep 25 20:19:04 antenas kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Sep 25 20:19:04 antenas kernel: usb.c: USB device 2 (vend/prod 0x471/0x30c) is not claimed by any active driver.
Sep 25 20:19:41 antenas kernel: Linux video capture interface: v1.00
Sep 25 20:20:09 antenas kernel: pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module version 8.2 loaded.
Sep 25 20:20:09 antenas kernel: pwc Also supports Askey VC010 cam.
Sep 25 20:20:09 antenas kernel: usb.c: registered new driver Philips webcam
Sep 25 20:20:09 antenas kernel: pwc Philips PCVC690K (Vesta Pro Scan) USB webcam detected.
Sep 25 20:20:09 antenas kernel: pwc Registered as /dev/video0.

And here it stopped.

Again, this is a stock 2.4.10 kernel. It was _rock solid_ with kernel
2.4.9. As you said in your home page, it is hard to say if the crash
is due to the pwc driver or to the USB stack. Both changed in 2.4.10.
I haven't seen anything in the linux-usb mailing list.

Uhhmmm, this is weird, isn't it?

Letme know if you want me to try something else. I was thinking about
trying pwc 8.1, but I really don't like going through long fsck's.

Bye for now.

Eloy.-

P.S. You say you don't see problems. Could it be you are using your
camera at a different resolution or are using different settings that
do not trigger the bug?

----- End forwarded message -----
