Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbTIKWdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbTIKWdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:33:07 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:49540 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S261594AbTIKWcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:32:48 -0400
Date: Thu, 11 Sep 2003 17:32:24 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: 2.6.0-test5 usbserial oops
Message-ID: <20030911223224.GA1345@glitch.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030911044650.GA10064@kroah.com> <20030911175755.GA13334@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20030911175755.GA13334@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2003 at 10:57:56AM -0700, Greg KH wrote:
> Hm, can you try the following patch and let me know if it fixes the
> problem for you?
> 
> thanks,
> 
> greg k-h

I'm still getting an (apparently) identical oops.  I've attached the
ksymoops output (your patch was applied for this one), along with the
debugging messages you requested previously.  Let me know if I can
provide any additional info.

Thanx!


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="oops.decoded"

ksymoops 2.4.8 on i686 2.6.0-test5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test5/ (default)
     -m /boot/System.map-2.6.0-test5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference 4t vrrnuil  edp:
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01ff883>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000005   ebx: f67e7800   ecx: 00000000   edx: f751f600
esi: c02dc4a8   edi: c02dc4c0   ebp: c1bdde04   esp: c1bdde00
ds: 007b   es: 007b   ss: 0068
Stack: c02dc4c0 c1bdde20 f8aa430b f751f600 f8aa67c0 f8aa6373 f67e78d8 f67e78a4 
       c1bdde38 c01d95f9 f67e7880 c1bdde40 c01d9900 f67e78a4 c1bdde50 c01b2d4c 
       f67e78a4 f67e7800 00000001 f6ba0880 c1bdde74 f8aa426c f67e78a4 f8aa67c0 
Call Trace:
 [<f8aa430b>] port_release+0x66/0xc5 [usbserial]
 [<c01d95f9>] device_release+0x5a/0x5e
 [<c01d9900>] device_del+0x6a/0x90
 [<c01b2d4c>] kobject_cleanup+0x73/0x75
 [<f8aa426c>] destroy_serial+0x189/0x1c2 [usbserial]
 [<c01b2d4c>] kobject_cleanup+0x73/0x75
 [<f8aa51b2>] usb_serial_disconnect+0x37/0x7e [usbserial]
 [<c01fa06f>] usb_unbind_interface+0x78/0x7a
 [<c01da8e3>] device_release_driver+0x62/0x64
 [<c01daa07>] bus_remove_device+0x54/0x93
 [<c01d98f5>] device_del+0x5f/0x90
 [<c01d993a>] device_unregister+0x14/0x22
 [<c01fab97>] usb_disconnect+0xee/0x113
 [<c01fd2c0>] hub_port_connect_change+0x323/0x328
 [<c01fcba8>] hub_port_status+0x3a/0xa0
 [<c01fd5b8>] hub_events+0x2f3/0x371
 [<c01fd663>] hub_thread+0x2d/0xc2
 [<c01092da>] ret_from_fork+0x6/0x14
 [<c011b71a>] default_wake_function+0x0/0x2e
 [<c01fd636>] hub_thread+0x0/0xc2
 [<c01072d9>] kernel_thread_helper+0x5/0xb
Code: 8b 80 cc 00 00 00 85 c0 74 07 8b 40 20 85 c0 75 09 b8 ed ff 


>>EIP; c01ff883 <usb_unlink_urb+14/39>   <=====

>>ebx; f67e7800 <__crc_lookup_create+76bd1/29c1f5>
>>edx; f751f600 <__crc_redraw_screen+1a721f/5580ca>
>>esi; c02dc4a8 <ktype_device+0/c>
>>edi; c02dc4c0 <devices_subsys+0/60>
>>ebp; c1bdde04 <__crc_seq_path+2926b4/79605d>
>>esp; c1bdde00 <__crc_seq_path+2926b0/79605d>

Trace; f8aa430b <__crc_pm_idle+19448c/8e97d5>
Trace; c01d95f9 <device_release+5a/5e>
Trace; c01d9900 <device_del+6a/90>
Trace; c01b2d4c <kobject_cleanup+73/75>
Trace; f8aa426c <__crc_pm_idle+1943ed/8e97d5>
Trace; c01b2d4c <kobject_cleanup+73/75>
Trace; f8aa51b2 <__crc_pm_idle+195333/8e97d5>
Trace; c01fa06f <usb_unbind_interface+78/7a>
Trace; c01da8e3 <device_release_driver+62/64>
Trace; c01daa07 <bus_remove_device+54/93>
Trace; c01d98f5 <device_del+5f/90>
Trace; c01d993a <device_unregister+14/22>
Trace; c01fab97 <usb_disconnect+ee/113>
Trace; c01fd2c0 <hub_port_connect_change+323/328>
Trace; c01fcba8 <hub_port_status+3a/a0>
Trace; c01fd5b8 <hub_events+2f3/371>
Trace; c01fd663 <hub_thread+2d/c2>
Trace; c01092da <ret_from_fork+6/14>
Trace; c011b71a <default_wake_function+0/2e>
Trace; c01fd636 <hub_thread+0/c2>
Trace; c01072d9 <kernel_thread_helper+5/b>

Code;  c01ff883 <usb_unlink_urb+14/39>
00000000 <_EIP>:
Code;  c01ff883 <usb_unlink_urb+14/39>   <=====
   0:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax   <=====
Code;  c01ff889 <usb_unlink_urb+1a/39>
   6:   85 c0                     test   %eax,%eax
Code;  c01ff88b <usb_unlink_urb+1c/39>
   8:   74 07                     je     11 <_EIP+0x11>
Code;  c01ff88d <usb_unlink_urb+1e/39>
   a:   8b 40 20                  mov    0x20(%eax),%eax
Code;  c01ff890 <usb_unlink_urb+21/39>
   d:   85 c0                     test   %eax,%eax
Code;  c01ff892 <usb_unlink_urb+23/39>
   f:   75 09                     jne    1a <_EIP+0x1a>
Code;  c01ff894 <usb_unlink_urb+25/39>
  11:   b8 ed ff 00 00            mov    $0xffed,%eax

CPU 1 IS NOW UP!
Machine check exception polling timer started.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
Unable to handle kernel NULL pointer dereference at virtual address 000000d1
c01ff883
*pde = 00000000
Oops: 0000 [#1]
CPU:    1
EIP:    0060:[<c01ff883>]    Not tainted
EFLAGS: 00010206
eax: 00000005   ebx: f6bdc600   ecx: 00000000   edx: f737d800
esi: c02dc4a8   edi: c02dc4c0   ebp: c1bdde04   esp: c1bdde00
ds: 007b   es: 007b   ss: 0068
Stack: c02dc4c0 c1bdde20 f8a8d30b f737d800 f8a8f7c0 f8a8f373 f6bdc6d8 f6bdc6a4 
       c1bdde38 c01d95f9 f6bdc680 c1bdde40 c01d9900 f6bdc6a4 c1bdde50 c01b2d4c 
       f6bdc6a4 f6bdc600 00000001 c1b27300 c1bdde74 f8a8d26c f6bdc6a4 f8a8f7c0 
Call Trace:
 [<f8a8d30b>] port_release+0x66/0xc5 [usbserial]
 [<c01d95f9>] device_release+0x5a/0x5e
 [<c01d9900>] device_del+0x6a/0x90
 [<c01b2d4c>] kobject_cleanup+0x73/0x75
 [<f8a8d26c>] destroy_serial+0x189/0x1c2 [usbserial]
 [<c01b2d4c>] kobject_cleanup+0x73/0x75
 [<f8a8e1b2>] usb_serial_disconnect+0x37/0x7e [usbserial]
 [<c01fa06f>] usb_unbind_interface+0x78/0x7a
 [<c01da8e3>] device_release_driver+0x62/0x64
 [<c01daa07>] bus_remove_device+0x54/0x93
 [<c01d98f5>] device_del+0x5f/0x90
 [<c01d993a>] device_unregister+0x14/0x22
 [<c01fab97>] usb_disconnect+0xee/0x113
 [<c01fd2c0>] hub_port_connect_change+0x323/0x328
 [<c01fcba8>] hub_port_status+0x3a/0xa0
 [<c01fd5b8>] hub_events+0x2f3/0x371
 [<c01fd663>] hub_thread+0x2d/0xc2
 [<c01092da>] ret_from_fork+0x6/0x14
 [<c011b71a>] default_wake_function+0x0/0x2e
 [<c01fd636>] hub_thread+0x0/0xc2
 [<c01072d9>] kernel_thread_helper+0x5/0xb
Code: 8b 80 cc 00 00 00 85 c0 74 07 8b 40 20 85 c0 75 09 b8 ed ff 


>>EIP; c01ff883 <usb_unlink_urb+14/39>   <=====

>>ebx; f6bdc600 <__crc_color_table+27ed7/83a35>
>>edx; f737d800 <__crc_redraw_screen+541f/5580ca>
>>esi; c02dc4a8 <ktype_device+0/c>
>>edi; c02dc4c0 <devices_subsys+0/60>
>>ebp; c1bdde04 <__crc_seq_path+2926b4/79605d>
>>esp; c1bdde00 <__crc_seq_path+2926b0/79605d>

Trace; f8a8d30b <__crc_pm_idle+17d48c/8e97d5>
Trace; c01d95f9 <device_release+5a/5e>
Trace; c01d9900 <device_del+6a/90>
Trace; c01b2d4c <kobject_cleanup+73/75>
Trace; f8a8d26c <__crc_pm_idle+17d3ed/8e97d5>
Trace; c01b2d4c <kobject_cleanup+73/75>
Trace; f8a8e1b2 <__crc_pm_idle+17e333/8e97d5>
Trace; c01fa06f <usb_unbind_interface+78/7a>
Trace; c01da8e3 <device_release_driver+62/64>
Trace; c01daa07 <bus_remove_device+54/93>
Trace; c01d98f5 <device_del+5f/90>
Trace; c01d993a <device_unregister+14/22>
Trace; c01fab97 <usb_disconnect+ee/113>
Trace; c01fd2c0 <hub_port_connect_change+323/328>
Trace; c01fcba8 <hub_port_status+3a/a0>
Trace; c01fd5b8 <hub_events+2f3/371>
Trace; c01fd663 <hub_thread+2d/c2>
Trace; c01092da <ret_from_fork+6/14>
Trace; c011b71a <default_wake_function+0/2e>
Trace; c01fd636 <hub_thread+0/c2>
Trace; c01072d9 <kernel_thread_helper+5/b>

Code;  c01ff883 <usb_unlink_urb+14/39>
00000000 <_EIP>:
Code;  c01ff883 <usb_unlink_urb+14/39>   <=====
   0:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax   <=====
Code;  c01ff889 <usb_unlink_urb+1a/39>
   6:   85 c0                     test   %eax,%eax
Code;  c01ff88b <usb_unlink_urb+1c/39>
   8:   74 07                     je     11 <_EIP+0x11>
Code;  c01ff88d <usb_unlink_urb+1e/39>
   a:   8b 40 20                  mov    0x20(%eax),%eax
Code;  c01ff890 <usb_unlink_urb+21/39>
   d:   85 c0                     test   %eax,%eax
Code;  c01ff892 <usb_unlink_urb+23/39>
   f:   75 09                     jne    1a <_EIP+0x1a>
Code;  c01ff894 <usb_unlink_urb+25/39>
  11:   b8 ed ff 00 00            mov    $0xffed,%eax


1 warning and 1 error issued.  Results may not be reliable.

--pf9I7BMVVzbSWLtt
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kern.log.gz"
Content-Transfer-Encoding: base64

H4sICLr0YD8CA2tlcm4ubG9nAO2dX2/kSHbl3/dTXGBf7O2ZLjIYjCAbmIe1vbYXMGYG2x7D
gDEo8G+3tqulgqSantlPv3GDyUymMqXMUmV1BSt/hYSgolIk8yjOZcQ9J+79fngveS65/y6v
vssq+eHdzWP3o/w03N8O776T/v7mL8P9w5sPD+2b7u5+0G++7b6T++GHm4fH4X7o5Xb4ZfM2
CT98GO5vmnf/7fvzTzv9hn772+lbPf+fvv8H+T7+T/5pOrdeXf5ivs32z537Tzn3w4f37+/u
H5cfZ7y7l39tbvuH9/c3tz/If9w8hANv5I/Nu5/lD99/8sX/tenl8U7uwrvub/pBHn8c5OHH
D4/93S+3ip9Mb5W798N983hzdyu/3Dz+GN/2w3AbftbJ3e3w7a8Awvd3t3+Tf3x3M0jxbfkx
1zs9Tv6ioL7iI8Tfm+9e/0jfH/0jbS9jvs33r2IOrvLjh1by32bfZeGCQ3v34bYbvpMIh9Mj
75q/SZ5lPz/Iw2PTvhvE6jePHx4k+2uZnXV2e/Ts5tTZ8486u4KroPTDX266IQyRzVV+I83D
w80PtwH/pu/vh4cHMadOe3Ls9MNDd3/z/jFg/nMTfnN4eMUpt3/L+M3b9/d37XCh08hvw7h7
GB5DzLgdb374lLO+DyPq7d3D2+K8G1QC29+a716IIN/J7z/83IbReTfGv9HDd2KKzF7kzPFv
nv1Gbh4ig/9paD/88EOMy8PnOP+/bALSGac/OabGQI5e2g/vfpK7D48XOt3NbQg99x/eP4bv
0rzDeLrTNxfHY/z7ZC/9hXTAh6uGDx04+jh0j0P/yff5w/D4drwfhrebB5O5+Bl/Kz/f3IaP
0TYPg/xOsk++QPjf5tzbeBCiwaMC9uG9mGkYPzzef+geP4RAEcfy449hUE/R81PixeP9cPe2
eXxsuh8/x8eYH6f6UR4f/xYifnYBYi+Gze3dLzLd/hDnKZuLyN/dxdndm8fHhzdZBCxgNT78
/a/zIfNf40Pmex8yv+SH3HzAMKe7/fRHnJ4loBQHcX6x04XZgYK2jJjvPzxO1Ahj+lIQ3Nx1
j++2d/8b6X7udSZlswt8koue+5ru3nzGuzeXuvsQwd+Gsfnzzd3DBUf/r3HWvnlspL15fAgP
t+rit9zc3zz+LZz5NiwLL33yh8e79/OdXxyW//Pv37/5x3//XieT/c2DLn/6S1/iP//w+zf/
+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
VTQbSQ4A

--pf9I7BMVVzbSWLtt--
