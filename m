Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319354AbSH2V4X>; Thu, 29 Aug 2002 17:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319407AbSH2Vzo>; Thu, 29 Aug 2002 17:55:44 -0400
Received: from smtpout.mac.com ([204.179.120.85]:35040 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319354AbSH2VyC>;
	Thu, 29 Aug 2002 17:54:02 -0400
Message-Id: <200208292158.g7TLwQKN026712@smtp-relay03.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 35/41 sound/oss/midi_synth.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/midi_synth.c	Sat Apr 20 18:25:20 2002
+++ linux-2.5-cli-oss/sound/oss/midi_synth.c	Wed Aug 14 22:42:01 2002
@@ -418,7 +418,6 @@
 {
 	int             orig_dev = synth_devs[dev]->midi_dev;
 	int             err;
-	unsigned long   flags;
 	struct midi_input_info *inc;
 
 	if (orig_dev < 0 || orig_dev > num_midis || midi_devs[orig_dev] == NULL)
@@ -433,14 +432,15 @@
 		return err;
 	inc = &midi_devs[orig_dev]->in_info;
 
-	save_flags(flags);
-	cli();
+	/* save_flags(flags);
+	cli(); 
+	don't know against what irqhandler to protect*/
 	inc->m_busy = 0;
 	inc->m_state = MST_INIT;
 	inc->m_ptr = 0;
 	inc->m_left = 0;
 	inc->m_prev_status = 0x00;
-	restore_flags(flags);
+	/* restore_flags(flags); */
 
 	return 1;
 }

