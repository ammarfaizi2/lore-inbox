Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUEFTe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUEFTe2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUEFTe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 15:34:28 -0400
Received: from smtp-104-thursday.noc.nerim.net ([62.4.17.104]:9746 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262418AbUEFTe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 15:34:26 -0400
Date: Thu, 6 May 2004 21:34:55 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Michael Hunold <hunold@convergence.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       greg@kroah.com, sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6]
Message-Id: <20040506213455.29154c51.khali@linux-fr.org>
In-Reply-To: <409923F7.7050101@convergence.de>
References: <409923F7.7050101@convergence.de>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With the new I2C_CLASS_ALL flag it will be possible that an adapter
> can request that really all drivers are probed on the adapter. On the
> other hand, drivers can make sure that they get the chance to probe on
> every i2c adapter out there (this is not encouraged, though)

Depends. For example the eeprom driver will do that, and this is
correct. That said, I agree that this is a collaborative approach and
everybody will have to play the game.

> - rename I2C_ADAP_CLASS_xxx to I2C_CLASS_xxx (to be used both for 
> drivers and adapters)
> - add new I2C_CLASS_ALL and I2C_CLASS_SOUND classes

Mmm, I once proposed that I2C_ADAP_CLASS_SMBUS would be better renamed
I2C_ADAP_CLASS_SENSORS (so I2C_CLASS_SENSORS now). What about that? I
think it would be great to embed that change into your patch, so that
the name changes only once.

Now that we come to speak about that, I wonder if we would _also_ need a
SMBUS class. SMBus is mostly a subset of I2C, essentially (but not
completely) compatible. It may be useful at some point to know if a chip
is compliant with SMBus or not. I don't think that i2c-core can make use
of this at the moment, nor can I think of concrete examples where this
would be needed. It's just a thought at the moment and I mention it here
in case anyone has comments ;)

For now we can stick to the classes we have (with the SMBUS->SENSORS
change and the new SOUND class). The true SMBUS class can always be
added later if needed, I guess.

BTW, if HWMON is prefered to SENSORS, this is fine with me too, I have
no strong preference.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
