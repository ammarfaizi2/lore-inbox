Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVEFOQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVEFOQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVEFOPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:15:39 -0400
Received: from styx.suse.cz ([82.119.242.94]:19363 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261233AbVEFOPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:15:18 -0400
Date: Fri, 6 May 2005 16:06:49 +0200
From: Jiri Benc <jbenc@suse.cz>
To: v4l <video4linux-list@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] video/tuner: fix tuner->freq updating
Message-Id: <20050506160649.7a3f0ff8@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In VIDIOC_S_FREQUENCY command in tuner-core.c, t->freq is set to a new
value before calling set_freq(). This is not necessary, as set_freq()
sets t->freq itself. Moreover, it causes problems with Philips tuners,
as they need to take into consideration difference between previous and
new frequency.


Signed-off-by: Jiri Benc <jbenc@suse.cz>

--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -357,8 +357,7 @@
 		    V4L2_TUNER_RADIO != t->mode)
 			set_tv_freq(client,400*16);
 		t->mode  = f->type;
-		t->freq  = f->frequency;
-		set_freq(client,t->freq);
+		set_freq(client,f->frequency);
 		break;
 	}
 	case VIDIOC_G_TUNER:



--
Jiri Benc
SUSE Labs
