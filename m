Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVCYTuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVCYTuP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVCYTuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:50:15 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:48402 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261766AbVCYTuJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:50:09 -0500
Date: Fri, 25 Mar 2005 20:50:35 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: OOPS running "ls -l /sys/class/i2c-adapter/*"-- 2.6.12-rc1-mm2
Message-Id: <20050325205035.23362e79.khali@linux-fr.org>
In-Reply-To: <20050325104032.786c4257.akpm@osdl.org>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<a44ae5cd05032420122cd610bd@mail.gmail.com>
	<20050324202215.663bd8a9.akpm@osdl.org>
	<20050325073846.A18596@flint.arm.linux.org.uk>
	<20050324234544.135a1eb2.akpm@osdl.org>
	<20050325104032.786c4257.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Miles,

> > Andrew, this command causes the Oops for me:
> > 
> > root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls
> > ./  ../  device@
> > root@Monkey100:/sys/class/i2c-adapter/i2c-1# ls -l
> > Segmentation fault
> 
> What device is that, and which driver is handling it?

If I am allowed a wild guess here... Isn't by any chance i2c-1 one the
the 3 i2c adapters exported by the nvidiafb driver, which we know isn't
playing nicely with the i2c core? To me, it is simply a different
expression of the same bug Miles hit some days ago when loading the
i2c-dev or eeprom modules [1].

Miles, do you have the same problem with i2c-0 and i2c-2, or only i2c-1?

Can you please confirm that with CONFIG_FB_NVIDIA_I2C unset, the oops
vanishes?

[1] http://archives.andrew.net.au/lm-sensors/msg29974.html

Thanks,
-- 
Jean Delvare
