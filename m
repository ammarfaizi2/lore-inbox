Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVEFOP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVEFOP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 10:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEFOP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 10:15:29 -0400
Received: from styx.suse.cz ([82.119.242.94]:19107 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261231AbVEFOPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 10:15:18 -0400
Date: Fri, 6 May 2005 16:15:03 +0200
From: Jiri Benc <jbenc@suse.cz>
To: v4l <video4linux-list@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] video/tuner: add VIDEO_G_FREQUENCY and freq range to
 VIDIOC_G_TUNER
Message-Id: <20050506161503.094bfb0c@griffin.suse.cz>
X-Mailer: Sylpheed-Claws 0.9.12 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a VIDIOC_G_FREQUENCY command to tuner-core.c and sets
lowest and highest tunable frequencies in v4l2_tuner structure returned
by VIDIOC_G_TUNER command.


Signed-off-by: Jiri Benc <jbenc@suse.cz>

--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -360,6 +360,15 @@
 		set_freq(client,f->frequency);
 		break;
 	}
+	case VIDIOC_G_FREQUENCY:
+	{
+		struct v4l2_frequency *f = arg;
+
+		SWITCH_V4L2;
+		f->type = t->mode;
+		f->frequency = t->freq;
+		break;
+	}
 	case VIDIOC_G_TUNER:
 	{
 		struct v4l2_tuner *tuner = arg;
@@ -367,6 +376,8 @@
 		SWITCH_V4L2;
 		if (V4L2_TUNER_RADIO == t->mode  &&  t->has_signal)
 			tuner->signal = t->has_signal(client);
+		tuner->rangelow = tv_range[0] * 16;
+		tuner->rangehigh = tv_range[1] * 16;
 		break;
 	}
 	default:


--
Jiri Benc
SUSE Labs
