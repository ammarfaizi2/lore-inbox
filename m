Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752041AbWKFSaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbWKFSaU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 13:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWKFSaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 13:30:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:60434 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750830AbWKFSaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 13:30:19 -0500
Date: Mon, 6 Nov 2006 19:30:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] sound/core/control.c: remove dead code
Message-ID: <20061106183018.GB8099@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some obviously dead code spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/sound/core/control.c.old	2006-11-06 19:11:32.000000000 +0100
+++ linux-2.6/sound/core/control.c	2006-11-06 19:11:52.000000000 +0100
@@ -1267,23 +1267,23 @@ static ssize_t snd_ctl_read(struct file 
 			if ((file->f_flags & O_NONBLOCK) != 0 || result > 0) {
 				err = -EAGAIN;
 				goto __end_lock;
 			}
 			init_waitqueue_entry(&wait, current);
 			add_wait_queue(&ctl->change_sleep, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
 			spin_unlock_irq(&ctl->read_lock);
 			schedule();
 			remove_wait_queue(&ctl->change_sleep, &wait);
 			if (signal_pending(current))
-				return result > 0 ? result : -ERESTARTSYS;
+				return -ERESTARTSYS;
 			spin_lock_irq(&ctl->read_lock);
 		}
 		kev = snd_kctl_event(ctl->events.next);
 		ev.type = SNDRV_CTL_EVENT_ELEM;
 		ev.data.elem.mask = kev->mask;
 		ev.data.elem.id = kev->id;
 		list_del(&kev->list);
 		spin_unlock_irq(&ctl->read_lock);
 		kfree(kev);
 		if (copy_to_user(buffer, &ev, sizeof(struct snd_ctl_event))) {
 			err = -EFAULT;
