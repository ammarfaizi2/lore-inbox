Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbVJQV2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbVJQV2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 17:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbVJQV2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 17:28:05 -0400
Received: from styx.suse.cz ([82.119.242.94]:48849 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932335AbVJQV2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 17:28:04 -0400
Date: Mon, 17 Oct 2005 23:27:21 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Brice Goglin <Brice.Goglin@ens-lyon.org>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.14-rc4-mm1
Message-ID: <20051017212721.GA8997@midnight.suse.cz>
References: <20051016154108.25735ee3.akpm@osdl.org> <43539762.2020706@ens-lyon.org> <20051017132242.2b872b08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051017132242.2b872b08.akpm@osdl.org>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 01:22:42PM -0700, Andrew Morton wrote:
> Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
> >
> > Le 17.10.2005 00:41, Andrew Morton a écrit :
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc4/2.6.14-rc4-mm1/
> > > 
> > > - Lots of i2c, PCI and USB updates
> > > 
> > > - Large input layer update to convert it all to dynamic input_dev allocation
> > > 
> > > - Significant x86_64 updates
> > > 
> > > - MD updates
> > > 
> > > - Lots of core memory management scalability rework
> > 
> > Hi Andrew,
> > 
> > I got the following oops during the boot on my laptop (Compaq Evo N600c).
> > .config is attached.
> > 
> > Regards,
> > Brice

Where did get support for IBM TrackPoints into that kernel? It's
certainly not in 2.6.14, and it's not in the -mm patch either ...

That's likely the cause here, since the TP patch probably relies on
non-dynamic allocation semantics.

> > IBM TrackPoint firmware: 0x0b, buttons: 2/3
> > input: TPPS/2 IBM TrackPoint//class/input_dev as input2
> > hw_random hardware driver 1.0.0 loaded
> > NET: Registered protocol family 23
> > parport: PnPBIOS parport detected.
> > parport0: PC-style at 0x378, irq 7 [PCSPP(,...)]
> > c01dda09
> > PREEMPT
> > Modules linked in: pcspkr parport_pc parport irtty_sir sir_dev irda
> > crc_ccitt hw_random uhci_hcd usbcore snd_maestro3 snd_ac97_codec
> > snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
> > snd soundcore yenta_socket rsrc_nonstatic pcmcia_core nls_iso8859_15
> > nls_cp850 vfat fat nls_base psmouse
> > CPU:    0
> > EIP:    0060:[<c01dda09>]    Not tainted VLI
> > EFLAGS: 00010246   (2.6.14-rc4-mm1=LoulousMobile)
> > EIP is at get_kobj_path_length+0x19/0x30
> > eax: 00000000   ebx: 00000000   ecx: ffffffff   edx: e6efee50
> > esi: 00000001   edi: 00000000   ebp: e737eec8   esp: e737eebc
> > ds: 007b   es: 007b   ss: 0068
> > Process sed (pid: 3258, threadinfo=e737e000 task=e7970a90)
> > Stack: e6efe800 00000001 e6de4000 e737eee8 c01dda9a e6efee50 e6de42e4
> > 00000286
> >        e6efe800 00000001 e6de4000 e737ef24 c02a357f e6efee50 800000d0
> > 0000000f
> >        00000002 0000000a 00000000 e6efe800 00000000 000002e5 000002e5
> > e7e9ce60
> > Call Trace:
> >  [<c010414b>] show_stack+0xab/0xf0
> >  [<c010433f>] show_registers+0x18f/0x230
> >  [<c0104592>] die+0x102/0x1c0
> >  [<c035f27a>] do_page_fault+0x33a/0x66f
> >  [<c0103dbb>] error_code+0x4f/0x54
> >  [<c01dda9a>] kobject_get_path+0x1a/0x70
> >  [<c02a357f>] input_devices_read+0x53f/0x590
> >  [<c01a2e75>] proc_file_read+0x1b5/0x260
> >  [<c01689f8>] vfs_read+0xa8/0x190
> >  [<c0168dc7>] sys_read+0x47/0x70
> >  [<c0103325>] syscall_call+0x7/0xb
> > Code: f8 89 ec 5d c3 8d b6 00 00 00 00 8d bc 27 00 00 00 00 55 89 e5 8b
> > 55 08 57 56 be 01 00 00 00 53 31 db 8b 3a b9 ff ff ff ff 89 d8 <f2> ae
> > f7 d1 49 8b 52 24 8d 74 31 01 85 d2 75 e7 5b 89 f0 5e 5f
> > <6>input: isa0061/input0//class/input_dev as input3
> 
> Something went wrong under input_devices_read().   Probably culprits cc'ed.
> 
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
