Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbUCVVgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 16:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUCVVgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 16:36:45 -0500
Received: from amsfep12-int.chello.nl ([213.46.243.18]:35651 "EHLO
	amsfep20-int.chello.nl") by vger.kernel.org with ESMTP
	id S263642AbUCVVgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 16:36:33 -0500
From: Jos Hulzink <josh@stack.nl>
To: John Cherry <cherry@osdl.org>
Subject: Re: Linux 2.6.5-rc2 (compile stats)
Date: Mon, 22 Mar 2004 22:38:17 +0100
User-Agent: KMail/1.6.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0403191937160.1106@ppc970.osdl.org> <1079900427.4185.0.camel@lightning>
In-Reply-To: <1079900427.4185.0.camel@lightning>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jz1XARjxvE1ystq"
Message-Id: <200403222238.17231.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Jz1XARjxvE1ystq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 21 March 2004 21:21, John Cherry wrote:
> Compile stats for 2.6.5-rc2 and 2.6.5-rc2-mm1.
>
> Linux 2.6 Compile Statistics (gcc 3.2.2)
> Warnings/Errors Summary
>
> Kernel         bzImage    bzImage  bzImage  modules  bzImage   modules
>              (defconfig)  (allno)  (allyes) (allyes) (allmod) (allmod)
> -----------  -----------  -------- -------- -------- -------- ---------
> 2.6.5-rc2      0w/0e       0w/0e   135w/ 0e   8w/0e   3w/0e    132w/0e

Please find attached a patch to fix some of the trivial warnings. More to 
follow.

Jos Hulzink

--Boundary-00=_Jz1XARjxvE1ystq
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_trivial_warnings_2.6.5rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix_trivial_warnings_2.6.5rc2.diff"

diff -rc linux-2.6.4/drivers/isdn/i4l/isdn_v110.c linuxwork/drivers/isdn/i4l/isdn_v110.c
*** linux-2.6.4/drivers/isdn/i4l/isdn_v110.c	2004-03-11 03:55:54.000000000 +0100
--- linuxwork/drivers/isdn/i4l/isdn_v110.c	2004-03-22 20:23:53.322799512 +0100
***************
*** 520,526 ****
  {
  	isdn_v110_stream *v = NULL;
  	int i;
! 	int ret;
  
  	if (idx < 0)
  		return 0;
--- 520,526 ----
  {
  	isdn_v110_stream *v = NULL;
  	int i;
! 	int ret=0;
  
  	if (idx < 0)
  		return 0;
diff -rc linux-2.6.4/drivers/media/dvb/frontends/stv0299.c linuxwork/drivers/media/dvb/frontends/stv0299.c
*** linux-2.6.4/drivers/media/dvb/frontends/stv0299.c	2004-03-11 03:55:54.000000000 +0100
--- linuxwork/drivers/media/dvb/frontends/stv0299.c	2004-03-22 20:15:36.535322688 +0100
***************
*** 353,359 ****
  	u8 addr;
  	u32 div;
  	u8 buf[4];
!         int i, divisor, regcode;
  
  	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
  
--- 353,359 ----
  	u8 addr;
  	u32 div;
  	u8 buf[4];
!         int divisor, regcode;
  
  	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
  
diff -rc linux-2.6.4/drivers/media/dvb/frontends/tda1004x.c linuxwork/drivers/media/dvb/frontends/tda1004x.c
*** linux-2.6.4/drivers/media/dvb/frontends/tda1004x.c	2004-03-22 21:06:29.646179288 +0100
--- linuxwork/drivers/media/dvb/frontends/tda1004x.c	2004-03-22 20:18:00.459442896 +0100
***************
*** 41,47 ****
  #include <linux/syscalls.h>
  #include <linux/fs.h>
  #include <linux/fcntl.h>
- #include <linux/errno.h>
  #include "dvb_frontend.h"
  #include "dvb_functions.h"
  
--- 41,46 ----
***************
*** 188,196 ****
  static struct fwinfo tda10046h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x3c4f9,.fw_size = 24479} };
  static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
  
- static int errno;
- 
- 
  static int tda1004x_write_byte(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg, int data)
  {
  	int ret;
--- 187,192 ----
diff -rc linux-2.6.4/drivers/message/fusion/mptscsih.c linuxwork/drivers/message/fusion/mptscsih.c
*** linux-2.6.4/drivers/message/fusion/mptscsih.c	2004-03-22 21:06:29.800155880 +0100
--- linuxwork/drivers/message/fusion/mptscsih.c	2004-03-22 20:31:48.488563336 +0100
***************
*** 196,203 ****
  static void	mptscsih_dv_parms(MPT_SCSI_HOST *hd, DVPARAMETERS *dv,void *pPage);
  static void	mptscsih_fillbuf(char *buffer, int size, int index, int width);
  #endif
  static int	mptscsih_setup(char *str);
! 
  /* module entry point */
  static int  __init   mptscsih_init  (void);
  static void __exit   mptscsih_exit  (void);
--- 196,204 ----
  static void	mptscsih_dv_parms(MPT_SCSI_HOST *hd, DVPARAMETERS *dv,void *pPage);
  static void	mptscsih_fillbuf(char *buffer, int size, int index, int width);
  #endif
+ #ifdef MODULE
  static int	mptscsih_setup(char *str);
! #endif
  /* module entry point */
  static int  __init   mptscsih_init  (void);
  static void __exit   mptscsih_exit  (void);
***************
*** 7247,7252 ****
--- 7248,7254 ----
  	return 0;
  }
  
+ #ifdef MODULE
  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
  static int
  mptscsih_setup(char *str)
***************
*** 7298,7304 ****
  	}
  	return 1;
  }
! 
  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
  
  
--- 7300,7306 ----
  	}
  	return 1;
  }
! #endif
  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
  
  
diff -rc linux-2.6.4/drivers/net/arcnet/com20020-isa.c linuxwork/drivers/net/arcnet/com20020-isa.c
*** linux-2.6.4/drivers/net/arcnet/com20020-isa.c	2004-03-11 03:55:22.000000000 +0100
--- linuxwork/drivers/net/arcnet/com20020-isa.c	2004-03-22 20:32:57.384089624 +0100
***************
*** 185,192 ****
  #ifndef MODULE
  static int __init com20020isa_setup(char *s)
  {
- 	struct net_device *dev;
- 	struct arcnet_local *lp;
  	int ints[8];
  
  	s = get_options(s, 8, ints);
--- 185,190 ----
diff -rc linux-2.6.4/sound/isa/wavefront/wavefront_synth.c linuxwork/sound/isa/wavefront/wavefront_synth.c
*** linux-2.6.4/sound/isa/wavefront/wavefront_synth.c	2004-03-22 21:06:39.898620680 +0100
--- linuxwork/sound/isa/wavefront/wavefront_synth.c	2004-03-22 20:25:59.151670616 +0100
***************
*** 1920,1927 ****
  #include <linux/syscalls.h>
  #include <asm/uaccess.h>
  
- static int errno;
- 
  static int __init
  wavefront_download_firmware (snd_wavefront_t *dev, char *path)
  
--- 1920,1925 ----

--Boundary-00=_Jz1XARjxvE1ystq--
