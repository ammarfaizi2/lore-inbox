Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVK2NGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVK2NGp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 08:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVK2NGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 08:06:45 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:6329 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1751352AbVK2NGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 08:06:45 -0500
Message-ID: <438C528C.4070304@m1k.net>
Date: Tue, 29 Nov 2005 08:07:24 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.15-rc3 - VIDEO_BT848_DVB config
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C1F68.4070707@eyal.emu.id.au>
In-Reply-To: <438C1F68.4070707@eyal.emu.id.au>
Content-Type: multipart/mixed;
 boundary="------------000001060805090100060601"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000001060805090100060601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Eyal Lebedinsky wrote:

>Linus Torvalds wrote:
>  
>
>>I just pushed 2.6.15-rc3 out there, and here are both the shortlog and 
>>diffstats appended.
>>    
>>
>A config issue? It says 'choose M' which is not offered. Maybe it is just
>an option for the bt8xx driver, which itself can be built as a module
>(CONFIG_VIDEO_BT848)?
>
>
>  DVB/ATSC Support for bt878 based TV cards (VIDEO_BT848_DVB) [N/y/?] (NEW) ?
>
>This adds support for DVB/ATSC cards based on the BT878 chip.
>
>To compile this driver as a module, choose M here: the
>module will be called dvb-bt8xx.
>
No -- It's a typo.  CONFIG_VIDEO_BT848_DVB is just an option to 
CONFIG_VIDEO_BT848.  It is a boolean option, and when chosen, Kconfig 
SELECT's CONFIG_DVB_BT8XX, and that's the actual menu item that builds 
the module.

The option is set as bool, so that if it's dependencies are set as 
modules, dvb-bt8xx will also build as a module.  If, however, the 
dependencies are set to build in-kernel, then dvb-bt8xx will do so as well.

Consider this menu item a symbolic link to CONFIG_DVB_BT8XX -- it was 
the only way to add this as a submenu option to VIDEO_BT848, without 
removing the reference in the DVB submenu.

Anyhow, this patch removes the incorrect info:

Signed-off-by: Michael Krufky <mkrufky@m1k.net>


--------------000001060805090100060601
Content-Type: text/x-patch;
 name="fix-kconfig-typo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-kconfig-typo.patch"

 drivers/media/video/Kconfig |    3 ---
 1 file changed, 3 deletions(-)

--- linux-2.6.15-rc3.orig/drivers/media/video/Kconfig	2005-11-29 01:21:42.000000000 -0500
+++ linux-2.6.15-rc3/drivers/media/video/Kconfig	2005-11-29 08:01:39.000000000 -0500
@@ -32,9 +32,6 @@
 	---help---
 	  This adds support for DVB/ATSC cards based on the BT878 chip.
 
-	  To compile this driver as a module, choose M here: the
-	  module will be called dvb-bt8xx.
-
 config VIDEO_SAA6588
 	tristate "SAA6588 Radio Chip RDS decoder support on BT848 cards"
 	depends on VIDEO_DEV && I2C && VIDEO_BT848

--------------000001060805090100060601--
