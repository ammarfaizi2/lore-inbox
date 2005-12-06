Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVLFU2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVLFU2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbVLFU2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:28:41 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:42445 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030221AbVLFU2k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:28:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O8EBFTK1dJb38h19cNpkxioMDF3ryJfHrdKkXU/Y2VX36oaOK6TsRxGCUcb+WWDvKKNiuwBf1uF5aMGhHWDx6c+fP9qovI1Z6Ke2n5bPkZBz0hGy63LUp5YiTASlSB/5Z7jZZylxcin21roC/saQPOTTFVmjK00Sx+9n1sn2L5Q=
Message-ID: <37219a840512061228y5b4ac66akd0b433cb2da3aab7@mail.gmail.com>
Date: Tue, 6 Dec 2005 15:28:39 -0500
From: Michael Krufky <mkrufky@gmail.com>
To: Prakash Punnoor <prakash@punnoor.de>
Subject: Re: [PATCH] b2c2: make front-ends selectable and include noob option
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
In-Reply-To: <200512062053.00711.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <200512062053.00711.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I apologize if you've received this twice.  My first message got
bounced from LKML... Trying again.

On 12/6/05, Prakash Punnoor <prakash@punnoor.de> wrote:
> Hi,
>
> this patch probably needs some touch-up but mainly I am sking the dvb guys why
> don't they do something like this. Current situation:
>
> For my Skystar2 card I am forced to compile in half a dozen front-ends + fw
> loader - but I only need one front-end driver and no fw loader. Furthermore
> this crap in the log goes away by throwing unneccessary stuff out:
>
> before:
> b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded
> successfully
> flexcop-pci: will use the HW PID filter.
> flexcop-pci: card revision 1
> ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, high) ->
> IRQ 17
> DVB: registering new adapter (FlexCop Digital TV device).
> b2c2-flexcop: MAC address = 00:d0:d7:03:73:66
> b2c2-flexcop: i2c master_xfer failed
> b2c2-flexcop: i2c master_xfer failed
> b2c2-flexcop: i2c master_xfer failed
> mt352_read_register: readreg error (reg=127, ret==-121)
> b2c2-flexcop: i2c master_xfer failed
> i2c_readbytes: i2c read error (addr 0a, err == -121)
> b2c2-flexcop: i2c master_xfer failed
> lgdt330x: i2c_read_demod_bytes: addr 0x59 select 0x02 error (ret == -121)
> b2c2-flexcop: i2c master_xfer failed
> b2c2-flexcop: i2c master_xfer failed
> stv0297_readreg: readreg error (reg == 0x80, ret == -22)
> b2c2-flexcop: found the vp310 (aka mt312) at i2c address: 0x0e
> DVB: registering frontend 0 (Zarlink VP310 DVB-S)...
> b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S (old version)' at the
> 'PCI' bus controlled by a 'FlexCopII' complete
>
> after:
> b2c2-flexcop: B2C2 FlexcopII/II(b)/III digital TV receiver chip loaded
> successfully
> flexcop-pci: will use the HW PID filter.
> flexcop-pci: card revision 1
> ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
> ACPI: PCI Interrupt 0000:01:08.0[A] -> Link [APC1] -> GSI 16 (level, high) ->
> IRQ 17
> DVB: registering new adapter (FlexCop Digital TV device).
> b2c2-flexcop: MAC address = 00:d0:d7:03:73:66
> b2c2-flexcop: found the vp310 (aka mt312) at i2c address: 0x0e
> DVB: registering frontend 0 (Zarlink VP310 DVB-S)...
> b2c2-flexcop: initialization of 'Sky2PC/SkyStar 2 DVB-S (old version)' at the
> 'PCI' bus controlled by a 'FlexCopII' complete
>
> Needless to say that my kernel size is a bit smaller and my card still works.
>
> I made the patch trying to follow: http://www.linuxjournal.com/article/5780
> by Greg Kroah-Hartman, esp the paragraph "No ifdefs in .c Code". Unfortunately
> there this is the problem with request_firmware(...) which I needed to ifdef
> out. Probably someone has a better idea.
>
> I also added an *option* to include every supported front-end, so that noobs
> don't have to guess around and I guess this was the intention by the dvb devs
> by selection all frontends by default. I only dislike the missing possibility
> to deselect unwanted ones. (Is it possible to select this option by default?
> I don't know much about Kbuild.)
>
> Anyway I asked the dvb guys why the included everything unselectable by
> default, but I got no response, thus I submit this patch hoping to get more
> response now.
>
> Of course, this patch only addresses the b2c2 chips. So here it goes, hoping I
> haven't missed anything:
>
> signed-off-by: Prakash Punnoor <prakash@punnoor.de>
>
>
> diff -urd dvb.old/b2c2/flexcop-fe-tuner.c dvb/b2c2/flexcop-fe-tuner.c
> --- dvb.old/b2c2/flexcop-fe-tuner.c     2005-12-06 19:55:39.060449080 +0100
> +++ dvb/b2c2/flexcop-fe-tuner.c 2005-12-06 20:29:55.144876736 +0100
> @@ -293,8 +293,12 @@
>
>  static int flexcop_fe_request_firmware(struct dvb_frontend* fe, const struct
> firmware **fw, char* name)
>  {
> +#ifdef CONFIG_FW_LOADER
>         struct flexcop_device *fc = fe->dvb->priv;
>         return request_firmware(fw, name, fc->dev);
> +#else
> +       return -EINVAL;
> +#endif
>  }
>
>  static int lgdt3303_pll_set(struct dvb_frontend* fe,
> diff -urd dvb.old/b2c2/Kconfig dvb/b2c2/Kconfig
> --- dvb.old/b2c2/Kconfig        2005-12-06 19:55:39.060449080 +0100
> +++ dvb/b2c2/Kconfig    2005-12-06 20:36:36.751823200 +0100
> @@ -1,6 +1,15 @@
>  config DVB_B2C2_FLEXCOP
>         tristate "Technisat/B2C2 FlexCopII(b) and FlexCopIII adapters"
>         depends on DVB_CORE
> +       help
> +         Support for the digital TV receiver chip made by B2C2 Inc. included in
> +         Technisats PCI cards and USB boxes.
> +
> +         Say Y if you own such a device and want to use it.
> +
> +config DVB_B2C2_FLEXCOP_ALL_FRONTENDS
> +       bool "Select all supported front-ends"
> +       depends on DVB_B2C2_FLEXCOP
>         select DVB_STV0299
>         select DVB_MT352
>         select DVB_MT312
> @@ -9,10 +18,12 @@
>         select DVB_BCM3510
>         select DVB_LGDT330X
>         help
> -         Support for the digital TV receiver chip made by B2C2 Inc. included in
> -         Technisats PCI cards and USB boxes.
> +         Selects all supported front-ends by Technisat/B2C2 driver.
> +         If you don't select this option, you must select the correct
> +         front-end by hand.
> +
> +         Say Y if you don't know your front-end.
>
> -         Say Y if you own such a device and want to use it.
>
>  config DVB_B2C2_FLEXCOP_PCI
>         tristate "Technisat/B2C2 Air/Sky/Cable2PC PCI"
> diff -urd dvb.old/frontends/bcm3510.h dvb/frontends/bcm3510.h
> --- dvb.old/frontends/bcm3510.h 2005-12-06 19:55:39.445390560 +0100
> +++ dvb/frontends/bcm3510.h     2005-12-06 20:09:37.878929288 +0100
> @@ -34,7 +34,15 @@
>         int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw,
> char* name);
>  };
>
> +#ifdef CONFIG_DVB_BCM3510
>  extern struct dvb_frontend* bcm3510_attach(const struct bcm3510_config*
> config,
>                                            struct i2c_adapter* i2c);
> +#else
> +static inline struct dvb_frontend* bcm3510_attach(const struct
> bcm3510_config* config,
> +                                                 struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +#endif
>
>  #endif
> diff -urd dvb.old/frontends/lgdt330x.h dvb/frontends/lgdt330x.h
> --- dvb.old/frontends/lgdt330x.h        2005-12-06 19:55:39.645360160 +0100
> +++ dvb/frontends/lgdt330x.h    2005-12-06 20:00:10.309213000 +0100
> @@ -53,8 +53,16 @@
>         int clock_polarity_flip;
>  };
>
> +#ifdef CONFIG_DVB_LGDT330X
>  extern struct dvb_frontend* lgdt330x_attach(const struct lgdt330x_config*
> config,
>                                             struct i2c_adapter* i2c);
> +#else
> +static inline struct dvb_frontend* lgdt330x_attach(const struct
> lgdt330x_config* config,
> +                                                  struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +#endif
>
>  #endif /* LGDT330X_H */
>
> diff -urd dvb.old/frontends/mt312.h dvb/frontends/mt312.h
> --- dvb.old/frontends/mt312.h   2005-12-06 19:55:39.503381744 +0100
> +++ dvb/frontends/mt312.h       2005-12-06 20:04:07.191201464 +0100
> @@ -38,10 +38,24 @@
>         int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters*
> params);
>  };
>
> +#ifdef CONFIG_DVB_MT312
>  extern struct dvb_frontend* mt312_attach(const struct mt312_config* config,
>                                          struct i2c_adapter* i2c);
>
>  extern struct dvb_frontend* vp310_attach(const struct mt312_config* config,
>                                          struct i2c_adapter* i2c);
> +#else
> +static inline struct dvb_frontend* mt312_attach(const struct mt312_config*
> config,
> +                                               struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +
> +static inline struct dvb_frontend* vp310_attach(const struct mt312_config*
> config,
> +                                               struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +#endif
>
>  #endif // MT312_H
> diff -urd dvb.old/frontends/mt352.h dvb/frontends/mt352.h
> --- dvb.old/frontends/mt352.h   2005-12-06 19:55:39.540376120 +0100
> +++ dvb/frontends/mt352.h       2005-12-06 20:04:21.881968128 +0100
> @@ -57,9 +57,22 @@
>         int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters*
> params, u8* pllbuf);
>  };
>
> +#ifdef CONFIG_DVB_MT352
>  extern struct dvb_frontend* mt352_attach(const struct mt352_config* config,
>                                          struct i2c_adapter* i2c);
>
>  extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
> +#else
> +static inline struct dvb_frontend* mt352_attach(const struct mt352_config*
> config,
> +                                               struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +
> +static inline int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen)
> +{
> +       return 0;
> +}
> +#endif
>
>  #endif // MT352_H
> diff -urd dvb.old/frontends/nxt2002.h dvb/frontends/nxt2002.h
> --- dvb.old/frontends/nxt2002.h 2005-12-06 19:55:39.540376120 +0100
> +++ dvb/frontends/nxt2002.h     2005-12-06 20:08:39.722770368 +0100
> @@ -17,7 +17,15 @@
>         int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw,
> char* name);
>  };
>
> +#ifdef CONFIG_DVB_NXT2002
>  extern struct dvb_frontend* nxt2002_attach(const struct nxt2002_config*
> config,
>                                            struct i2c_adapter* i2c);
> +#else
> +static inline struct dvb_frontend* nxt2002_attach(const struct
> nxt2002_config* config,
> +                                                 struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +#endif
>
>  #endif // NXT2002_H
> diff -urd dvb.old/frontends/stv0297.h dvb/frontends/stv0297.h
> --- dvb.old/frontends/stv0297.h 2005-12-06 19:55:39.577370496 +0100
> +++ dvb/frontends/stv0297.h     2005-12-06 20:06:34.959737232 +0100
> @@ -43,8 +43,21 @@
>         int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters*
> params);
>  };
>
> +#ifdef CONFIG_DVB_STV0297
>  extern struct dvb_frontend* stv0297_attach(const struct stv0297_config*
> config,
>                                            struct i2c_adapter* i2c);
>  extern int stv0297_enable_plli2c(struct dvb_frontend* fe);
> +#else
> +static inline struct dvb_frontend* stv0297_attach(const struct
> stv0297_config* config,
> +                                                 struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +
> +static inline int stv0297_enable_plli2c(struct dvb_frontend* fe)
> +{
> +       return 0;
> +}
> +#endif
>
>  #endif // STV0297_H
> diff -urd dvb.old/frontends/stv0299.h dvb/frontends/stv0299.h
> --- dvb.old/frontends/stv0299.h 2005-12-06 19:55:39.681354688 +0100
> +++ dvb/frontends/stv0299.h     2005-12-06 19:59:45.158036560 +0100
> @@ -93,9 +93,22 @@
>         int (*pll_set)(struct dvb_frontend *fe, struct i2c_adapter *i2c, struct
> dvb_frontend_parameters *params);
>  };
>
> +#ifdef CONFIG_DVB_STV0299
>  extern int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 data);
>
>  extern struct dvb_frontend* stv0299_attach(const struct stv0299_config*
> config,
>                                            struct i2c_adapter* i2c);
> +#else
> +static inline int stv0299_writereg (struct dvb_frontend* fe, u8 reg, u8 data)
> +{
> +       return 0;
> +}
> +
> +static inline struct dvb_frontend* stv0299_attach(const struct
> stv0299_config* config,
> +                                                 struct i2c_adapter* i2c)
> +{
> +       return NULL;
> +}
> +#endif
>
>  #endif // STV0299_H
>
>
>
>
> --
> (°=                 =°)
> //\ Prakash Punnoor /\\
> V_/                 \_V
>
>
>


 NACK.

 You are going to run into some problems with this patch... For
instance, What if the user chooses to compile the b2c2-flexcop driver
in-kernel, but only compiles the frontend drivers as modules...  Then,
the frontend support will be built into the flexcop driver, but the
module will not yet be available at the time when the kernel is
looking for it...

  Take a look at what I did to the following files.... You may want to
apply the same method to the flexcop build, although I am beginning to
think that this is more trouble that it's worth...

  I am considering reverting the frontend selection patch for cx88 and
saa7134 from 2.6.15 , if I hear one more complaint about it...

  I will say it publicly -- Johannes originally didn't like this idea,
and now I see why, although my solution seems to be working well, but
I had only intended on sending this to -mm ..... It got merged into
2.6.15 too quickly, but luckily it seems to be working well.

 Take a look at what I have done to the following files to enable
advanced frontend selection for cx88-dvb and saa7134-dvb :

 drivers/media/video/cx88
/Kconfig
 drivers/media/video/cx88/Makefile
 drivers/media/video/saa7134/Kconfig
 drivers/media/video/saa7134/Makefile

 If you see above, select all frontends is selected by default,
because this is the desired behavior, and the previous bahevior that
everyone is used to.

 When that option is disabled, the user is presented with a list of
frontends to choose from... The frontends are selected with the same
tristate value of the [cx88,saa7134]-dvb driver ..... ie:

 cx88-dvb is M , frontends will be M
 cx88-dvb is Y, frontends will be Y

 This MUST happen in this exact manner, otherwise you will get
unresolved symbols, and a useless installation.

 I'll tell you the truth, I think Johannes is going to ask that I
revert this frontend selection thing.... If he does, I will respect
his wishes.  Now that v4l and dvb development has merged into a single
cvs repository, I believe that we will find new and better ways to
accomplish this "frontend selection" goal........

 Regards,

 Michael Krufky

 P.S.:  To anyone interested, my regular email service is down right
now.... You can reach me this gmail address.  Please cc me on replies
to this message, as my gmail account is not subscriber to the
linux-dvb-maintainer list.  Thank you.
