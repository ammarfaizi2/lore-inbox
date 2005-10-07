Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbVJGO6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbVJGO6x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbVJGO6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:58:53 -0400
Received: from [221.158.187.116] ([221.158.187.116]:29650 "EHLO
	comet.deepsky.org") by vger.kernel.org with ESMTP id S1030265AbVJGO6w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:58:52 -0400
Message-Id: <200510071458.j97Ewbfv000624@comet.deepsky.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] atkbd: fix mispell of the korean alphabet name
User-Agent: Mail::Sendmail v0.79
Content-Disposition: inline
Date: Fri, 7 Oct 2005 23:58:37 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: kj <kernel-janitors@lists.osdl.org>, linux-input@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 8bit
From: Jerome Pinot <ngc891@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Pinot <ngc891@gmail.com>
 
 Fix a mispell on the korean alphabet name in the atkbd subsystem.
 See http://en.wikipedia.org/wiki/Hangeul#Names for more details.
 Will make some korean people happy.
 
 Signed-off-by: Jerome Pinot <ngc891@gmail.com>
 ---
 
 diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
 --- a/drivers/char/keyboard.c
 +++ b/drivers/char/keyboard.c
 @@ -975,7 +975,7 @@ static int emulate_raw(struct vc_data *v
  			put_queue(vc, 0x1d | up_flag);
  			put_queue(vc, 0x45 | up_flag);
  			return 0;
 -		case KEY_HANGUEL:
 +		case KEY_HANGEUL:
  			if (!up_flag) put_queue(vc, 0xf1);
  			return 0;
  		case KEY_HANJA:
 diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
 --- a/drivers/input/keyboard/atkbd.c
 +++ b/drivers/input/keyboard/atkbd.c
 @@ -149,7 +149,7 @@ static unsigned char atkbd_unxlate_table
  #define ATKBD_RET_EMUL0		0xe0
  #define ATKBD_RET_EMUL1		0xe1
  #define ATKBD_RET_RELEASE	0xf0
 -#define ATKBD_RET_HANGUEL	0xf1
 +#define ATKBD_RET_HANGEUL	0xf1
  #define ATKBD_RET_HANJA		0xf2
  #define ATKBD_RET_ERR		0xff
  
 @@ -296,7 +296,7 @@ static irqreturn_t atkbd_interrupt(struc
  
  		if (atkbd->emul ||
  		    !(code == ATKBD_RET_EMUL0 || code == ATKBD_RET_EMUL1 ||
 -		      code == ATKBD_RET_HANGUEL || code == ATKBD_RET_HANJA ||
 +		      code == ATKBD_RET_HANGEUL || code == ATKBD_RET_HANJA ||
  		     (code == ATKBD_RET_ERR && !atkbd->err_xl) ||
  	             (code == ATKBD_RET_BAT && !atkbd->bat_xl))) {
  			atkbd->release = code >> 7;
 @@ -325,8 +325,8 @@ static irqreturn_t atkbd_interrupt(struc
  		case ATKBD_RET_RELEASE:
  			atkbd->release = 1;
  			goto out;
 -		case ATKBD_RET_HANGUEL:
 -			atkbd_report_key(&atkbd->dev, regs, KEY_HANGUEL, 3);
 +		case ATKBD_RET_HANGEUL:
 +			atkbd_report_key(&atkbd->dev, regs, KEY_HANGEUL, 3);
  			goto out;
  		case ATKBD_RET_HANJA:
  			atkbd_report_key(&atkbd->dev, regs, KEY_HANJA, 3);
 diff --git a/drivers/macintosh/adbhid.c b/drivers/macintosh/adbhid.c
 --- a/drivers/macintosh/adbhid.c
 +++ b/drivers/macintosh/adbhid.c
 @@ -179,7 +179,7 @@ u8 adb_to_linux_keycodes[128] = {
  	/* 0x65 */ KEY_F9,		/*  67 */
  	/* 0x66 */ KEY_HANJA,		/* 123 */
  	/* 0x67 */ KEY_F11,		/*  87 */
 -	/* 0x68 */ KEY_HANGUEL,		/* 122 */
 +	/* 0x68 */ KEY_HANGEUL,		/* 122 */
  	/* 0x69 */ KEY_SYSRQ,		/*  99 */
  	/* 0x6a */ 0,
  	/* 0x6b */ KEY_SCROLLLOCK,	/*  70 */
 diff --git a/drivers/usb/input/hid-debug.h b/drivers/usb/input/hid-debug.h
 --- a/drivers/usb/input/hid-debug.h
 +++ b/drivers/usb/input/hid-debug.h
 @@ -563,7 +563,7 @@ static char *keys[KEY_MAX + 1] = {
  	[KEY_VOLUMEUP] = "VolumeUp",		[KEY_POWER] = "Power",
  	[KEY_KPEQUAL] = "KPEqual",		[KEY_KPPLUSMINUS] = "KPPlusMinus",
  	[KEY_PAUSE] = "Pause",			[KEY_KPCOMMA] = "KPComma",
 -	[KEY_HANGUEL] = "Hanguel",		[KEY_HANJA] = "Hanja",
 +	[KEY_HANGEUL] = "Hangeul",		[KEY_HANJA] = "Hanja",
  	[KEY_YEN] = "Yen",			[KEY_LEFTMETA] = "LeftMeta",
  	[KEY_RIGHTMETA] = "RightMeta",		[KEY_COMPOSE] = "Compose",
  	[KEY_STOP] = "Stop",			[KEY_AGAIN] = "Again",
 diff --git a/include/linux/input.h b/include/linux/input.h
 --- a/include/linux/input.h
 +++ b/include/linux/input.h
 @@ -229,7 +229,7 @@ struct input_absinfo {
  #define KEY_PAUSE		119
  
  #define KEY_KPCOMMA		121
 -#define KEY_HANGUEL		122
 +#define KEY_HANGEUL		122
  #define KEY_HANJA		123
  #define KEY_YEN			124
  #define KEY_LEFTMETA		125

