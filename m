Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbWASHYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbWASHYz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 02:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbWASHYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 02:24:55 -0500
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:40718 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1161079AbWASHYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 02:24:54 -0500
Date: Thu, 19 Jan 2006 08:25:41 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Andrey Volkov <avolkov@varma-el.com>, adi@hexapodia.org,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] i2c: Combined ST m41txx i2c rtc chip driver
Message-Id: <20060119082541.17aff81f.khali@linux-fr.org>
In-Reply-To: <20060118220600.GF15714@mag.az.mvista.com>
References: <4378960F.8030800@varma-el.com>
	<20051115215226.4e6494e0.khali@linux-fr.org>
	<20051116025714.GK5546@mag.az.mvista.com>
	<20051219210325.GA21696@mag.az.mvista.com>
	<43A7D76E.5050008@varma-el.com>
	<20060111000912.GA11471@mag.az.mvista.com>
	<43C4D275.2070505@varma-el.com>
	<20060111161954.GB6405@mag.az.mvista.com>
	<43C5567C.8070106@varma-el.com>
	<20060118220600.GF15714@mag.az.mvista.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Andrey,

> On Wed, Jan 11, 2006 at 10:03:24PM +0300, Andrey Volkov wrote:
> <snip>
> > P.S. Jean, "i2c_master_send vs i2c_smbus_write_byte_data"
> > problem still open.
> > Could you made executive decision about it?
> 
> I'm taking the roaring silence to mean nobody really cares so I don't
> really have a problem going your way.  I'll submit a patch and if it
> gets pooh-pooh'd, we can always change it back.

Sorry for the very late answer, I hadn't realized you were waiting for
me.

The I2C vs. SMBus interface choice is yours (as long as the device
supports both). I2C brings performance, SMBus gives you compatibility.
Depending on the device you are writing a driver for, compatibility may
or may not matter. For example, for a hardware monitoring chip driver,
we always go for SMBus, because these chips are almost always connected
to non-I2C SMBus masters. But RTC drivers are typically not used on
mainstream PC motherboards so the compatibility may not be needed.

So, as Mark says, you should just go with the code you have right now.
If it is SMBus and someone finds it too slow, that person can always
add I2C access afterwards. OTOH if it is I2C and someone ever needs
compatibility with a non-I2C master, that person gets to add the code.
Note that it is perfectly acceptable to have *both* I2C and SMBus
access methods in the same driver, if compatibility is wanted but the
performance gain using I2C is significant. Of course it means more code
in the driver, but as long as both access methods work and are properly
maintained, it's fine with me.

Thanks,
-- 
Jean Delvare
