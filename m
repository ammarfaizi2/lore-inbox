Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290685AbSARMvs>; Fri, 18 Jan 2002 07:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290686AbSARMvj>; Fri, 18 Jan 2002 07:51:39 -0500
Received: from raul.dif.um.es ([155.54.15.4]:30848 "EHLO raul.dif.um.es")
	by vger.kernel.org with ESMTP id <S290685AbSARMva>;
	Fri, 18 Jan 2002 07:51:30 -0500
Subject: via 686a compaq presario 700
From: Raul Sanchez Sanchez <raul@dif.um.es>
To: jgarzik@mandrakesoft.com
Cc: salvador@inti.gov.ar, Paul Lorenz <p1orenz@yahoo.com>,
        Jeremy Lumbroso <j.lumbroso@noos.fr>, ignacio@adesx.com,
        rubio@adesx.com, Jorge Carminati <jcarminati@yahoo.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 18 Jan 2002 13:51:11 +0100
Message-Id: <1011358271.506.73.camel@raul>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff:

Excuse me for writing you, I know that you aren't yet the 
via mantainer, but i'm having problems with my via 686a and Salvador
Eduardo Tropea told me that you could help me. The problem is this:


I have bought a compaq presario 700 with a via686a sound card. Kernel
recognices it but i only can heard the sound putting my ear in the
speakers, with volume mixer at 100%.

This card have a AD1886 chip. With the help of Salvador i have put some
code in ac97_codec.c and via82cxxx_audio.c files. This are the lines.

---------------  ac97_codec.c -------------------------

static int setup_ad1886(struct ac97_codec *codec);

static struct ac97_ops default_ops_raul = { setup_ad1886, NULL , NULL};

{0x41445361, "Analog Devices AD1886", &default_ops_raul}, //
ac97_codec_ids

/* 
 * Bring up an AD1886
 */

static int setup_ad1886(struct ac97_codec * codec)
{
 int cnt;
 /* The spec says not to mess with other bits unless
 S/PDIF is turned *off* in reg 2A */
 //codec->codec_write(codec, AC97_EXTENDED_STATUS, 0);
 /* The 1886 spec dated 08/25/00 says default value=0
 but ac97 2.2 says it should be 0x2000. */
// codec->codec_write(codec, AC97_RESERVED_3A, 0x0000); /* 48 kHz */
codec->codec_write(codec, 0x0002, 0x003f);
codec->codec_write(codec, 0x0004, 0x003f);
codec->codec_write(codec, 0x0006, 0x003f);
codec->codec_write(codec, 0x000a, 0x003f);
codec->codec_write(codec, 0x000c, 0x003f);
codec->codec_write(codec, 0x000e, 0x003f);
codec->codec_write(codec, 0x0010, 0x0808);
codec->codec_write(codec, 0x0012, 0x083f);
codec->codec_write(codec, 0x0014, 0x0808);
codec->codec_write(codec, 0x0016, 0x0808);
codec->codec_write(codec, 0x0016, 0x0808);
codec->codec_write(codec, 0x0018, 0x0808);
codec->codec_write(codec, 0x001a, 0x0000);
codec->codec_write(codec, 0x001c, 0x0800);
codec->codec_write(codec, 0x0020, 0x0000);
codec->codec_write(codec, 0x0022, 0x000f);
codec->codec_write(codec, 0x0028, 0x0005);
codec->codec_write(codec, 0x002c, 0xbb80);
codec->codec_write(codec, 0x007a, 0xbb80);
codec->codec_write(codec, 0x0032, 0xbb80);
codec->codec_write(codec, 0x0078, 0xbb80);
codec->codec_write(codec, 0x003a, 0x0000);
codec->codec_write(codec, 0x0072, 0x0000);
codec->codec_write(codec, AC97_EXTENDED_STATUS, 1);
codec->codec_write(codec, AC97_RESERVED_3A, 0x2000); /* 48 kHz */
   for (cnt=0; cnt <= 0x7e; cnt = cnt +2)
       printk(KERN_INFO "reg:0x%02x  val:0x%04x\n", cnt, 			 
codec->codec_read(codec, cnt));

 return 0;
}


--------------  ac97_codec.c -----------------------------


In via82cxxx_audio.c i only have printk's, so i don't write it.


Now, when i load the modules, my /var/log/messages is this:

------------------  /var/log/messages -----------------------------

Jan 18 12:21:24 raul kernel: Via 686a audio driver 1.9.1
Jan 18 12:21:24 raul kernel: PCI: Found IRQ 11 for device 00:07.5
Jan 18 12:21:24 raul kernel: IRQ routing conflict for 00:07.5, have irq
5, want irq 11
Jan 18 12:21:24 raul kernel: PCI: Sharing IRQ 11 with 00:0a.0
Jan 18 12:21:24 raul kernel: PCI: Sharing IRQ 11 with 00:0b.0
Jan 18 12:21:24 raul kernel: ---- pci_enable device ok ---- 
Jan 18 12:21:24 raul kernel: ---- pci_request_regions ok ---- 
Jan 18 12:21:24 raul kernel: ---- pci_set_drvdata ok ---- 
Jan 18 12:21:24 raul kernel: ---- pci_resource_start ok ---- 
Jan 18 12:21:24 raul kernel: EOEOEOEOEOOEOEOEOEOEEO<7>via_ac97_reset:
ENTER
Jan 18 12:21:24 raul kernel: ac97_codec: AC97 Audio codec, id:
0x4144:0x5361 (Analog Devices AD1886)
Jan 18 12:21:24 raul kernel:  INICIALIZANDO MIXER ----- 
Jan 18 12:21:24 raul kernel: reg:0x00  val:0x0410
Jan 18 12:21:24 raul kernel: reg:0x02  val:0x003f
Jan 18 12:21:24 raul kernel: reg:0x04  val:0x003f
Jan 18 12:21:24 raul kernel: reg:0x06  val:0x001f
Jan 18 12:21:24 raul kernel: reg:0x08  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x0a  val:0x001e
Jan 18 12:21:24 raul kernel: reg:0x0c  val:0x001f
Jan 18 12:21:24 raul kernel: reg:0x0e  val:0x001f
Jan 18 12:21:24 raul kernel: reg:0x10  val:0x0808
Jan 18 12:21:24 raul kernel: reg:0x12  val:0x081f
Jan 18 12:21:24 raul kernel: reg:0x14  val:0x0808
Jan 18 12:21:24 raul kernel: reg:0x16  val:0x0808
Jan 18 12:21:24 raul kernel: reg:0x18  val:0x0808
Jan 18 12:21:24 raul kernel: reg:0x1a  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x1c  val:0x0800
Jan 18 12:21:24 raul kernel: reg:0x1e  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x20  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x22  val:0x000f
Jan 18 12:21:24 raul kernel: reg:0x24  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x26  val:0x000f
Jan 18 12:21:24 raul kernel: reg:0x28  val:0x0005
Jan 18 12:21:24 raul kernel: reg:0x2a  val:0x0401
Jan 18 12:21:24 raul kernel: reg:0x2c  val:0xbb80
Jan 18 12:21:24 raul kernel: reg:0x2e  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x30  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x32  val:0xbb80
Jan 18 12:21:24 raul kernel: reg:0x34  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x36  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x38  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x3a  val:0x2000
Jan 18 12:21:24 raul kernel: reg:0x3c  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x3e  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x40  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x42  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x44  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x46  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x48  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x4a  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x4c  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x4e  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x50  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x52  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x54  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x56  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x58  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x5a  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x5c  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x5e  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x60  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x62  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x64  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x66  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x68  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x6a  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x6c  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x6e  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x70  val:0x0000
Jan 18 12:21:24 raul kernel: reg:0x72  val:0x0002
Jan 18 12:21:24 raul kernel: reg:0x74  val:0x7000
Jan 18 12:21:24 raul kernel: reg:0x76  val:0x0404
Jan 18 12:21:24 raul kernel: reg:0x78  val:0xbb80
Jan 18 12:21:24 raul kernel: reg:0x7a  val:0xbb80
Jan 18 12:21:24 raul kernel: reg:0x7c  val:0x4144
Jan 18 12:21:24 raul kernel: reg:0x7e  val:0x5361
Jan 18 12:21:24 raul kernel: ---- via_ac97_init ok ---- 
Jan 18 12:21:24 raul kernel: ---- via_dsp_init ok ---- 
Jan 18 12:21:24 raul kernel: ---- via_card_init_proc ok ---- 
Jan 18 12:21:24 raul kernel: ---- via_interrupt_init ok ---- 
Jan 18 12:21:24 raul kernel: via82cxxx: board #1 at 0x1000, IRQ 5
Jan 18 12:21:24 raul kernel: ----- Saliendo de via_init_one ----- 
Jan 18 12:24:24 raul kernel: ENTER


------------ /var/log/messages -----------------------------



and my dmesg is this:


--------------   dmesg -----------------------------------


via_dsp_do_write: regs==80 00 B7 0548E058 00000FE0 00AC0000 00001000
via_dsp_do_write: Sleeping on page 10, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E060, chan->hw_ptr=11
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 10, sw_ptr now 11, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E060 00000FE4 00AC0000 00001000
via_dsp_do_write: Sleeping on page 11, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E068, chan->hw_ptr=12
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 11, sw_ptr now 12, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E068 00000FE4 00AC0000 00001000
via_dsp_write: EXIT, returning 16384
via_dsp_write: ENTER, file=c67a6ba4, buffer=08085520, count=16384, ppos=0
via_chan_set_buffering: ENTER
via_chan_set_buffering: EXIT
via_chan_buffer_init: ENTER
via_chan_buffer_init: EXIT
via_dsp_do_write: Sleeping on page 12, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E070, chan->hw_ptr=13
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 12, sw_ptr now 13, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E070 00000FD0 00AC0000 00001000
via_dsp_do_write: Sleeping on page 13, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E078, chan->hw_ptr=14
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 13, sw_ptr now 14, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E078 00000FB0 00AC0000 00001000
via_dsp_do_write: Sleeping on page 14, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E080, chan->hw_ptr=15
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 14, sw_ptr now 15, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E080 00000FE0 00AC0000 00001000
via_dsp_do_write: Sleeping on page 15, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E088, chan->hw_ptr=16
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 15, sw_ptr now 16, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E088 00000FE0 00AC0000 00001000
via_dsp_write: EXIT, returning 16384
via_dsp_write: ENTER, file=c67a6ba4, buffer=08085520, count=16384, ppos=0
via_chan_set_buffering: ENTER
via_chan_set_buffering: EXIT
via_chan_buffer_init: ENTER
via_chan_buffer_init: EXIT
via_dsp_do_write: Sleeping on page 16, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E090, chan->hw_ptr=17
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 16, sw_ptr now 17, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E090 00000FE0 00AC0000 00001000
via_dsp_do_write: Sleeping on page 17, tmp==0, ir==0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E098, chan->hw_ptr=18
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_do_write: Flushed block 17, sw_ptr now 18, n_frags now 0
via_dsp_do_write: regs==80 00 B7 0548E098 00000FE0 00AC0000 00001000
via_dsp_do_write: Sleeping on page 18, tmp==0, ir==0
via_dsp_write: EXIT, returning 8192
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0A0, chan->hw_ptr=19
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_write: ENTER, file=c67a6ba4, buffer=08085520, count=512, ppos=0
via_chan_set_buffering: ENTER
via_chan_set_buffering: EXIT
via_chan_buffer_init: ENTER
via_chan_buffer_init: EXIT
via_dsp_write: EXIT, returning 512
via_dsp_release: ENTER
via_dsp_drain_playback: ENTER, nonblock = 0
via_chan_flush_frag: ENTER
via_chan_flush_frag: EXIT
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0A0 00000C58 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=0
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0A8, chan->hw_ptr=20
via_intr_channel: PCM-OUT intr, channel n_frags == 1
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0A8 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=1
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0B0, chan->hw_ptr=21
via_intr_channel: PCM-OUT intr, channel n_frags == 2
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0B0 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=2
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0B8, chan->hw_ptr=22
via_intr_channel: PCM-OUT intr, channel n_frags == 3
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0B8 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=3
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0C0, chan->hw_ptr=23
via_intr_channel: PCM-OUT intr, channel n_frags == 4
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0C0 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=4
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0C8, chan->hw_ptr=24
via_intr_channel: PCM-OUT intr, channel n_frags == 5
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0C8 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=5
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0D0, chan->hw_ptr=25
via_intr_channel: PCM-OUT intr, channel n_frags == 6
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0D0 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=6
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0D8, chan->hw_ptr=26
via_intr_channel: PCM-OUT intr, channel n_frags == 7
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0D8 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=7
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0E0, chan->hw_ptr=27
via_intr_channel: PCM-OUT intr, channel n_frags == 8
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0E0 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=8
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0E8, chan->hw_ptr=28
via_intr_channel: PCM-OUT intr, channel n_frags == 9
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0E8 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=9
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0F0, chan->hw_ptr=29
via_intr_channel: PCM-OUT intr, channel n_frags == 10
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0F0 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=10
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E0F8, chan->hw_ptr=30
via_intr_channel: PCM-OUT intr, channel n_frags == 11
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E0F8 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=11
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E100, chan->hw_ptr=31
via_intr_channel: PCM-OUT intr, channel n_frags == 12
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E100 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=12
via_interrupt: intr, status32 == 0x00001010
via_intr_channel: PCM-OUT intr, status=0x02, hwptr=0x548E008, chan->hw_ptr=0
via_intr_channel: PCM-OUT intr, channel n_frags == 13
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E008 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=13
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E010, chan->hw_ptr=1
via_intr_channel: PCM-OUT intr, channel n_frags == 14
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E010 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=14
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E018, chan->hw_ptr=2
via_intr_channel: PCM-OUT intr, channel n_frags == 15
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E018 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=15
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E020, chan->hw_ptr=3
via_intr_channel: PCM-OUT intr, channel n_frags == 16
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E020 00000FDC 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=16
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E028, chan->hw_ptr=4
via_intr_channel: PCM-OUT intr, channel n_frags == 17
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E028 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=17
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E030, chan->hw_ptr=5
via_intr_channel: PCM-OUT intr, channel n_frags == 18
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E030 00000FDC 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=18
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E038, chan->hw_ptr=6
via_intr_channel: PCM-OUT intr, channel n_frags == 19
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E038 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=19
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E040, chan->hw_ptr=7
via_intr_channel: PCM-OUT intr, channel n_frags == 20
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E040 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=20
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E048, chan->hw_ptr=8
via_intr_channel: PCM-OUT intr, channel n_frags == 21
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E048 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=21
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E050, chan->hw_ptr=9
via_intr_channel: PCM-OUT intr, channel n_frags == 22
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E050 00000FD8 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=22
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E058, chan->hw_ptr=10
via_intr_channel: PCM-OUT intr, channel n_frags == 23
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E058 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=23
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E060, chan->hw_ptr=11
via_intr_channel: PCM-OUT intr, channel n_frags == 24
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E060 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=24
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E068, chan->hw_ptr=12
via_intr_channel: PCM-OUT intr, channel n_frags == 25
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E068 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=25
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E070, chan->hw_ptr=13
via_intr_channel: PCM-OUT intr, channel n_frags == 26
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E070 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=26
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E078, chan->hw_ptr=14
via_intr_channel: PCM-OUT intr, channel n_frags == 27
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E078 00000FE0 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=27
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E080, chan->hw_ptr=15
via_intr_channel: PCM-OUT intr, channel n_frags == 28
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E080 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=28
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E088, chan->hw_ptr=16
via_intr_channel: PCM-OUT intr, channel n_frags == 29
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E088 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=29
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E090, chan->hw_ptr=17
via_intr_channel: PCM-OUT intr, channel n_frags == 30
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E090 00000FE4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=30
via_interrupt: intr, status32 == 0x00001001
via_intr_channel: PCM-OUT intr, status=0x01, hwptr=0x548E098, chan->hw_ptr=18
via_intr_channel: PCM-OUT intr, channel n_frags == 31
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==80 00 B7 0548E098 000001E4 00AC0000 00001000
via_dsp_drain_playback: sleeping, nbufs=31
via_interrupt: intr, status32 == 0x00001110
via_intr_channel: PCM-OUT intr, status=0x06, hwptr=0x548E008, chan->hw_ptr=19
via_intr_channel: PCM-OUT intr, channel n_frags == 32
via_dsp_drain_playback: PCI config: 01 CC 40 1C 00 05
via_dsp_drain_playback: regs==00 00 B7 0548E000 00000FE4 00AC0000 00000000
via_dsp_drain_playback: final nbufs=32
via_dsp_drain_playback: EXIT, returning 0
via_chan_free: ENTER
via_chan_free: EXIT
via_chan_buffer_free: ENTER
via_ac97_wait_idle: ENTER/EXIT
via_chan_buffer_free: EXIT
via_dsp_release: EXIT, returning 0
VFS: Disk change detected on device fd(2,60)


---------------   DMESG  ----------------------------------

what am i doing wrong? ac97_codec seem to be inicializated ok, but sound
has a very low volume :( 

Does via code inicialization change any value of ad1886?
Is possible that ad1886 works fine and the problem were with via
chipset?



Thank you very much for your time.


-- 
-----------------------------------------------
Raul Sanchez Sanchez             raul@dif.um.es
Centro de Calculo               
Facultad de Informatica    Tlf: +34 968 36 4827 
Universidad de Murcia      Fax: +34 968 36 4151
-----------------------------------------------
