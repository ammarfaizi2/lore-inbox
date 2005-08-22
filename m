Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbVHVUJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbVHVUJl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 16:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVHVUJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 16:09:41 -0400
Received: from smtp4.brturbo.com.br ([200.199.201.180]:28287 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S1750796AbVHVUJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 16:09:40 -0400
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com,
       Greg KH <greg@kroah.com>
In-Reply-To: <20050815195704.7b61206e.khali@linux-fr.org>
References: <20050815195704.7b61206e.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 22 Aug 2005 17:09:08 -0300
Message-Id: <1124741348.4516.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-6mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2005-08-15 às 19:57 +0200, Jean Delvare escreveu:
> Hi all,
> 
> I2C_DEVNAME and i2c_clientname were introduced in 2.5.68 [1] to help
> media/video driver authors who wanted their code to be compatible with
> both Linux 2.4 and 2.6. The cause of the incompatibility has gone since
> [2], so I think we can get rid of them, as they tend to make the code
> harder to read and longer to preprocess/compile for no more benefit.
> 
> I'd hope nobody seriously attempts to keep media/video driver compatible
> across Linux trees anymore, BTW.
	That's not true. We keep V4L tree compatible with older kernel
releases. Each change like this does generate a lot of work at V4L side
to provide #ifdefs to check for linux version and provide a compatible
way to compile with older versions. I don't see any sense on applying
this patch, since it will not reduce code size or increase execution
time.

Mauro.
> 
> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=104930186524598&w=2
> [2] http://www.linuxhq.com/kernel/v2.6/0-test3/include/linux/i2c.h
> 
> This patch is meant to reach -mm through Greg's i2c tree.
> 
> Thanks.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> 
>  drivers/media/video/bt832.c                    |    2 
>  drivers/media/video/bttv-i2c.c                 |    8 ++--
>  drivers/media/video/cx88/cx88-i2c.c            |    8 ++--
>  drivers/media/video/ir-kbd-i2c.c               |    2 
>  drivers/media/video/msp3400.c                  |    4 +-
>  drivers/media/video/ovcamchip/ovcamchip_core.c |    6 ++--
>  drivers/media/video/saa7134/saa6752hs.c        |    2 
>  drivers/media/video/saa7134/saa7134-i2c.c      |    6 ++--
>  drivers/media/video/tda7432.c                  |    2 
>  drivers/media/video/tda9840.c                  |    2 
>  drivers/media/video/tda9875.c                  |    2 
>  drivers/media/video/tda9887.c                  |    2 
>  drivers/media/video/tea6415c.c                 |    2 
>  drivers/media/video/tea6420.c                  |    2 
>  drivers/media/video/tuner-core.c               |    2 
>  drivers/media/video/tvaudio.c                  |   41 ++++++++++++-------------
>  drivers/media/video/tvmixer.c                  |    8 ++--
>  drivers/media/video/zoran_card.c               |    2 
>  drivers/usb/media/w9968cf.c                    |    8 ++---
>  include/linux/i2c.h                            |    7 ----
>  20 files changed, 53 insertions(+), 65 deletions(-)
> 
> --- linux-2.6.13-rc6.orig/drivers/media/video/bt832.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/bt832.c	2005-08-12 21:22:45.000000000 +0200
> @@ -241,7 +241,7 @@
>  };
>  static struct i2c_client client_template =
>  {
> -	I2C_DEVNAME("bt832"),
> +	.name       = "bt832",
>  	.flags      = I2C_CLIENT_ALLOW_USE,
>          .driver     = &driver,
>  };
> --- linux-2.6.13-rc6.orig/drivers/media/video/bttv-i2c.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/bttv-i2c.c	2005-08-12 21:22:45.000000000 +0200
> @@ -109,7 +109,7 @@
>  #ifdef I2C_CLASS_TV_ANALOG
>  	.class             = I2C_CLASS_TV_ANALOG,
>  #endif
> -	I2C_DEVNAME("bt848"),
> +	.name              = "bt848",
>  	.id                = I2C_HW_B_BT848,
>  	.client_register   = attach_inform,
>  };
> @@ -280,7 +280,7 @@
>  #ifdef I2C_CLASS_TV_ANALOG
>  	.class         = I2C_CLASS_TV_ANALOG,
>  #endif
> -	I2C_DEVNAME("bt878"),
> +	.name          = "bt878",
>  	.id            = I2C_HW_B_BT848 /* FIXME */,
>  	.algo          = &bttv_algo,
>  	.client_register = attach_inform,
> @@ -296,7 +296,7 @@
>  	if (bttv_debug)
>  		printk(KERN_DEBUG "bttv%d: %s i2c attach [addr=0x%x,client=%s]\n",
>  			btv->c.nr,client->driver->name,client->addr,
> -			i2c_clientname(client));
> +			client->name);
>  	if (!client->driver->command)
>  		return 0;
>  
> @@ -324,7 +324,7 @@
>  }
>  
>  static struct i2c_client bttv_i2c_client_template = {
> -	I2C_DEVNAME("bttv internal"),
> +	.name	= "bttv internal",
>  };
>  
> 
> --- linux-2.6.13-rc6.orig/drivers/media/video/ir-kbd-i2c.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/ir-kbd-i2c.c	2005-08-12 21:22:45.000000000 +0200
> @@ -308,7 +308,7 @@
>  
>  static struct i2c_client client_template =
>  {
> -        I2C_DEVNAME("unset"),
> +        .name = "unset",
>          .driver = &driver
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/msp3400.c	2005-08-09 19:26:35.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/msp3400.c	2005-08-12 21:22:45.000000000 +0200
> @@ -1437,7 +1437,7 @@
>  
>  static struct i2c_client client_template =
>  {
> -	I2C_DEVNAME("(unset)"),
> +	.name      = "(unset)",
>  	.flags     = I2C_CLIENT_ALLOW_USE,
>          .driver    = &driver,
>  };
> @@ -1509,7 +1509,7 @@
>  	}
>  
>  	/* hello world :-) */
> -	printk(KERN_INFO "msp34xx: init: chip=%s",i2c_clientname(c));
> +	printk(KERN_INFO "msp34xx: init: chip=%s", c->name);
>  	if (HAVE_NICAM(msp))
>  		printk(" +nicam");
>  	if (HAVE_SIMPLE(msp))
> --- linux-2.6.13-rc6.orig/drivers/usb/media/w9968cf.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/usb/media/w9968cf.c	2005-08-12 21:22:45.000000000 +0200
> @@ -1523,7 +1523,6 @@
>  static int w9968cf_i2c_attach_inform(struct i2c_client* client)
>  {
>  	struct w9968cf_device* cam = i2c_get_adapdata(client->adapter);
> -	const char* clientname = i2c_clientname(client);
>  	int id = client->driver->id, err = 0;
>  
>  	if (id == I2C_DRIVERID_OVCAMCHIP) {
> @@ -1535,12 +1534,12 @@
>  		}
>  	} else {
>  		DBG(4, "Rejected client [%s] with driver [%s]", 
> -		    clientname, client->driver->name)
> +		    client->name, client->driver->name)
>  		return -EINVAL;
>  	}
>  
>  	DBG(5, "I2C attach client [%s] with driver [%s]",
> -	    clientname, client->driver->name)
> +	    client->name, client->driver->name)
>  
>  	return 0;
>  }
> @@ -1549,12 +1548,11 @@
>  static int w9968cf_i2c_detach_inform(struct i2c_client* client)
>  {
>  	struct w9968cf_device* cam = i2c_get_adapdata(client->adapter);
> -	const char* clientname = i2c_clientname(client);
>  
>  	if (cam->sensor_client == client)
>  		cam->sensor_client = NULL;
>  
> -	DBG(5, "I2C detach client [%s]", clientname)
> +	DBG(5, "I2C detach client [%s]", client->name)
>  
>  	return 0;
>  }
> --- linux-2.6.13-rc6.orig/drivers/media/video/cx88/cx88-i2c.c	2005-08-09 19:26:35.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/cx88/cx88-i2c.c	2005-08-12 21:22:45.000000000 +0200
> @@ -95,7 +95,7 @@
>  	struct cx88_core *core = i2c_get_adapdata(client->adapter);
>  
>  	dprintk(1, "%s i2c attach [addr=0x%x,client=%s]\n",
> -		client->driver->name,client->addr,i2c_clientname(client));
> +		client->driver->name, client->addr, client->name);
>  	if (!client->driver->command)
>  		return 0;
>  
> @@ -128,7 +128,7 @@
>  {
>  	struct cx88_core *core = i2c_get_adapdata(client->adapter);
>  
> -	dprintk(1, "i2c detach [client=%s]\n", i2c_clientname(client));
> +	dprintk(1, "i2c detach [client=%s]\n", client->name);
>  	return 0;
>  }
>  
> @@ -152,7 +152,7 @@
>  /* ----------------------------------------------------------------------- */
>  
>  static struct i2c_adapter cx8800_i2c_adap_template = {
> -	I2C_DEVNAME("cx2388x"),
> +	.name              = "cx2388x",
>  	.owner             = THIS_MODULE,
>  	.id                = I2C_HW_B_CX2388x,
>  	.client_register   = attach_inform,
> @@ -160,7 +160,7 @@
>  };
>  
>  static struct i2c_client cx8800_i2c_client_template = {
> -        I2C_DEVNAME("cx88xx internal"),
> +        .name	= "cx88xx internal",
>  };
>  
>  static char *i2c_devs[128] = {
> --- linux-2.6.13-rc6.orig/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/ovcamchip/ovcamchip_core.c	2005-08-12 21:22:45.000000000 +0200
> @@ -314,7 +314,7 @@
>  	}
>  	memcpy(c, &client_template, sizeof *c);
>  	c->adapter = adap;
> -	strcpy(i2c_clientname(c), "OV????");
> +	strcpy(c->name, "OV????");
>  
>  	ov = kmalloc(sizeof *ov, GFP_KERNEL);
>  	if (!ov) {
> @@ -328,7 +328,7 @@
>  	if (rc < 0)
>  		goto error;
>  
> -	strcpy(i2c_clientname(c), chip_names[ov->subtype]);
> +	strcpy(c->name, chip_names[ov->subtype]);
>  
>  	PDEBUG(1, "Camera chip detection complete");
>  
> @@ -421,7 +421,7 @@
>  };
>  
>  static struct i2c_client client_template = {
> -	I2C_DEVNAME("(unset)"),
> +	.name =		"(unset)",
>  	.driver =	&driver,
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/saa7134/saa6752hs.c	2005-08-09 19:26:35.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/saa7134/saa6752hs.c	2005-08-12 21:22:45.000000000 +0200
> @@ -598,7 +598,7 @@
>  
>  static struct i2c_client client_template =
>  {
> -	I2C_DEVNAME("saa6752hs"),
> +	.name       = "saa6752hs",
>  	.flags      = I2C_CLIENT_ALLOW_USE,
>          .driver     = &driver,
>  };
> --- linux-2.6.13-rc6.orig/drivers/media/video/saa7134/saa7134-i2c.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/saa7134/saa7134-i2c.c	2005-08-12 21:22:45.000000000 +0200
> @@ -334,7 +334,7 @@
>  	struct tuner_setup tun_setup;
>  
>  	d1printk( "%s i2c attach [addr=0x%x,client=%s]\n",
> -		client->driver->name,client->addr,i2c_clientname(client));
> +		 client->driver->name, client->addr, client->name);
>  
>  	if (!client->driver->command)
>  		return 0;
> @@ -380,14 +380,14 @@
>  #ifdef I2C_CLASS_TV_ANALOG
>  	.class         = I2C_CLASS_TV_ANALOG,
>  #endif
> -	I2C_DEVNAME("saa7134"),
> +	.name          = "saa7134",
>  	.id            = I2C_HW_SAA7134,
>  	.algo          = &saa7134_algo,
>  	.client_register = attach_inform,
>  };
>  
>  static struct i2c_client saa7134_client_template = {
> -	I2C_DEVNAME("saa7134 internal"),
> +	.name	= "saa7134 internal",
>  };
>  
>  /* ----------------------------------------------------------- */
> --- linux-2.6.13-rc6.orig/drivers/media/video/tda7432.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tda7432.c	2005-08-12 21:22:45.000000000 +0200
> @@ -513,7 +513,7 @@
>  
>  static struct i2c_client client_template =
>  {
> -	I2C_DEVNAME("tda7432"),
> +	.name       = "tda7432",
>  	.driver     = &driver,
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/tda9840.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tda9840.c	2005-08-12 21:22:45.000000000 +0200
> @@ -231,7 +231,7 @@
>  };
>  
>  static struct i2c_client client_template = {
> -	I2C_DEVNAME("tda9840"),
> +	.name = "tda9840",
>  	.driver = &driver,
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/tda9875.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tda9875.c	2005-08-12 21:22:45.000000000 +0200
> @@ -384,7 +384,7 @@
>  
>  static struct i2c_client client_template =
>  {
> -        I2C_DEVNAME("tda9875"),
> +        .name      = "tda9875",
>          .driver    = &driver,
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/tda9887.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tda9887.c	2005-08-12 21:22:45.000000000 +0200
> @@ -793,7 +793,7 @@
>  };
>  static struct i2c_client client_template =
>  {
> -	I2C_DEVNAME("tda9887"),
> +	.name      = "tda9887",
>  	.flags     = I2C_CLIENT_ALLOW_USE,
>          .driver    = &driver,
>  };
> --- linux-2.6.13-rc6.orig/drivers/media/video/tea6415c.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tea6415c.c	2005-08-12 21:22:45.000000000 +0200
> @@ -200,7 +200,7 @@
>  };
>  
>  static struct i2c_client client_template = {
> -	I2C_DEVNAME("tea6415c"),
> +	.name = "tea6415c",
>  	.driver = &driver,
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/tea6420.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tea6420.c	2005-08-12 21:22:45.000000000 +0200
> @@ -177,7 +177,7 @@
>  };
>  
>  static struct i2c_client client_template = {
> -	I2C_DEVNAME("tea6420"),
> +	.name = "tea6420",
>  	.driver = &driver,
>  };
>  
> --- linux-2.6.13-rc6.orig/drivers/media/video/tuner-core.c	2005-08-09 19:26:35.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tuner-core.c	2005-08-12 21:22:45.000000000 +0200
> @@ -709,7 +709,7 @@
>  		   },
>  };
>  static struct i2c_client client_template = {
> -	I2C_DEVNAME("(tuner unset)"),
> +	.name = "(tuner unset)",
>  	.flags = I2C_CLIENT_ALLOW_USE,
>  	.driver = &driver,
>  };
> --- linux-2.6.13-rc6.orig/drivers/media/video/tvaudio.c	2005-08-11 23:10:48.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tvaudio.c	2005-08-12 21:22:45.000000000 +0200
> @@ -162,24 +162,23 @@
>  	unsigned char buffer[2];
>  
>  	if (-1 == subaddr) {
> -		dprintk("%s: chip_write: 0x%x\n",
> -			i2c_clientname(&chip->c), val);
> +		dprintk("%s: chip_write: 0x%x\n", chip->c.name, val);
>  		chip->shadow.bytes[1] = val;
>  		buffer[0] = val;
>  		if (1 != i2c_master_send(&chip->c,buffer,1)) {
>  			printk(KERN_WARNING "%s: I/O error (write 0x%x)\n",
> -			       i2c_clientname(&chip->c), val);
> +			       chip->c.name, val);
>  			return -1;
>  		}
>  	} else {
>  		dprintk("%s: chip_write: reg%d=0x%x\n",
> -			i2c_clientname(&chip->c), subaddr, val);
> +			chip->c.name, subaddr, val);
>  		chip->shadow.bytes[subaddr+1] = val;
>  		buffer[0] = subaddr;
>  		buffer[1] = val;
>  		if (2 != i2c_master_send(&chip->c,buffer,2)) {
>  			printk(KERN_WARNING "%s: I/O error (write reg%d=0x%x)\n",
> -			       i2c_clientname(&chip->c), subaddr, val);
> +			       chip->c.name, subaddr, val);
>  			return -1;
>  		}
>  	}
> @@ -203,11 +202,10 @@
>  	unsigned char buffer;
>  
>  	if (1 != i2c_master_recv(&chip->c,&buffer,1)) {
> -		printk(KERN_WARNING "%s: I/O error (read)\n",
> -		       i2c_clientname(&chip->c));
> +		printk(KERN_WARNING "%s: I/O error (read)\n", chip->c.name);
>  		return -1;
>  	}
> -	dprintk("%s: chip_read: 0x%x\n",i2c_clientname(&chip->c),buffer);
> +	dprintk("%s: chip_read: 0x%x\n", chip->c.name, buffer);
>  	return buffer;
>  }
>  
> @@ -222,12 +220,11 @@
>          write[0] = subaddr;
>  
>  	if (2 != i2c_transfer(chip->c.adapter,msgs,2)) {
> -		printk(KERN_WARNING "%s: I/O error (read2)\n",
> -		       i2c_clientname(&chip->c));
> +		printk(KERN_WARNING "%s: I/O error (read2)\n", chip->c.name);
>  		return -1;
>  	}
>  	dprintk("%s: chip_read2: reg%d=0x%x\n",
> -		i2c_clientname(&chip->c),subaddr,read[0]);
> +		chip->c.name, subaddr, read[0]);
>  	return read[0];
>  }
>  
> @@ -240,7 +237,7 @@
>  
>  	/* update our shadow register set; print bytes if (debug > 0) */
>  	dprintk("%s: chip_cmd(%s): reg=%d, data:",
> -		i2c_clientname(&chip->c),name,cmd->bytes[0]);
> +		chip->c.name, name, cmd->bytes[0]);
>  	for (i = 1; i < cmd->count; i++) {
>  		dprintk(" 0x%x",cmd->bytes[i]);
>  		chip->shadow.bytes[i+cmd->bytes[0]] = cmd->bytes[i];
> @@ -249,7 +246,7 @@
>  
>  	/* send data to the chip */
>  	if (cmd->count != i2c_master_send(&chip->c,cmd->bytes,cmd->count)) {
> -		printk(KERN_WARNING "%s: I/O error (%s)\n", i2c_clientname(&chip->c), name);
> +		printk(KERN_WARNING "%s: I/O error (%s)\n", chip->c.name, name);
>  		return -1;
>  	}
>  	return 0;
> @@ -274,9 +271,9 @@
>          struct CHIPSTATE *chip = data;
>  	struct CHIPDESC  *desc = chiplist + chip->type;
>  
> -	daemonize("%s",i2c_clientname(&chip->c));
> +	daemonize("%s", chip->c.name);
>  	allow_signal(SIGTERM);
> -	dprintk("%s: thread started\n", i2c_clientname(&chip->c));
> +	dprintk("%s: thread started\n", chip->c.name);
>  
>  	for (;;) {
>  		add_wait_queue(&chip->wq, &wait);
> @@ -288,7 +285,7 @@
>  		try_to_freeze();
>  		if (chip->done || signal_pending(current))
>  			break;
> -		dprintk("%s: thread wakeup\n", i2c_clientname(&chip->c));
> +		dprintk("%s: thread wakeup\n", chip->c.name);
>  
>  		/* don't do anything for radio or if mode != auto */
>  		if (chip->norm == VIDEO_MODE_RADIO || chip->mode != 0)
> @@ -301,7 +298,7 @@
>  		mod_timer(&chip->wt, jiffies+2*HZ);
>  	}
>  
> -	dprintk("%s: thread exiting\n", i2c_clientname(&chip->c));
> +	dprintk("%s: thread exiting\n", chip->c.name);
>          complete_and_exit(&chip->texit, 0);
>  	return 0;
>  }
> @@ -314,7 +311,7 @@
>  	if (mode == chip->prevmode)
>  	    return;
>  
> -	dprintk("%s: thread checkmode\n", i2c_clientname(&chip->c));
> +	dprintk("%s: thread checkmode\n", chip->c.name);
>  	chip->prevmode = mode;
>  
>  	if (mode & VIDEO_SOUND_STEREO)
> @@ -1501,7 +1498,7 @@
>  		(desc->flags & CHIP_HAS_INPUTSEL)   ? " audiomux"    : "");
>  
>  	/* fill required data structures */
> -	strcpy(i2c_clientname(&chip->c),desc->name);
> +	strcpy(chip->c.name, desc->name);
>  	chip->type = desc-chiplist;
>  	chip->shadow.count = desc->registers+1;
>          chip->prevmode = -1;
> @@ -1538,7 +1535,7 @@
>  		chip->tpid = kernel_thread(chip_thread,(void *)chip,0);
>  		if (chip->tpid < 0)
>  			printk(KERN_WARNING "%s: kernel_thread() failed\n",
> -			       i2c_clientname(&chip->c));
> +			       chip->c.name);
>  		wake_up_interruptible(&chip->wq);
>  	}
>  	return 0;
> @@ -1591,7 +1588,7 @@
>  	struct CHIPSTATE *chip = i2c_get_clientdata(client);
>  	struct CHIPDESC  *desc = chiplist + chip->type;
>  
> -	dprintk("%s: chip_command 0x%x\n",i2c_clientname(&chip->c),cmd);
> +	dprintk("%s: chip_command 0x%x\n", chip->c.name, cmd);
>  
>  	switch (cmd) {
>  	case AUDC_SET_INPUT:
> @@ -1702,7 +1699,7 @@
>  
>  static struct i2c_client client_template =
>  {
> -	I2C_DEVNAME("(unset)"),
> +	.name       = "(unset)",
>  	.flags      = I2C_CLIENT_ALLOW_USE,
>          .driver     = &driver,
>  };
> --- linux-2.6.13-rc6.orig/drivers/media/video/tvmixer.c	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/tvmixer.c	2005-08-12 21:22:45.000000000 +0200
> @@ -91,7 +91,7 @@
>          if (cmd == SOUND_MIXER_INFO) {
>                  mixer_info info;
>                  strlcpy(info.id, "tv card", sizeof(info.id));
> -                strlcpy(info.name, i2c_clientname(client), sizeof(info.name));
> +                strlcpy(info.name, client->name, sizeof(info.name));
>                  info.modify_counter = 42 /* FIXME */;
>                  if (copy_to_user(argp, &info, sizeof(info)))
>                          return -EFAULT;
> @@ -100,7 +100,7 @@
>          if (cmd == SOUND_OLD_MIXER_INFO) {
>                  _old_mixer_info info;
>                  strlcpy(info.id, "tv card", sizeof(info.id));
> -                strlcpy(info.name, i2c_clientname(client), sizeof(info.name));
> +                strlcpy(info.name, client->name, sizeof(info.name));
>                  if (copy_to_user(argp, &info, sizeof(info)))
>                          return -EFAULT;
>                  return 0;
> @@ -295,7 +295,7 @@
>  			devices[i].dev = NULL;
>  			devices[i].minor = -1;
>  			printk("tvmixer: %s unregistered (#1)\n",
> -			       i2c_clientname(client));
> +			       client->name);
>  			return 0;
>  		}
>  	}
> @@ -354,7 +354,7 @@
>  		if (devices[i].minor != -1) {
>  			unregister_sound_mixer(devices[i].minor);
>  			printk("tvmixer: %s unregistered (#2)\n",
> -			       i2c_clientname(devices[i].dev));
> +			       devices[i].dev->name);
>  		}
>  	}
>  }
> --- linux-2.6.13-rc6.orig/drivers/media/video/zoran_card.c	2005-08-09 19:26:35.000000000 +0200
> +++ linux-2.6.13-rc6/drivers/media/video/zoran_card.c	2005-08-12 21:22:45.000000000 +0200
> @@ -737,7 +737,7 @@
>  };
>  
>  static struct i2c_adapter zoran_i2c_adapter_template = {
> -	I2C_DEVNAME("zr36057"),
> +	.name = "zr36057",
>  	.id = I2C_HW_B_ZR36067,
>  	.algo = NULL,
>  	.client_register = zoran_i2c_client_register,
> --- linux-2.6.13-rc6.orig/include/linux/i2c.h	2005-08-11 23:10:47.000000000 +0200
> +++ linux-2.6.13-rc6/include/linux/i2c.h	2005-08-12 21:22:45.000000000 +0200
> @@ -178,13 +178,6 @@
>  	dev_set_drvdata (&dev->dev, data);
>  }
>  
> -#define I2C_DEVNAME(str)	.name = str
> -
> -static inline char *i2c_clientname(struct i2c_client *c)
> -{
> -	return &c->name[0];
> -}
> -
>  /*
>   * The following structs are for those who like to implement new bus drivers:
>   * i2c_algorithm is the interface to a class of hardware solutions which can
> 
> 
Cheers, 
Mauro.

