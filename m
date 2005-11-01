Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbVKAU2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbVKAU2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVKAU2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:28:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17366 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751127AbVKAU2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:28:53 -0500
Date: Tue, 1 Nov 2005 20:05:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: dtor_core@ameritech.net
Cc: vojtech@suse.cz, kernel list <linux-kernel@vger.kernel.org>,
       rpurdie@rpsys.net, lenz@cs.wisc.edu
Subject: Re: after latest input updates, locomo keyboard kills boot
Message-ID: <20051101190556.GD29974@elf.ucw.cz>
References: <20051101094945.GA7293@elf.ucw.cz> <d120d5000511010712o77b2b1afie52e47ac07b09a8c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000511010712o77b2b1afie52e47ac07b09a8c@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > drivers/input/keyboard/locomokbd.c:
> >
> > struct locomokbd {
> >        unsigned char keycode[LOCOMOKBD_NUMKEYS];
> >        struct input_dev input;
> >        ~~~~~~~~~~~~~~~~~~~~~~~
> >
> > ...and I guess that's the problem. What needs to be done? Just replace
> > it with struct input_dev *?
> 
> Try the attached. BTW, shouldn't input->id.bus be BUS_HOST and not
> >BUS_XTKBD?

Yes, that helped, thanks a lot. Will you take care of merging, or
should I push it through akpm?
							Pavel

Fix compilation of locomokbd.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit ea66607091fbd8cfd2f0ab3a6218ec4d0ba399e4
tree 95f52c3742913a93cfdc6e15b43561cb1011ed2f
parent 5e047cfca8cb5833ac7c96d7c000270307316d1f
author <pavel@amd.(none)> Tue, 01 Nov 2005 20:03:07 +0100
committer <pavel@amd.(none)> Tue, 01 Nov 2005 20:03:07 +0100

 drivers/input/keyboard/locomokbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -261,7 +261,7 @@ out:
 	release_mem_region((unsigned long) dev->mapbase, dev->length);
 	locomo_set_drvdata(dev, NULL);
 free:
-	input_free_device(input_dev)
+	input_free_device(input_dev);
 	kfree(locomokbd);
 
 	return ret;


Fix wrong bustype.

---
commit cb4e751101b0e359cec50565caba977c1e6d5709
tree b6779a09e5685efd00e72e5161f08bd6bc5b494a
parent ea66607091fbd8cfd2f0ab3a6218ec4d0ba399e4
author <pavel@amd.(none)> Tue, 01 Nov 2005 20:05:23 +0100
committer <pavel@amd.(none)> Tue, 01 Nov 2005 20:05:23 +0100

 drivers/input/keyboard/locomokbd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -230,7 +230,7 @@ static int locomokbd_probe(struct locomo
 
 	input_dev->name = "LoCoMo keyboard";
 	input_dev->phys = locomokbd->phys;
-	input_dev->id.bustype = BUS_XTKBD;
+	input_dev->id.bustype = BUS_HOST;
 	input_dev->id.vendor = 0x0001;
 	input_dev->id.product = 0x0001;
 	input_dev->id.version = 0x0100;


-- 
Thanks, Sharp!
