Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265284AbUENNmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265284AbUENNmV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265282AbUENNmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:42:21 -0400
Received: from lucidpixels.com ([66.45.37.187]:65249 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S265281AbUENNlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:41:09 -0400
Date: Fri, 14 May 2004 09:41:08 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: bert hubert <ahu@ds9a.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel 2.6 SMP+HT + 1 Intel P4 HT CPU
In-Reply-To: <20040514133947.GB21039@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.58.0405140940090.24191@p500>
References: <5D3C2276FD64424297729EB733ED1F7605FAE205@email1.mitretek.org>
 <Pine.LNX.4.58.0405140848220.24191@p500> <20040514133947.GB21039@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HAs anyone done the following benchmarks?

1] SMP + HT ON
2] SMP OFF + HT ON
3] SMP + HT OFF
4] SMP OFF + HT OFF

For Linux 2.6.x and a P4 HT CPU?


On Fri, 14 May 2004, bert hubert wrote:

> On Fri, May 14, 2004 at 08:49:39AM -0400, Justin Piszcz wrote:
> > Why would you use SMP on an HT cpu?
> > Is this reccomended?
>
> Yes, it acts like one.
>
> >
> > >
> > >
> > > -----Original Message-----
> > > From: linux-kernel-owner@vger.kernel.org
> > > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alberto
> > > Bertogli
> > > Sent: Thursday, May 13, 2004 8:42 PM
> > > To: linux-usb-devel@lists.sourceforge.net
> > > Cc: linux-kernel@vger.kernel.org
> > > Subject: BUG when removing USB flash drive
> > >
> > > Hi!
> > >
> > > I've just hit a bug after removing a Kingston USB flash drive.
> > >
> > > I have removed it several (probably more than 40) times today without
> > > problems until now. I'm removing it while doing streaming write()s on
> > > the device (using /dev/sda) because I'm testing some things with the
> > > drive. This was just like all the other times, so it looks like a race
> > > somewhere.
> > >
> > > This is a stock 2.6.6 kernel, on a Pentium 4 with HT (the kernel is
> > > compiled with both SMP and preempt).
> > >
> > > After the BUG the kernel doesn't detect the device anymore.
> > >
> > > Please let me know if you need any more information or if I can give you
> > > a
> > > hand with testing.
> > >
> > > Thanks a lot,
> > > 		Alberto
> > >
> > >
> > > kernel BUG at drivers/usb/storage/usb.c:848!
> > > invalid operand: 0000 [#1]
> > > PREEMPT SMP
> > > CPU:    1
> > > EIP:    0060:[<c030843c>]    Not tainted
> > > EFLAGS: 00010202   (2.6.6)
> > > EIP is at usb_stor_release_resources+0xa3/0xcd
> > > eax: 00002832   ebx: c639e200   ecx: c04bd768   edx: debf2888
> > > esi: c04c6780   edi: c308ac00   ebp: c308ac24   esp: dededeb0
> > > ds: 007b   es: 007b   ss: 0068
> > > Process khubd (pid: 10, threadinfo=dedec000 task=dedef770)
> > > Stack: debf2888 debf2854 c02e9f48 c639e200 debf2854 de40a670 debf2864
> > > c04c67a0
> > >        c0272926 debf2864 debf288c debf2864 c308acd0 c0272a4d debf2864
> > > debf28bc
> > >        debf2864 c308acd0 c0271b06 debf2864 debf2864 c308ac00 c0271b57
> > > debf2864
> > > Call Trace:
> > >  [<c02e9f48>] usb_unbind_interface+0x7a/0x7c
> > >  [<c0272926>] device_release_driver+0x64/0x66
> > >  [<c0272a4d>] bus_remove_device+0x56/0x98
> > >  [<c0271b06>] device_del+0x5f/0x9d
> > >  [<c0271b57>] device_unregister+0x13/0x23
> > >  [<c02eff98>] usb_disable_device+0x71/0xac
> > >  [<c02eaa32>] usb_disconnect+0x9c/0xeb
> > >  [<c02ecb1d>] hub_port_connect_change+0x274/0x279
> > >  [<c02ec509>] hub_port_status+0x45/0xb0
> > >  [<c02ece0b>] hub_events+0x2e9/0x364
> > >  [<c02eceb3>] hub_thread+0x2d/0xe8
> > >  [<c0105f86>] ret_from_fork+0x6/0x14
> > >  [<c011a3a1>] default_wake_function+0x0/0x12
> > >  [<c02ece86>] hub_thread+0x0/0xe8
> > >  [<c0104271>] kernel_thread_helper+0x5/0xb
> > >
> > > Code: 0f 0b 50 03 05 a6 43 c0 e9 7c ff ff ff c7 80 e0 01 00 00 00
> > >
> > >
> > > Five seconds later, this comes out:
> > >
> > >  <1>Unable to handle kernel paging request at virtual address 31a875c8
> > >  printing eip:
> > > c0307b2b
> > > *pde = 00000000
> > > Oops: 0002 [#2]
> > > PREEMPT SMP
> > > CPU:    0
> > > EIP:    0060:[<c0307b2b>]    Not tainted
> > > EFLAGS: 00010002   (2.6.6)
> > > EIP is at usb_stor_control_thread+0x14d/0x2c9
> > > eax: 31a875c8   ebx: c639e200   ecx: c639e200   edx: 00002003
> > > esi: c639e600   edi: d3c84000   ebp: d3c84000   esp: d3c85f9c
> > > ds: 007b   es: 007b   ss: 0068
> > > Process usb-storage (pid: 10290, threadinfo=d3c84000 task=c76b0130)
> > > Stack: dec00800 c639e200 c76b0698 c639e310 c639e324 c76b0130 c13e5ca0
> > > dededda8
> > >        c0105f86 dedef770 c03079de 00000000 c639e200 00000000 00000000
> > > 00000000
> > >        00000000 c03079de 00000000 00000000 00000000 c0104271 c639e200
> > > 00000000
> > > Call Trace:
> > >  [<c0105f86>] ret_from_fork+0x6/0x14
> > >  [<c03079de>] usb_stor_control_thread+0x0/0x2c9
> > >  [<c03079de>] usb_stor_control_thread+0x0/0x2c9
> > >  [<c0104271>] kernel_thread_helper+0x5/0xb
> > >
> > > Code: f0 fe 08 0f 88 38 0b 00 00 8b 83 b8 00 00 00 81 b8 50 01 00
> > >  <6>note: usb-storage[10290] exited with preempt_count 1
> > >
> > >
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> --
> http://www.PowerDNS.com      Open source, database driven DNS Software
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
>
