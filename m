Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281184AbRKTSC5>; Tue, 20 Nov 2001 13:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281196AbRKTSCr>; Tue, 20 Nov 2001 13:02:47 -0500
Received: from mo.kasei.com ([212.250.176.40]:29188 "HELO soto.kasei.com")
	by vger.kernel.org with SMTP id <S281184AbRKTSCd>;
	Tue, 20 Nov 2001 13:02:33 -0500
Date: Tue, 20 Nov 2001 18:02:31 +0000
From: Marty Pauley <kernel@kasei.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] OOPS in i810_audio during resume
Message-ID: <20011120180231.A20222@soto.kasei.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <linux.kernel.12220000.1004834654@araucaria.SOMEWHERE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <linux.kernel.12220000.1004834654@araucaria.SOMEWHERE>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When resuming from APM suspend with the i810_audio loaded I got an OOPS that
killed apmd.  This simple patch stops the OOPS (so APM keeps working) but it
doesn't solve the problem.

'codec' is null is because it previously failed to initialise in
i810_ac97_init: i810_ac97_probe_and_powerup fails for the second codec; Alex
Bligh mentioned this a few weeks ago.


--- /usr/src/linux/drivers/sound/i810_audio.c.orig      Thu Nov 15 01:38:31 2001
+++ /usr/src/linux/drivers/sound/i810_audio.c   Thu Nov 15 01:45:07 2001
@@ -2873,6 +2873,10 @@
                if(!i810_ac97_exists(card,num_ac97)) {
                        if(num_ac97) continue;
                        else BUG();
+               }
+               if(!codec) {
+                       printk("i810_audio: cannot resume null codec %d\n", num_ac97);
+                       continue;
                }
                if(!i810_ac97_probe_and_powerup(card,codec)) BUG();
 
-- 
Marty
