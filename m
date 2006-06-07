Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWFGC5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWFGC5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 22:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWFGC5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 22:57:54 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:41445 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750767AbWFGC5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 22:57:54 -0400
Date: Tue, 6 Jun 2006 22:54:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [GIT] BUG: unable to handle kernel paging request
To: Marc Koschewski <marc@osknowledge.org>
Cc: Patrick Boettcher <pb@linuxtv.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606062256_MC3-1-C1CC-4939@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060606085308.GA11358@stiffy.osknowledge.org>

On Tue, 6 Jun 2006 10:53:08 +0200, Marc Koschewski wrote:

> The thing was plugging in an USB DVB-T adapter and running gxine on it. gxine
> seems to be unable to 'get a lock' and I have to kill it. After killing gxine I
> just tried again with no success and thus removed the USB device from the bus.

> BUG: unable to handle kernel paging request at virtual address f8fae04c
>  printing eip:
> f9009e8f
> *pde = 47e39067
> Oops: 0000 [#2]
> PREEMPT 
> Modules linked in: snd_pcm_oss snd_mixer_oss af_packet ohci_hcd ehci_hcd floppy pcspkr
rtc isofs zlib_inflate ircomm_tty ircomm irda crc_ccitt hidp bnep hci_uart rfcomm l2cap
bluetooth cpufreq_stats cpufreq_ondemand speedstep_ich speedstep_lib freq_table i8k
backlight lcd snd_seq_oss snd_seq_midi_event snd_seq_dummy snd_seq snd_seq_device loop
usb_storage scsi_mod video fan button battery ac thermal processor usbtest eth1394
dvb_usb_dibusb_mb dvb_usb_dibusb_common dib3000mc dvb_usb dvb_core dvb_pll dib3000mb
serial_cs dib3000_common pcmcia acx firmware_class tsdev mousedev hw_random nvidiafb
nvidia snd_intel8x0 snd_intel8x0m snd_ac97_codec snd_ac97_bus uhci_hcd snd_pcm usbcore
intel_agp snd_timer evdev agpgart snd i2c_core ohci1394 parport_pc psmouse 3c59x
soundcore mii snd_page_alloc ieee1394 parport ide_cd serio_raw yenta_socket
rsrc_nonstatic pcmcia_core cdrom unix
> CPU:    0
> EIP:    0060:[<f9009e8f>]    Tainted: P      VLI
> EFLAGS: 00010282   (2.6.17-rc5-marc-g705af309 #144) 
> EIP is at dvb_demux_release+0xa/0x150 [dvb_core]
> eax: f7ae3d10   ebx: f8fae000   ecx: f9009e85   edx: bff849c0
> esi: bff849c0   edi: f7ae3d10   ebp: f7b227dc   esp: bf7c0e10
> ds: 007b   es: 007b   ss: 0068
> Process gxine (pid: 12832, threadinfo=bf7c0000 task=bf7c1a70)
> Stack: f7ae3e38 00000008 bff849c0 f7ae3d10 f7b227dc b0159f14 00000000 b1b94ec0 
>        bff849c0 00000000 f7974380 f7974380 b0157602 e236fce0 00001fff f7974388 
>        00000000 b011996e 00000000 00000000 00000044 f7974380 bf7c1a70 00000001 
> Call Trace:
>  [<b0159f14>] __fput+0x8b/0x1c1
>  [<b0157602>] filp_close+0x3e/0x62
>  [<b011996e>] put_files_struct+0xa3/0xc7
>  [<b011ac7d>] do_exit+0x159/0x997
>  [<b012178f>] __dequeue_signal+0xb8/0x192
>  [<b011b4e3>] do_group_exit+0x28/0x81
>  [<b012376c>] get_signal_to_deliver+0x26a/0x410
>  [<b01024b1>] do_notify_resume+0x72/0x667
>  [<b015a195>] fget_light+0x83/0xa4
>  [<f8830b28>] unix_listen+0x5b/0xd6 [unix]
>  [<b025f2b0>] sys_socketcall+0xe9/0x294
>  [<b0102e7e>] work_notifysig+0x13/0x19
> Code: 8b 13 85 d2 74 0b 8b 4b 04 89 c8 ff 91 e4 10 00 00 89 d8 e8 a2 f9 ff ff c7 43 04 00 00 00 00 eb c5 55 57 56 53 83 ec 04 8b 5a 74 <8b> 73 4c 83 c6 38 89 f0 e8 2e 89 2b b7 ba 00 fe ff ff 85 c0 74 

  21:   55                        push   %ebp
  22:   57                        push   %edi
  23:   56                        push   %esi
  24:   53                        push   %ebx
  25:   83 ec 04                  sub    $0x4,%esp
  28:   8b 5a 74                  mov    0x74(%edx),%ebx
   0:   8b 73 4c                  mov    0x4c(%ebx),%esi   <=====
   3:   83 c6 38                  add    $0x38,%esi
   6:   89 f0                     mov    %esi,%eax
   8:   e8 2e 89 2b b7            call   b72b893b <_EIP+0xb72b893b>
   d:   ba 00 fe ff ff            mov    $0xfffffe00,%edx
  12:   85 c0                     test   %eax,%eax

static int dvb_demux_release(struct inode *inode, struct file *file)
{
        struct dmxdev_filter *dmxdevfilter = file->private_data;
        struct dmxdev *dmxdev = dmxdevfilter->dev;         <=====

        return dvb_dmxdev_filter_free(dmxdev, dmxdevfilter);
}

Looks like the device went away while it was open?

-- 
Chuck

