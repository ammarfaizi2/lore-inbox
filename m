Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261582AbUDSRTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 13:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbUDSRTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 13:19:40 -0400
Received: from stgeorges-1-81-56-1-93.fbx.proxad.net ([81.56.1.93]:39564 "EHLO
	garfield") by vger.kernel.org with ESMTP id S261582AbUDSRTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 13:19:37 -0400
Message-ID: <40840A18.8070907@free.fr>
Date: Mon, 19 Apr 2004 19:19:20 +0200
From: Fabian Fenaut <fabian.fenaut@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: French/France, fr-FR, en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com
CC: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Sensors (W83627HF) in Tyan S2882
References: <1082387882.4083edaa52780@imp.gcu.info>	<200404191600.i3JG0ElX089970@zone3.gcu-squad.org> <20040419190133.351d1401.khali@linux-fr.org>
In-Reply-To: <20040419190133.351d1401.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
>>> Nice catching. However the fix is not correct. "W83627HF" is the
>>>  correct name and "W83682HF" is the typo.
>> 
>> You sure ? Looks like W83627HF is handled by the 2nd one, no ?
> 
> Sure. Both drivers handle it. The w83267hf driver is prefered if the
> chip is found on the ISA bus, however the w83781d is the only one 
> that can handle the chip if it's on the I2C bus.
> 
> For a list of supported chips for each driver, you can take a look at
> the comments in the headers of the source files.

Ok, so I suppose this is the appropriate patch :


--- drivers/i2c/chips/Kconfig.orig      2004-04-19 19:05:53.000000000 +0200
+++ drivers/i2c/chips/Kconfig   2004-04-19 19:10:15.000000000 +0200
@@ -163,7 +163,7 @@
         select I2C_SENSOR
         help
           If you say yes here you get support for the Winbond W8378x series
-         of sensor chips: the W83781D, W83782D, W83783S and W83682HF,
+         of sensor chips: the W83781D, W83782D, W83783S and W83627HF,
           and the similar Asus AS99127F.

           This driver can also be built as a module.  If so, the module


--
Fabian

