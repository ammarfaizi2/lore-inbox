Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282784AbRK0EWr>; Mon, 26 Nov 2001 23:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282785AbRK0EW2>; Mon, 26 Nov 2001 23:22:28 -0500
Received: from fe6.southeast.rr.com ([24.93.67.53]:18705 "EHLO
	Mail6.triad.rr.com") by vger.kernel.org with ESMTP
	id <S282784AbRK0EWV>; Mon, 26 Nov 2001 23:22:21 -0500
Message-ID: <3C031524.50F076CD@triad.rr.com>
Date: Mon, 26 Nov 2001 23:23:00 -0500
From: "John D. Davis" <jddavis@triad.rr.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16cd i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Possible problems with khub in current 2.4.15-2.4.16 kernels
In-Reply-To: <3C029D3F.E43B4E9C@triad.rr.com> <20011126135142.A4675@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,
The oops only occurs at startup.  here's the oops parsed through ksymoops

Nov 26 13:50:02 orca kernel: input2<1>Unable to handle kernel paging request
at virtual address ffffffff
Nov 26 13:50:02 orca kernel: c0264fbb
Nov 26 13:50:02 orca kernel: *pde = 00001063
Nov 26 13:50:02 orca kernel: Oops: 0000
Nov 26 13:50:02 orca kernel: CPU:    0
Nov 26 13:50:02 orca kernel: EIP:    0010:[vsnprintf+523/1056]    Not
tainted
Nov 26 13:50:02 orca kernel: EIP:    0010:[<c0264fbb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Nov 26 13:50:02 orca kernel: EFLAGS: 00010097
Nov 26 13:50:02 orca kernel: eax: ffffffff   ebx: c03190b0   ecx: ffffffff
edx: fffffffe
Nov 26 13:50:02 orca kernel: esi: ffffffff   edi: c1557ed4   ebp: ffffffff
esp: c1557e84
Nov 26 13:50:02 orca kernel: ds: 0018   es: 0018   ss: 0018
Nov 26 13:50:02 orca kernel: Process khubd (pid: 7, stackpage=c1557000)
Nov 26 13:50:02 orca kernel: Stack: 00000000 c031949f 0000000a c03190a0
00000246 00000001 c1543c00 c0115a0e
Nov 26 13:50:02 orca kernel:        c03190a0 00000400 c029f1b4 c1557ec8
d3b3a000 ffffffff 00000001 c021c3ac
Nov 26 13:50:02 orca kernel:        c029f1a0 00000001 00000000 ffffffff
d3b3b230 00000001 00000004 00000001
Nov 26 13:50:02 orca kernel: Call Trace: [printk+94/272] [hid_probe+300/320]
[usb_find_interface_driver+318/496] [usb_find_drivers+57/128]
[usb_new_device+387/416]
Nov 26 13:50:02 orca kernel: Call Trace: [<c0115a0e>] [<c021c3ac>]
[<c020ebbe>] [<c020ee99>] [<c0210da3>]
Nov 26 13:50:02 orca kernel:    [<c021226b>] [<c0212297>] [<c0212474>]
[<c0212645>] [<c0105000>] [<c0105516>]
Nov 26 13:50:02 orca kernel:    [<c0212610>]
Nov 26 13:50:02 orca kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29 c8
f6 04 24 10 89 c6

>>EIP; c0264fba <vsnprintf+20a/420>   <=====
Trace; c0115a0e <printk+5e/110>
Trace; c021c3ac <hid_probe+12c/140>
Trace; c020ebbe <usb_find_interface_driver+13e/1f0>
Trace; c020ee98 <usb_find_drivers+38/80>
Trace; c0210da2 <usb_new_device+182/1a0>
Trace; c021226a <usb_hub_port_connect_change+21a/310>
Trace; c0212296 <usb_hub_port_connect_change+246/310>
Trace; c0212474 <usb_hub_events+114/2b0>
Trace; c0212644 <usb_hub_thread+34/60>
Trace; c0105000 <_stext+0/0>
Trace; c0105516 <kernel_thread+26/30>
Trace; c0212610 <usb_hub_thread+0/60>
Code;  c0264fba <vsnprintf+20a/420>
00000000 <_EIP>:
Code;  c0264fba <vsnprintf+20a/420>   <=====
   0:   80 38 00                  cmpb   $0x0,(%eax)   <=====
Code;  c0264fbc <vsnprintf+20c/420>
   3:   74 07                     je     c <_EIP+0xc> c0264fc6
<vsnprintf+216/420>
Code;  c0264fbe <vsnprintf+20e/420>
   5:   40                        inc    %eax
Code;  c0264fc0 <vsnprintf+210/420>
   6:   4a                        dec    %edx
Code;  c0264fc0 <vsnprintf+210/420>
   7:   83 fa ff                  cmp    $0xffffffff,%edx
Code;  c0264fc4 <vsnprintf+214/420>
   a:   75 f4                     jne    0 <_EIP>
Code;  c0264fc6 <vsnprintf+216/420>
   c:   29 c8                     sub    %ecx,%eax
Code;  c0264fc8 <vsnprintf+218/420>
   e:   f6 04 24 10               testb  $0x10,(%esp,1)
Code;  c0264fcc <vsnprintf+21c/420>
  12:   89 c6                     mov    %eax,%esi


Greg KH wrote:

> On Mon, Nov 26, 2001 at 02:51:27PM -0500, John D. Davis wrote:
> > I've noticed an odd occurance with the 2.4.15 and 2.4.16 kernels during
> > testing.
> >
> > There seems to be a problem with khub.c  or it could be my hardware but
> > I keep getting the following oops and ptrace about 50% of the time
> > during boot.  The following snip is from the boot log of the 2.4.16
> > kernel compliled this afternoon.
>
> Does this happen when you plug in your device after Linux is booted?
> Can you send the output of /proc/bus/usb/devices with the device plugged
> in (if it doesn't always cause an oops)?
> Can you run that oops through ksymoops and post it?
>
> thanks,
>
> greg k-h

