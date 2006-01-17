Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWAQSrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWAQSrF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWAQSrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:47:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24328 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932212AbWAQSrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:47:03 -0500
Date: Tue, 17 Jan 2006 19:47:01 +0100
From: Adrian Bunk <bunk@stusta.de>
To: perex@suse.cz
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       D Binderman <dcb314@hotmail.com>
Subject: [2.6 patch] sound/pci/cs46xx/dsp_spos_scb_lib.c: fix an assertion
Message-ID: <20060117184701.GC19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

D Binderman <dcb314@hotmail.com> reported the following in kernel 
Bugzilla #5903 [1]:


<--  snip  -->

I just tried to compile kernel 2.6.15.1 with the Intel C compiler. 

It said

sound/pci/cs46xx/dsp_spos_scb_lib.c(673): warning #187: use of "=" where 
"==" may have been intended

The source code is

           snd_assert (rate = 48000);

I agree with the compiler. Suggest new code

           snd_assert (rate == 48000);

<--  snip  -->


Thankfully this bug would only become visible if the assertion was 
false, but anyways it's a bug.

[1] http://bugzilla.kernel.org/show_bug.cgi?id=5903


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-mm4-full/sound/pci/cs46xx/dsp_spos_scb_lib.c.old	2006-01-16 20:20:23.000000000 +0100
+++ linux-2.6.15-mm4-full/sound/pci/cs46xx/dsp_spos_scb_lib.c	2006-01-16 20:21:17.000000000 +0100
@@ -677,7 +677,7 @@
 		if (pass_through) {
 			/* wont work with any other rate than
 			   the native DSP rate */
-			snd_assert (rate = 48000);
+			snd_assert (rate == 48000);
 
 			scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&src_task_scb,
 							    dest,"DMAREADER",parent_scb,

