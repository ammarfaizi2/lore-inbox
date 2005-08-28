Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbVH1M4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbVH1M4C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 08:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVH1M4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 08:56:01 -0400
Received: from ms001msg.fastwebnet.it ([213.140.2.51]:35043 "EHLO
	ms001msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1751160AbVH1M4A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 08:56:00 -0400
Date: Sun, 28 Aug 2005 14:55:48 +0200
From: Mattia Dongili <malattia@linux.it>
To: Andrew Morton <akpm@osdl.org>
Cc: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: Fw: Oops with 2.6.13-rc6-mm2 and USB mouse
Message-ID: <20050828125548.GA4824@inferi.kami.home>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	=?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	greg@kroah.com
References: <20050826220618.7365e690.akpm@osdl.org> <20050827200904.GA4362@ime.usp.br> <20050827153157.47ac39d2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20050827153157.47ac39d2.akpm@osdl.org>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.13-rc6-mm2-3 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2005 at 03:31:57PM -0700, Andrew Morton wrote:
> Rogério Brito <rbrito@ime.usp.br> wrote:
> >
> > Hi, Andrew.
> > 
> > I just tested the USB mouse with 2.6.13-rc6-mm2 and ACPI disabled
> > (which, according to Linus, is one of the "usual suspects") and the
> > problem still occurred.
> > 
> > On the other hand, with kernel 2.6.13-rc5-mm1 (which I am running now),
> > I didn't have any problems plugging and unplugging the mouse. Here are
> > the messages I get in dmesg (2.6.13-rc5-mm1) after I plug/unplug the
> > mouse:
> > 
> > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> > usb 1-1.2: new low speed USB device using uhci_hcd and address 4
> > input: USB HID v1.00 Mouse [USB Wheel Mouse] on usb-0000:00:04.2-1.2
> > usb 1-1.2: USB disconnect, address 4
> > - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> > 
> > Just thought you might like to know about this. If you want me to test
> > any other version, please let me know.
> > 
> 
> Unfortunately there are 71 USB patches in 2.6.13-rc6-mm2 and I don't know
> which ones to suspect.

Really, what I mentioned[1] it my previous message fixes the very same
issue with the usb device removal, see below the oops I had here.
Not that I can't wait for Greg to come back but just to have a pointer
for a possible fix :)

[1]: http://marc.theaimsgroup.com/?l=linux-kernel&m=112481438512222&w=2

usb 2-1: new low speed USB device using uhci_hcd and address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.1-1
usb 2-1: USB disconnect, address 2
BUG: atomic counter underflow at:
 [kref_put+89/160] kref_put+0x59/0xa0
 [klist_dec_and_del+27/32] klist_dec_and_del+0x1b/0x20
 [klist_release+0/80] klist_release+0x0/0x50
 [klist_remove+33/80] klist_remove+0x21/0x50
 [__device_release_driver+86/160] __device_release_driver+0x56/0xa0
 [device_release_driver+28/48] device_release_driver+0x1c/0x30
 [bus_remove_device+104/144] bus_remove_device+0x68/0x90
 [device_del+49/112] device_del+0x31/0x70
 [device_unregister+16/32] device_unregister+0x10/0x20
 [pg0+273833078/1069683712] hub_port_connect_change+0x56/0x450 [usbcore]
 [pg0+273822726/1069683712] clear_port_feature+0x56/0x60 [usbcore]
 [pg0+273834837/1069683712] hub_events+0x2e5/0x490 [usbcore]
 [pg0+273835264/1069683712] hub_thread+0x0/0xe0 [usbcore]
 [pg0+273835285/1069683712] hub_thread+0x15/0xe0 [usbcore]
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [kthread+182/192] kthread+0xb6/0xc0
 [kthread+0/192] kthread+0x0/0xc0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02f1477
*pde = 00000000
Oops: 0002 [#1]
PREEMPT 
last sysfs file: /class/usb_device/usbdev2.2/dev
Modules linked in: nfsd exportfs lockd sunrpc ipt_MASQUERADE iptable_nat ipt_state ip_conntrack nfnetlink ip table_filter ip_tables e100 mii yenta_socket rsrc_nonstatic pcmcia_core sd_mod snd_intel8x0 snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mix er_oss snd_pcm snd_timer snd soundcore snd_page_alloc i2c_i801 i2c_core hw_random usb_storage scsi_mod reiser4 zlib_deflate zlib_inflate dm _mod rtc tun crc32 psmouse sonypi speedstep_ich speedstep_lib evdev pcspkr intel_agp agpgart usbhid uhci_hcd usbcore cpufreq_powersave
CPU:    0
EIP:    0060:[wait_for_completion+103/256]    Not tainted VLI
EFLAGS: 00010046   (2.6.13-rc6-mm2-1) 
EIP is at wait_for_completion+0x67/0x100
eax: cf6d449c   ebx: cecf8000   ecx: cecf8000   edx: 00000000
esi: cf6d4498   edi: cecf9ec0   ebp: cecf9ed4   esp: cecf9eb4
ds: 007b   es: 007b   ss: 0068
Process khubd (pid: 1303, threadinfo=cecf8000 task=cecb0a90)
Stack: 00000001 cecb0a90 c0115e50 cf6d449c 00000000 cf6d44c4 cf6d4464 d0919a20 
       cf3c6800 c0251cc6 cf6d4488 c03178ec cf6d4464 cf3c6864 c13d1414 c0251d2c 
       cf6d4464 cf6d4464 c0251458 cf6d4464 cf6d4464 cf6d4464 c02503c1 cf6d4464 
Call Trace:
 [default_wake_function+0/32] default_wake_function+0x0/0x20
 [__device_release_driver+86/160] __device_release_driver+0x56/0xa0
 [device_release_driver+28/48] device_release_driver+0x1c/0x30
 [bus_remove_device+104/144] bus_remove_device+0x68/0x90
 [device_del+49/112] device_del+0x31/0x70
 [device_unregister+16/32] device_unregister+0x10/0x20
 [pg0+273833078/1069683712] hub_port_connect_change+0x56/0x450 [usbcore]
 [pg0+273822726/1069683712] clear_port_feature+0x56/0x60 [usbcore]
 [pg0+273834837/1069683712] hub_events+0x2e5/0x490 [usbcore]
 [pg0+273835264/1069683712] hub_thread+0x0/0xe0 [usbcore]
 [pg0+273835285/1069683712] hub_thread+0x15/0xe0 [usbcore]
 [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60
 [kthread+182/192] kthread+0xb6/0xc0
 [kthread+0/192] kthread+0x0/0xc0
 [kernel_thread_helper+5/12] kernel_thread_helper+0x5/0xc
Code: ec 00 00 00 00 c7 45 f0 00 00 00 00 8b 01 c7 45 e8 50 5e 11 c0 c7 45 e0 01 00 00 00 89 45 e4 8d 46 04 8b 50 04 89 45 ec 89 78 04 <89> 3a 89 55 f0 8d 74 26 00 8b 03 c7 00 02 00 00 00 fb 8b 43 08 
 <3>BUG: khubd[1303] exited with nonzero preempt_count 1!

-- 
mattia
:wq!
