Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264574AbTCZDUo>; Tue, 25 Mar 2003 22:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264571AbTCZDUo>; Tue, 25 Mar 2003 22:20:44 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:54158 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S264574AbTCZDUl>;
	Tue, 25 Mar 2003 22:20:41 -0500
Date: Tue, 25 Mar 2003 22:34:26 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.66
Message-ID: <20030325223426.GE1083@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030325223319.GC1083@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030325223319.GC1083@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.985.1.94 -> 1.985.1.95
#	  sound/isa/als100.c	1.9     -> 1.10   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/24	ambx1@neo.rr.com	1.985.1.95
# ALS100 Memory Leak Fix
# 
# This trivial patch adds a missing kfree, the leak occurs when 
# pnp_activate_dev fails.
# --------------------------------------------
#
diff -Nru a/sound/isa/als100.c b/sound/isa/als100.c
--- a/sound/isa/als100.c	Tue Mar 25 21:45:03 2003
+++ b/sound/isa/als100.c	Tue Mar 25 21:45:03 2003
@@ -151,6 +151,7 @@
 	err = pnp_activate_dev(pdev);
 	if (err < 0) {
 		printk(KERN_ERR PFX "AUDIO pnp configure failure\n");
+		kfree(cfg);
 		return err;
 	}
 	port[dev] = pnp_port_start(pdev, 0);
