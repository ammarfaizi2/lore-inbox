Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWIZVE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWIZVE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWIZVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 17:04:26 -0400
Received: from smtp-vbr17.xs4all.nl ([194.109.24.37]:50440 "EHLO
	smtp-vbr17.xs4all.nl") by vger.kernel.org with ESMTP
	id S932398AbWIZVEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 17:04:24 -0400
From: Hans Verkuil <hverkuil@xs4all.nl>
To: "Sowadski. Craig" <sowadski@gmail.com>
Subject: Re: BUG - No audio from BTTV/MSP3400 Capture Card with >=2.6.17
Date: Tue, 26 Sep 2006 23:04:19 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <8fe407840609251458q743c0b42k1d5f89190e39d0e0@mail.gmail.com>
In-Reply-To: <8fe407840609251458q743c0b42k1d5f89190e39d0e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262304.20296.hverkuil@xs4all.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Craig,

This is a known problem that I'm working on. The msp343x series of chips 
are as far as I can tell prereleases of the later chips of the 'G' 
model series, and they do not support the Automatic Standard Detection 
and they are NTSC (BTSC) only. Unfortunately, the datasheets provide 
almost no information whatsoever about these chips, so they are not 
very helpful.

The big rewrite/cleanup of the msp3400 driver that I did was all based 
on the information available to me through the datasheets, and since 
the datasheets didn't refer to a 3430 at all I also didn't take that 
into account. I'm now working together with someone else who has a 3435 
to try and fix this problem.

I wonder if you are able to do the following test for me: upgrade to 
2.6.18 and try to load the msp3400 module with the following module 
option: standard=32

See if that makes a difference. If it doesn't, then try again, but this 
time use the module options 'standard=32 once=1'. Let me know what the 
results are. (Why upgrade to 2.6.18? Because 2.6.17 has a bug in the 
handling of the 'standard' option which was fixed in 2.6.18.)

Thanks,

	Hans

On Monday 25 September 2006 23:58, Sowadski. Craig wrote:
> I cannot get any audio from my hauppauge wintv PCI capture card with
> kernels newer than 2.6.16. Below is the dmesg form both a working
> 2.6.16  and non-working 2.6.17. Please let me know if there is any
> more
> information needed or how I might be able to help debug this problem.
> Note that the audio is routed from the internal sound port to the
> CD-Input on the sound card.
>
> Thanks,
>
> PLEASE CC ME ON REPLYS
> Craig (sowadski@gmail.com)
>
> DMESG from 2.6.16 with working  sound:
>
> Linux video capture interface: v1.00
> bttv: driver version  0.9.16 loaded
> bttv: using 8 buffers with 2080k (520 pages) each for  capture
> bttv: Bt8xx card found (0).
> ACPI: PCI Interrupt Link [APC2]  enabled at IRQ 17
> GSI 18 sharing vector 0xC1 and IRQ 18
> ACPI: PCI  Interrupt 0000:02:07.0[A] -> Link [APC2] -> GSI 17 (level,
> low) -> IRQ 193
> bttv0: Bt878 (rev 2) at 0000:02:07.0, irq: 193, latency: 32,  mmio:
> 0xfddff000
> bttv0: detected: Hauppauge WinTV [card=10], PCI  subsystem ID is
> 0070:13eb bttv0: using: Hauppauge (bt878)  [card=10,autodetected]
> bttv0: gpio: en=00000000, out=00000000 in=00ffffdb  [init]
> bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
> tveeprom  4-0050: Hauppauge model 61381, rev D123, serial# 1447578
> tveeprom 4-0050:  tuner model is Philips FM1236 (idx 23, type 2)
> tveeprom 4-0050: TV standards  NTSC(M) (eeprom 0x08)
> tveeprom 4-0050: audio processor is MSP3430 (idx  7)
> tveeprom 4-0050: has radio
> bttv0: Hauppauge eeprom indicates  model#61381
> bttv0: using tuner=2
> bttv0: registered device video0
> bttv0:  registered device vbi0
> bttv0: registered device radio0
> bttv0: PLL:  28636363 => 35468950 .. ok
> msp3400 4-0040: msp_reset
> msp3400 4-0040:  msp_read(0x12, 0x1e): 0x107
> msp3400 4-0040: msp_read(0x12, 0x1f):  0x1e41
> msp3400 4-0040: rev1=0x0107, rev2=0x1e41
> msp3400 4-0040: mute=off  volume=58880
> msp3400 4-0040: msp_write(0x12, 0x0, 0x7200)
> msp3400 4-0040:  msp_write(0x12, 0x7, 0x7201)
> msp3400 4-0040: MSP3430G-A1 found @ 0x80 (bt878  #0 [sw])
> msp3400 4-0040: MSP3430G-A1 supports radio, mode is autodetect and
> autoselect
> msp3400 4-0040: mute audio
> msp3400 4-0040: msp_write(0x12,  0x0, 0x0)
> msp3400 4-0040: msp_write(0x12, 0x7, 0x1)
> msp3400 4-0040:  msp_write(0x12, 0x40, 0x1)
> msp3400 4-0040: msp_write(0x12, 0x6,  0x0)
> msp3400 4-0040: msp34xxg daemon started
> msp3400 4-0040: msp34xxg  thread: sleep
> input: i2c IR (Hauppauge) as /class/input/input0
> ir-kbd-i2c:  i2c IR (Hauppauge) detected at i2c-4/4-0018/ir0 [bt878
> #0 [sw]] tuner 4-0061:  chip found @ 0xc2 (bt878 #0 [sw])
> tuner 4-0061: type set to 2 (Philips NTSC  (FI1236,FM1236 and
> compatibles)) Sep  3 23:56:11 [kernel] msp3400 4-0040:  mute audio
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x0,  0x0)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,  0x1)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x40,  0x1)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x6,  0x0)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp34xxg thread: wakeup
> Sep   3 23:56:11 [kernel] msp3400 4-0040: thread: restart scan
> Sep  3 23:56:11  [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:56:11 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13,
> 0xf20) Sep  3 23:56:11 [kernel] msp3400 4-0040:  msp_write(0x10,
> 0x40, 0x0) Sep  3 23:56:11 [kernel] msp3400 4-0040: video  mode
> selected to PAL Sep  3 23:56:11 [kernel] msp3400 4-0040:
> msp_write(0x10,  0x30, 0x7001) Sep  3 23:56:11 [kernel] msp3400
> 4-0040: msp_write(0x10, 0x20,  0x1) Sep  3 23:56:11 [kernel] msp3400
> 4-0040: set source to 1 (0x120) Sep   3 23:56:11 [kernel] msp3400
> 4-0040: msp_write(0x12, 0x8, 0x120) Sep  3  23:56:11 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xa, 0x120) Sep  3 23:56:11  [kernel] msp3400
> 4-0040: msp_write(0x12, 0xc, 0x120) Sep  3 23:56:11 [kernel]  msp3400
> 4-0040: msp_write(0x10, 0x22, 0x190) Sep  3 23:56:11 [kernel] msp3400
>  4-0040: msp_write(0x12, 0xe, 0x3000) Sep  3 23:56:11 [kernel]
> msp3400 4-0040:  msp_write(0x12, 0x10, 0x5a00) Sep  3 23:56:11
> [kernel] msp3400 4-0040:  triggered autodetect, waiting for result
> Sep  3 23:56:11 [kernel] msp3400  4-0040: mute audio
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12,  0x0, 0x0)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,  0x1)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x40,  0x1)
> Sep  3 23:56:11 [kernel] msp3400 4-0040: msp_write(0x12, 0x6,  0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: thread: restart scan
> Sep  3  23:56:12 [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12, 0x13,
> 0xf20) Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10,
> 0x40, 0x0) Sep  3 23:56:12 [kernel] msp3400 4-0040: video  mode
> selected to PAL Sep  3 23:56:12 [kernel] msp3400 4-0040:
> msp_write(0x10,  0x30, 0x7001) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x10, 0x20,  0x1) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: set source to 1 (0x120) Sep   3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0x8, 0x120) Sep  3  23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xa, 0x120) Sep  3 23:56:12  [kernel] msp3400
> 4-0040: msp_write(0x12, 0xc, 0x120) Sep  3 23:56:12 [kernel]  msp3400
> 4-0040: msp_write(0x10, 0x22, 0x190) Sep  3 23:56:12 [kernel] msp3400
>  4-0040: msp_write(0x12, 0xe, 0x3000) Sep  3 23:56:12 [kernel]
> msp3400 4-0040:  msp_write(0x12, 0x10, 0x5a00) Sep  3 23:56:12
> [kernel] msp3400 4-0040:  triggered autodetect, waiting for result
> Sep  3 23:56:12 [kernel] bttv0:  PLL can sleep, using XTAL
> (28636363). Sep  3 23:56:12 [kernel] msp3400  4-0040: mute audio
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,  0x0, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,  0x1)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x40,  0x1)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x6,  0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: thread: restart scan
> Sep  3  23:56:12 [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12, 0x13,
> 0xf20) Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10,
> 0x40, 0x0) Sep  3 23:56:12 [kernel] msp3400 4-0040: video  mode
> selected to NTSC Sep  3 23:56:12 [kernel] msp3400 4-0040: 
> msp_write(0x10, 0x30, 0x2001) Sep  3 23:56:12 [kernel] msp3400
> 4-0040:  msp_write(0x10, 0x20, 0x20) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: set  source to 1 (0x120) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12,  0x8, 0x120) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xa,  0x120) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xc,  0x120) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x10, 0x22,  0x190) Sep  3 23:56:12 [kernel]
> msp3400 4-0040: msp_write(0x12, 0xe,  0x3000) Sep  3 23:56:12
> [kernel] msp3400 4-0040: msp_write(0x12, 0x10,  0x5a00) Sep  3
> 23:56:12 [kernel] msp3400 4-0040: triggered autodetect,  waiting for
> result
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_read(0x10, 0x200): 0x6
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  status=0x6, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x6
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: status=0x6, stereo=0,
> bilingual=0  ->
> rxsubchans=1
> Sep  3 23:56:12 [kernel] msp3400 4-0040: mute=off  volume=58880
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x0, 
> 0x7200) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,
>  0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,
> 0x40,  0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040:
> msp_write(0x12, 0x6,  0x7200) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x1, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x2, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x3, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: set  source to 1 (0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,  0x8, 0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0xa,  0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0xc,  0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x10, 0x22, 
> 0x190) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_read(0x10,
> 0x200):  0x6 Sep  3 23:56:12 [kernel] msp3400 4-0040: status=0x6,
> stereo=0, bilingual=0 ->
> rxsubchans=1
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x6
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  status=0x6, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:56:12  [kernel] msp3400 4-0040: mute=off volume=58880
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x12, 0x0,
> 0x7200) Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12,
> 0x7, 0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x40, 0x7201) Sep  3 23:56:12 [kernel] msp3400
> 4-0040:  msp_write(0x12, 0x6, 0x7200) Sep  3 23:56:12 [kernel]
> msp3400 4-0040:  balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_read(0x10, 0x7e): 0x0
> Sep  3 23:56:12 [kernel] msp3400 4-0040: current  standard: could not
> detect sound standard (0x0000)
> Sep  3 23:56:12  [kernel] msp3400 4-0040: mute=off volume=58880
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x12, 0x0,
> 0x7200) Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12,
> 0x7, 0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x40, 0x7201) Sep  3 23:56:12 [kernel] msp3400
> 4-0040:  msp_write(0x12, 0x6, 0x7200) Sep  3 23:56:12 [kernel]
> msp3400 4-0040:  balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10, 0x40, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp34xxg  thread: sleep
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x33,  0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: set source to 4 (0x420)
> Sep   3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x8, 0x420)
> Sep  3  23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0xa, 0x420)
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_write(0x12, 0xc, 0x420)
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x10, 0x22,
> 0x190) Sep  3 23:56:12 [kernel] msp3400  4-0040: mute audio
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,  0x0, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,  0x1)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x40,  0x1)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x6,  0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp34xxg thread: wakeup
> Sep   3 23:56:12 [kernel] msp3400 4-0040: thread: restart scan
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13,
> 0xf20) Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10,
> 0x40, 0x0) Sep  3 23:56:12 [kernel] msp3400 4-0040: video  mode
> selected to NTSC Sep  3 23:56:12 [kernel] msp3400 4-0040: 
> msp_write(0x10, 0x30, 0x2001) Sep  3 23:56:12 [kernel] msp3400
> 4-0040:  msp_write(0x10, 0x20, 0x20) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: set  source to 4 (0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12,  0x8, 0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xa,  0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xc,  0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x10, 0x22,  0x190) Sep  3 23:56:12 [kernel]
> msp3400 4-0040: msp_write(0x12, 0xe,  0x3000) Sep  3 23:56:12
> [kernel] msp3400 4-0040: msp_write(0x12, 0x10,  0x5a00) Sep  3
> 23:56:12 [kernel] msp3400 4-0040: triggered autodetect,  waiting for
> result
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_read(0x10, 0x7e): 0x0
> Sep  3 23:56:12 [kernel] msp3400 4-0040: current  standard: could not
> detect sound standard (0x0000)
> Sep  3 23:56:12  [kernel] msp3400 4-0040: mute=off volume=58880
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x12, 0x0,
> 0x7200) Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12,
> 0x7, 0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x40, 0x7201) Sep  3 23:56:12 [kernel] msp3400
> 4-0040:  msp_write(0x12, 0x6, 0x7200) Sep  3 23:56:12 [kernel]
> msp3400 4-0040:  balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10, 0x40, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp34xxg  thread: sleep
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_read(0x10, 0x200):  0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0  ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400  4-0040: mute audio
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,  0x0, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,  0x1)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x40,  0x1)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x6,  0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp34xxg thread: wakeup
> Sep   3 23:56:12 [kernel] msp3400 4-0040: thread: restart scan
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13,
> 0xf20) Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10,
> 0x40, 0x0) Sep  3 23:56:12 [kernel] msp3400 4-0040: video  mode
> selected to NTSC Sep  3 23:56:12 [kernel] msp3400 4-0040: 
> msp_write(0x10, 0x30, 0x2001) Sep  3 23:56:12 [kernel] msp3400
> 4-0040:  msp_write(0x10, 0x20, 0x20) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: set  source to 4 (0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12,  0x8, 0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xa,  0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x12, 0xc,  0x420) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: msp_write(0x10, 0x22,  0x190) Sep  3 23:56:12 [kernel]
> msp3400 4-0040: msp_write(0x12, 0xe,  0x3000) Sep  3 23:56:12
> [kernel] msp3400 4-0040: msp_write(0x12, 0x10,  0x5a00) Sep  3
> 23:56:12 [kernel] msp3400 4-0040: triggered autodetect,  waiting for
> result
> Sep  3 23:56:12 [kernel] msp3400 4-0040: mute=off  volume=58880
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x0, 
> 0x7200) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,
>  0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,
> 0x40,  0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040:
> msp_write(0x12, 0x6,  0x7200) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x1, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x2, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x3, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: set  source to 1 (0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,  0x8, 0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0xa,  0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0xc,  0x120)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x10, 0x22, 
> 0x190) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_read(0x10,
> 0x200):  0x44 Sep  3 23:56:12 [kernel] msp3400 4-0040: status=0x44,
> stereo=64, bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_read(0x10, 0x7e): 0x0
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: current standard: could not
> detect sound standard  (0x0000)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: mute=off  volume=58880
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x0, 
> 0x7200) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12, 0x7,
>  0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_write(0x12,
> 0x40,  0x7201) Sep  3 23:56:12 [kernel] msp3400 4-0040:
> msp_write(0x12, 0x6,  0x7200) Sep  3 23:56:12 [kernel] msp3400
> 4-0040: balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x1, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x2, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x3, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  msp_write(0x10, 0x40, 0x0)
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp34xxg  thread: sleep
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_read(0x10, 0x200):  0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:12 [kernel]  msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0  ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:12 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:12 [kernel] msp3400 4-0040:  status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:13  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:13 [kernel]  msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0  ->
> rxsubchans=2
> Sep  3 23:56:13 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x44
> Sep  3 23:56:13 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:13 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:13 [kernel] msp3400 4-0040:  status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:13  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:13 [kernel]  msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0  ->
> rxsubchans=2
> Sep  3 23:56:13 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x44
> Sep  3 23:56:13 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:13 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:13 [kernel] msp3400 4-0040:  status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
> Sep  3 23:56:13  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x44
> Sep  3 23:56:13 [kernel]  msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0  ->
> rxsubchans=2
> Sep  3 23:56:13 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x44
> Sep  3 23:56:13 [kernel] msp3400 4-0040: status=0x44, stereo=64,
> bilingual=0 ->
> rxsubchans=2
>
>
> DMESG from 2.6.17 without  working sound:
>
> Sep  3 23:39:33 [kernel] Linux video capture interface:  v1.00
> Sep  3 23:39:33 [kernel] bttv: driver version 0.9.16 loaded
> Sep  3  23:39:33 [kernel] bttv: using 8 buffers with 2080k (520
> pages) each for
> capture
> Sep  3 23:39:33 [kernel] bttv: Bt8xx card found  (0).
> Sep  3 23:39:33 [kernel] ACPI: PCI Interrupt Link [APC2] enabled at
> IRQ  17 Sep  3 23:39:33 [kernel] GSI 18 sharing vector 0xC1 and IRQ
> 18 Sep  3  23:39:33 [kernel] ACPI: PCI Interrupt 0000:02:07.0[A] ->
> Link [APC2]  ->
> GSI 17 (level, low) -> IRQ 193
> Sep  3 23:39:33 [kernel] bttv0:  Bt878 (rev 2) at 0000:02:07.0, irq:
> 193, latency: 32, mmio:  0xfddff000
> Sep  3 23:39:33 [kernel] bttv0: detected: Hauppauge WinTV  [card=10],
> PCI subsystem ID is 0070:13eb
> Sep  3 23:39:33 [kernel] bttv0:  using: Hauppauge (bt878)
> [card=10,autodetected]
> Sep  3 23:39:33 [kernel]  bttv0: gpio: en=00000000, out=00000000
> in=00ffffdb [init]
> Sep  3 23:39:33  [kernel] bttv0: Hauppauge/Voodoo msp34xx: reset line
> init [5]
> Sep  3  23:39:33 [kernel] tveeprom 4-0050: Hauppauge model 61381, rev
> D023, serial#  1447578
> Sep  3 23:39:33 [kernel] tveeprom 4-0050: tuner model is Philips 
> FM1236 (idx 23,
> type 2)
> Sep  3 23:39:33 [kernel] tveeprom 4-0050: TV  standards NTSC(M)
> (eeprom 0x08) Sep  3 23:39:33 [kernel] tveeprom 4-0050:  audio
> processor is MSP3430 (idx 7) Sep  3 23:39:33 [kernel] tveeprom
> 4-0050:  has radio
> Sep  3 23:39:33 [kernel] bttv0: Hauppauge eeprom indicates 
> model#61381 Sep  3 23:39:33 [kernel] bttv0: using tuner=2
> Sep  3 23:39:33  [kernel] bttv0: registered device video0
> Sep  3 23:39:33 [kernel] bttv0:  registered device vbi0
> Sep  3 23:39:33 [kernel] bttv0: registered device  radio0
> Sep  3 23:39:33 [kernel] bttv0: PLL: 28636363 => 35468950 ..  ok
> Sep  3 23:39:33 [kernel] tvaudio 4-0040: chip found @ 0x80
> Sep  3  23:39:33 [kernel] tvaudio 4-0040: no matching chip
> description found Sep  3  23:39:33 [kernel] input: i2c IR (Hauppauge)
> as /class/input/input0 Sep  3  23:39:33 [kernel] ir-kbd-i2c: i2c IR
> (Hauppauge) detected at i2c-4/4-0018/ir0  [bt878 #0 [sw]]
> Sep  3 23:39:33 [kernel] msp3400 4-0040: msp_reset
> Sep  3  23:39:33 [kernel] msp3400 4-0040: msp_read(0x12, 0x1e): 0x107
> Sep  3 23:39:33  [kernel] msp3400 4-0040: msp_read(0x12, 0x1f):
> 0x1e41 Sep  3 23:39:33  [kernel] msp3400 4-0040: rev1=0x0107,
> rev2=0x1e41 Sep  3 23:39:33 [kernel]  msp3400 4-0040: mute=off
> scanning=no volume=58880 Sep  3 23:39:33 [kernel]  msp3400 4-0040:
> msp_write(0x12, 0x0, 0x7200) Sep  3 23:39:33 [kernel] msp3400 
> 4-0040: msp_write(0x12, 0x7, 0x7201) Sep  3 23:39:33 [kernel] msp3400
> 4-0040:  MSP3430G-A1 found @ 0x80 (bt878 #0 [sw])
> Sep  3 23:39:33 [kernel] msp3400  4-0040: MSP3430G-A1 supports radio,
> mode is autodetect and autoselect
> Sep   3 23:39:33 [kernel] msp3400 4-0040: msp34xxg daemon started
> Sep  3 23:39:33  [kernel] msp3400 4-0040: msp34xxg thread: sleep
> Sep  3 23:39:33 [kernel]  tuner 4-0061: chip found @ 0xc2 (bt878 #0
> [sw]) Sep  3 23:39:33 [kernel]  tuner 4-0061: type set to 2 (Philips
> NTSC (FI1236,FM1236 and  compatibles))
> Sep  3 23:42:56 [kernel] msp3400 4-0040: msp34xxg thread:  wakeup
> Sep  3 23:42:56 [kernel] msp3400 4-0040: thread: restart scan
> Sep   3 23:42:56 [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:42:56 [kernel]  msp3400 4-0040: msp_write(0x10, 0x40, 0x0)
> Sep  3 23:42:56 [kernel] msp3400  4-0040: selected PAL modus
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x10, 0x30,
> 0x7001) Sep  3 23:42:56 [kernel] msp3400 4-0040: set  source to 0
> (0x320) for output 08
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0x8, 0x320)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  set source to 0 (0x320) for
> output 0c
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0xc, 0x320)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  set source to 0 (0x320) for
> output 09
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0x9, 0x320)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  set source to 0 (0x320) for
> output 0a
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0xa, 0x320)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  set source to 0 (0x320) for
> output 41
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0x41,
> 0x320) Sep  3 23:42:56 [kernel] msp3400 4-0040:  set source to 0
> (0x320) for output 0b
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0xb, 0x320)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12, 0xd,
> 0x1900) Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12,
> 0xe, 0x3000) Sep  3 23:42:56 [kernel] msp3400 4-0040: 
> msp_write(0x10, 0x22, 0x190) Sep  3 23:42:56 [kernel] msp3400 4-0040:
>  msp_write(0x10, 0x20, 0x1) Sep  3 23:42:56 [kernel] msp3400 4-0040:
> started  autodetect, waiting for result
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  mute=on scanning=no
> volume=58880 Sep  3 23:42:56 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x0, 0x0) Sep  3 23:42:56 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x7, 0x1) Sep  3 23:42:56 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x40, 0x1) Sep  3 23:42:56 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x6, 0x0) Sep  3 23:42:56 [kernel] msp3400 4-0040: 
> balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:42:56  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:42:56 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:42:56 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:42:56 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:42:56 [kernel] bttv0: PLL can sleep,  using XTAL
> (28636363). Sep  3 23:42:57 [kernel] msp3400 4-0040: thread:  restart
> scan Sep  3 23:42:57 [kernel] msp3400 4-0040: msp_reset
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x10, 0x40, 0x0)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: selected M (BTSC) modus
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x10, 0x30,
> 0x2001) Sep  3 23:42:57 [kernel]  msp3400 4-0040: set source to 0
> (0x320) for output 08
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x8, 0x320)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: set source to 0 (0x320) for
> output 0c
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0xc, 0x320)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: set source to 0 (0x320) for
> output 09
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x9, 0x320)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: set source to 0 (0x320) for
> output 0a
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0xa, 0x320)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: set source to 0 (0x320) for
> output 41
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x41,
> 0x320) Sep  3 23:42:57  [kernel] msp3400 4-0040: set source to 0
> (0x320) for output 0b
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0xb, 0x320)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0xd,
> 0x1900) Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12,
> 0xe, 0x3000) Sep  3 23:42:57  [kernel] msp3400 4-0040:
> msp_write(0x10, 0x22, 0x190) Sep  3 23:42:57  [kernel] msp3400
> 4-0040: msp_write(0x10, 0x20, 0x1) Sep  3 23:42:57 [kernel]  msp3400
> 4-0040: started autodetect, waiting for result
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0  ->
> rxsubchans=1
> Sep  3 23:42:57 [kernel] msp3400 4-0040: mute=on  scanning=no
> volume=58880 Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x0, 0x0) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x7, 0x1) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x40, 0x1) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x6, 0x0) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:42:57  [kernel] msp3400 4-0040: set source to 0 (0x420) for
> output 08
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0x8, 0x420)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: set source to 0 (0x420) for
> output 0c
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0xc, 0x420)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: set source to 0 (0x420) for
> output 09
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0x9, 0x420)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: set source to 0 (0x420) for
> output 0a
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0xa, 0x420)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: set source to 0 (0x420) for
> output 41
> Sep  3  23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0x41,
> 0x420) Sep  3  23:42:57 [kernel] msp3400 4-0040: set source to 0
> (0x420) for output 0b
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp_write(0x12, 0xb,  0x420)
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp_read(0x10, 0x7e):  0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040: detected standard: could not
>  detect sound standard (0x0000)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  mute=on scanning=no
> volume=58880 Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x0, 0x0) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x7, 0x1) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x40, 0x1) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x6, 0x0) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp34xxg  thread: sleep
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp34xxg thread:  wakeup
> Sep  3 23:42:57 [kernel] msp3400 4-0040: thread: restart scan
> Sep   3 23:42:57 [kernel] msp3400 4-0040: msp_reset
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x10, 0x40, 0x0)
> Sep  3 23:42:57 [kernel] msp3400  4-0040: selected M (BTSC) modus
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x10, 0x30,
> 0x2001) Sep  3 23:42:57 [kernel] msp3400 4-0040: set  source to 0
> (0x420) for output 08
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x8, 0x420)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  set source to 0 (0x420) for
> output 0c
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0xc, 0x420)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  set source to 0 (0x420) for
> output 09
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x9, 0x420)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  set source to 0 (0x420) for
> output 0a
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0xa, 0x420)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  set source to 0 (0x420) for
> output 41
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x41,
> 0x420) Sep  3 23:42:57 [kernel] msp3400 4-0040:  set source to 0
> (0x420) for output 0b
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0xb, 0x420)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0xd,
> 0x1900) Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12,
> 0xe, 0x3000) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x10, 0x22, 0x190) Sep  3 23:42:57 [kernel] msp3400 4-0040:
>  msp_write(0x10, 0x20, 0x1) Sep  3 23:42:57 [kernel] msp3400 4-0040:
> started  autodetect, waiting for result
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_read(0x10, 0x7e): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040: detected  standard: could
> not detect sound standard (0x0000)
> Sep  3 23:42:57  [kernel] msp3400 4-0040: mute=on scanning=no
> volume=58880 Sep  3 23:42:57  [kernel] msp3400 4-0040:
> msp_write(0x12, 0x0, 0x0) Sep  3 23:42:57 [kernel]  msp3400 4-0040:
> msp_write(0x12, 0x7, 0x1) Sep  3 23:42:57 [kernel] msp3400  4-0040:
> msp_write(0x12, 0x40, 0x1) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x6, 0x0) Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x13, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp34xxg  thread: sleep
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp_read(0x10, 0x200):  0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0  ->
> rxsubchans=1
> Sep  3 23:42:57 [kernel] msp3400 4-0040: mute=off  scanning=no
> volume=58880 Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x0, 0x7200) Sep  3 23:42:57 [kernel] msp3400 4-0040:
>  msp_write(0x12, 0x7, 0x7201) Sep  3 23:42:57 [kernel] msp3400
> 4-0040:  msp_write(0x12, 0x40, 0x7201) Sep  3 23:42:57 [kernel]
> msp3400 4-0040:  msp_write(0x12, 0x6, 0x7200) Sep  3 23:42:57
> [kernel] msp3400 4-0040:  balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040: mute=off  scanning=no
> volume=58880 Sep  3 23:42:57 [kernel] msp3400 4-0040: 
> msp_write(0x12, 0x0, 0x7200) Sep  3 23:42:57 [kernel] msp3400 4-0040:
>  msp_write(0x12, 0x7, 0x7201) Sep  3 23:42:57 [kernel] msp3400
> 4-0040:  msp_write(0x12, 0x40, 0x7201) Sep  3 23:42:57 [kernel]
> msp3400 4-0040:  msp_write(0x12, 0x6, 0x7200) Sep  3 23:42:57
> [kernel] msp3400 4-0040:  balance=32768 bass=32768 treble=32768
> loudness=0
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_write(0x12, 0x1, 0x0)
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: msp_write(0x12, 0x2, 0x0)
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_write(0x12, 0x3, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x4, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x30, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x31, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x32, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_write(0x12, 0x33, 0x0)
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0  ->
> rxsubchans=1
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:42:57 [kernel] msp3400  4-0040: msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040:  status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
> Sep  3 23:42:57  [kernel] msp3400 4-0040: msp_read(0x10, 0x200): 0x0
> Sep  3 23:42:57 [kernel]  msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0  ->
> rxsubchans=1
> Sep  3 23:42:57 [kernel] msp3400 4-0040: msp_read(0x10,  0x200): 0x0
> Sep  3 23:42:57 [kernel] msp3400 4-0040: status=0x0, stereo=0,
> bilingual=0 ->
> rxsubchans=1
>
> Please let me know if you need any  more information.
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
