Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVCWB0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVCWB0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVCWB0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:26:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25615 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262593AbVCWB0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:26:16 -0500
Date: Wed, 23 Mar 2005 02:26:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni, linux-kernel@vger.kernel.org
Subject: drivers/input/touchscreen/gunze.c: gunze_process_packet: invalid array access
Message-ID: <20050323012613.GY1948@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker found the following bug in the function 
gunze_process_packet in drivers/input/touchscreen/gunze.c:


<--  snip  -->

...
#define GUNZE_MAX_LENGTH        10
...
struct gunze {
...
        unsigned char data[GUNZE_MAX_LENGTH];
...
};
...
static void gunze_process_packet(struct gunze* gunze, struct pt_regs *regs)
...
                gunze->data[10] = 0;
...

<--  snip  -->


The bug is obvious, but for a correct solution someone should know this 
code better than I do.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

