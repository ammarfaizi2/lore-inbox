Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTI1VEP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTI1VEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 17:04:15 -0400
Received: from mail.convergence.de ([212.84.236.4]:26805 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262725AbTI1VEN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 17:04:13 -0400
Message-ID: <3F774CCC.3040707@convergence.de>
Date: Sun, 28 Sep 2003 23:04:12 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3b) Gecko/20030312
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org, video4linux-list@redhat.com
Subject: Re: [2.6 patch] select for drivers/media
References: <20030928160536.GJ15338@fs.tum.de>
In-Reply-To: <20030928160536.GJ15338@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Adrian,

> The patch below switches drivers/mtd to use select where appropriate.

Ok.

> Could someone with a knowledge of the code please check the following:
> 
> DVB_AV7110 and DVB_BUDGET select VIDEO_SAA7146 (without my patch 
> VIDEO_SAA7146 depends on them) although they don't fulfill the 
> VIDEO_SAA7146 dependencies VIDEO_DEV && PCI && I2C.

I admit that this is somewhat broken and might fail under certain 
cirumstances. It's possible that someone sets DVB_AV7110, but does not 
have I2C enabled. Then VIDEO_SAA7146 is not build, although it should. Doh!

Does your patch fix this issue as well?

> Is the intention to enable VIDEO_SAA7146 only when these options are 
> enabled or should DVB_AV7110 and DVB_BUDGET depend on these options?

Both DVB_AV7110 and DVB_BUDGET need VIDEO_SAA7146 to work properly. Same 
goes for the analog video drivers VIDEO_MXB, VIDEO_DPC and the other 
saa7146 drivers.

It's somewhat annoying that you have to enable I2C before all these 
drivers can be build. The user needs to know that I2C is used somewhere 
in the driver, although he won't see anything -- all i2c drivers are 
compiled automatically, a "modprobe mxb" loads all i2c drivers it needs.

It would be better, if I2C would be enabled automatically if SAA7146 is 
set. I admit that this sort of reversed-selection can introduce new 
problems.

What do you think?

> cu
> Adrian

CU
Michael.


