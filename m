Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288266AbSAQHzd>; Thu, 17 Jan 2002 02:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288276AbSAQHzZ>; Thu, 17 Jan 2002 02:55:25 -0500
Received: from raul.dif.um.es ([155.54.15.4]:19840 "EHLO raul.dif.um.es")
	by vger.kernel.org with ESMTP id <S288266AbSAQHzK>;
	Thu, 17 Jan 2002 02:55:10 -0500
Subject: Re: Driver via ac97 sound problem (VT82C686) Compaq Presario 700
From: Raul Sanchez Sanchez <raul@dif.um.es>
To: salvador@inti.gov.ar
Cc: Paul Lorenz <p1orenz@yahoo.com>, Jeremy Lumbroso <j.lumbroso@noos.fr>,
        ignacio@adesx.com, rubio@adesx.com,
        Jorge Carminati <jcarminati@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C459995.A8EF423A@inti.gov.ar>
In-Reply-To: <20020114194209.90225.qmail@web20905.mail.yahoo.com> 
	<3C4342DA.5D19601A@inti.gov.ar> <1011045793.1847.3.camel@raul> 
	<3C441F7E.FD8A345C@inti.gov.ar> <1011100904.535.2.camel@raul> 
	<3C448071.7109C9E5@inti.gov.ar> <1011137857.504.16.camel@raul> 
	<3C459995.A8EF423A@inti.gov.ar>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 08:48:57 +0100
Message-Id: <1011253737.502.22.camel@raul>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:


	All the problems i tell you occurs when i try to access to register in
via_card_init_proc. If i try to do this in 1886 initialization (
ac97_codec.c ) i haven't got any problem, i can write the registers of
the 1886 and i can read then perfectly.

	But my question is, later i set up 1886 chip, does via inicialization
change my configuration of it? If i try to print all the register of the
1886 in via_card_init_proc it fails :( and i can't be sure that via code
doesn't change them.


my 1886_setup proc is now as this:


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


and the output in /var/log/messages is:


Jan 16 21:05:38 raul kernel:  INICIALIZANDO MIXER -----
Jan 16 21:05:38 raul kernel: reg:0x00  val:0x0410
Jan 16 21:05:38 raul kernel: reg:0x02  val:0x003f
Jan 16 21:05:38 raul kernel: reg:0x04  val:0x003f
Jan 16 21:05:38 raul kernel: reg:0x06  val:0x001f
Jan 16 21:05:38 raul kernel: reg:0x08  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x0a  val:0x001e
Jan 16 21:05:38 raul kernel: reg:0x0c  val:0x001f
Jan 16 21:05:38 raul kernel: reg:0x0e  val:0x001f
Jan 16 21:05:38 raul kernel: reg:0x10  val:0x0808
Jan 16 21:05:38 raul kernel: reg:0x12  val:0x081f
Jan 16 21:05:38 raul kernel: reg:0x14  val:0x0808
Jan 16 21:05:38 raul kernel: reg:0x16  val:0x0808
Jan 16 21:05:38 raul kernel: reg:0x18  val:0x0808
Jan 16 21:05:38 raul kernel: reg:0x1a  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x1c  val:0x0800
Jan 16 21:05:38 raul kernel: reg:0x1e  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x20  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x22  val:0x000f
Jan 16 21:05:38 raul kernel: reg:0x24  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x26  val:0x000f
Jan 16 21:05:38 raul kernel: reg:0x28  val:0x0005
Jan 16 21:05:38 raul kernel: reg:0x2a  val:0x0401
Jan 16 21:05:38 raul kernel: reg:0x2c  val:0xbb80
Jan 16 21:05:38 raul kernel: reg:0x2e  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x30  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x32  val:0xbb80
Jan 16 21:05:38 raul kernel: reg:0x34  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x36  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x38  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x3a  val:0x2000
Jan 16 21:05:38 raul kernel: reg:0x3c  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x3e  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x40  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x42  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x44  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x46  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x48  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x4a  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x4c  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x4e  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x50  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x52  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x54  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x56  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x58  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x5a  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x5c  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x5e  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x60  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x62  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x64  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x66  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x68  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x6a  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x6c  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x6e  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x70  val:0x0000
Jan 16 21:05:38 raul kernel: reg:0x72  val:0x0002
Jan 16 21:05:38 raul kernel: reg:0x74  val:0x7000
Jan 16 21:05:38 raul kernel: reg:0x76  val:0x0404
Jan 16 21:05:38 raul kernel: reg:0x78  val:0xbb80
Jan 16 21:05:38 raul kernel: reg:0x7a  val:0xbb80
Jan 16 21:05:38 raul kernel: reg:0x7c  val:0x4144
Jan 16 21:05:38 raul kernel: reg:0x7e  val:0x5361
Jan 16 21:05:38 raul kernel: via82cxxx: board #1 at 0x1000, IRQ 5



As you can see, the register are well written in ad1886, so this are my
question, 
---- Does via code inicialization change any value of ad1886?
---- Is possible that ad1886 works fine and the problem were with via
chipset?
----- Any suggestion is welcomed.


Thanks






-- 
-----------------------------------------------
Raul Sanchez Sanchez             raul@dif.um.es
Centro de Calculo               
Facultad de Informatica    Tlf: +34 968 36 4827 
Universidad de Murcia      Fax: +34 968 36 4151
-----------------------------------------------
