Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264651AbUDUDTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbUDUDTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 23:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUDUDTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 23:19:13 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:56462 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264651AbUDUDTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 23:19:11 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux problem (2.6.5)
Date: Tue, 20 Apr 2004 22:19:06 -0500
User-Agent: KMail/1.6.1
Cc: "E.Rodichev" <er@sai.msu.su>
References: <Pine.GSO.4.58.0404200404360.22353@ra.sai.msu.su> <200404200736.38616.dtor_core@ameritech.net> <Pine.GSO.4.58.0404201718220.4975@ra.sai.msu.su>
In-Reply-To: <Pine.GSO.4.58.0404201718220.4975@ra.sai.msu.su>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404202219.08935.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 09:11 am, E.Rodichev wrote:
> It's not a problem of mousedev, but the problem of make menuconfig.
> 
> The relevant part of .config is
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> # CONFIG_INPUT_JOYDEV is not set
> # CONFIG_INPUT_TSDEV is not set
> # CONFIG_INPUT_EVDEV is not set
> # CONFIG_INPUT_EVBUG is not set
> 
> Starting from original linux-2.6.5.tar.gz it seems impossible to
> disable CONFIG_INPUT_MOUSEDEV_PSAUX without disabling CONFIG_INPUT_MOUSEDEV.
> 
> If I comment out the line CONFIG_INPUT_MOUSEDEV_PSAUX by hand, make
> silently restore this line to yes.
> 

Ok, in that case why mess with MOUSEDEV and not MOUSEDEV_PSAUX, like this:

===== drivers/input/Kconfig 1.6 vs edited =====
--- 1.6/drivers/input/Kconfig	Thu Sep 11 22:19:35 2003
+++ edited/drivers/input/Kconfig	Tue Apr 20 22:11:43 2004
@@ -41,9 +41,16 @@
 	  module will be called mousedev.
 
 config INPUT_MOUSEDEV_PSAUX
-	bool "Provide legacy /dev/psaux device" if EMBEDDED
+	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
+	---help---
+	  Say Y here if you want your mouse also be accessible as char device
+	  10:1 - /dev/psaux. The data available through /dev/psaux is exactly
+	  the same as the data from /dev/input/mice.
+
+	  If unsure, say Y.
+
 
 config INPUT_MOUSEDEV_SCREEN_X
 	int "Horizontal screen resolution"
