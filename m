Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbUAIWmX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 17:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUAIWmX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 17:42:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:48535 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264292AbUAIWmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 17:42:22 -0500
Date: Fri, 9 Jan 2004 14:43:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: perex@suse.cz, tiwai@suse.de, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org
Subject: Re: 2.6.1-mm1: sound/pci/cmipci.c compile error
Message-Id: <20040109144314.678c8945.akpm@osdl.org>
In-Reply-To: <20040109193132.GK1440@fs.tum.de>
References: <20040109014003.3d925e54.akpm@osdl.org>
	<20040109193132.GK1440@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> wrote:
>
> I got the following compile error when trying to compile 
> sound/pci/cmipci.c statically into the kernel:
> 
> <--  snip  -->
> 
> ...
>   CC      sound/pci/cmipci.o
> sound/pci/cmipci.c: In function `alsa_card_cmipci_setup':
> sound/pci/cmipci.c:3300: error: `joystick' undeclared (first use in this function)
> sound/pci/cmipci.c:3300: error: (Each undeclared identifier is reported only once
> sound/pci/cmipci.c:3300: error: for each function it appears in.)

Like this, methinks

diff -puN sound/pci/cmipci.c~cmipci-joystick-fix sound/pci/cmipci.c
--- 25/sound/pci/cmipci.c~cmipci-joystick-fix	Fri Jan  9 14:41:51 2004
+++ 25-akpm/sound/pci/cmipci.c	Fri Jan  9 14:41:59 2004
@@ -3297,7 +3297,7 @@ static int __init alsa_card_cmipci_setup
 	       && get_option(&str,&soft_ac3[nr_dev]) == 2
 #endif
 #ifdef SUPPORT_JOYSTICK
-	       && get_option(&str,&joystick[nr_dev]) == 2
+	       && get_option(&str,&joystick_port[nr_dev]) == 2
 #endif
 	       );
 	nr_dev++;

_

