Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVD2DMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVD2DMz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVD2DMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:12:55 -0400
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:19391 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262372AbVD2DMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:12:51 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: snd-ens1371 (alsa) & joystick woes
Date: Thu, 28 Apr 2005 22:12:46 -0500
User-Agent: KMail/1.8
Cc: Guillaume Chazarain <guichaz@yahoo.fr>,
       linux-joystick@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
References: <425BACC2.9020709@yahoo.fr> <425F8B09.3010706@yahoo.fr>
In-Reply-To: <425F8B09.3010706@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504282212.48456.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 April 2005 04:36, Guillaume Chazarain wrote:
> Guillaume Chazarain wrote:
> 
> > From 2.6.11 to 2.6.12-rc2, there are some changes in the joystick 
> > behaviour
> > that I don't think are expected. It's a simple joystick using 
> > analog.ko plugged
> > on a sound board using snd-ens1371. So here we go:
> 
> Reverting 
> http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/input/joydev.c@1.31?nav=index.html|src/|src/drivers|src/drivers/input|hist/drivers/input/joydev.c
> (removing all the added " + 1" in joydev.c) fixes it for me.
>

Hi,

Could you check if the following patch from Vojtech fixes it?
 
Thanks!

-- 
Dmitry


===================================================================


ChangeSet@1.2229.1.12, 2005-04-04 15:40:40+02:00, vojtech@suse.cz
  input: Fix button mapping in joydev - BTN_TRIGGER was being
         mapped twice, resulting in it being the last (instead
         of first) button on a joystick.
    
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 joydev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	2005-04-28 22:07:31 -05:00
+++ b/drivers/input/joydev.c	2005-04-28 22:07:31 -05:00
@@ -357,7 +357,7 @@
 }
 
 #ifdef CONFIG_COMPAT
-static long joydev_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
+static long joydev_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct joydev_list *list = file->private_data;
 	struct joydev *joydev = list->joydev;
@@ -488,7 +488,7 @@
 			joydev->nkey++;
 		}
 
-	for (i = 0; i < BTN_JOYSTICK - BTN_MISC + 1; i++)
+	for (i = 0; i < BTN_JOYSTICK - BTN_MISC; i++)
 		if (test_bit(i + BTN_MISC, dev->keybit)) {
 			joydev->keymap[i] = joydev->nkey;
 			joydev->keypam[joydev->nkey] = i + BTN_MISC;
