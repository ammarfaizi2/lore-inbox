Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUIUSGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUIUSGY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 14:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267943AbUIUSGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 14:06:24 -0400
Received: from smtp08.web.de ([217.72.192.226]:21385 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S267939AbUIUSGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 14:06:18 -0400
Message-ID: <41506D78.6030106@web.de>
Date: Tue, 21 Sep 2004 20:05:44 +0200
From: Michael Hunold <hunold-ml@web.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Greg KH <greg@kroah.com>, Michael Hunold <hunold@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>	 <41506099.8000307@web.de> <9e4733910409211039273d5a2f@mail.gmail.com>
In-Reply-To: <9e4733910409211039273d5a2f@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21.09.2004 19:39, Jon Smirl wrote:
> There is a related I2C problem with EEPROMs and DDC monitors. DDC
> monitors look just like EEPROMs, the EEPROM driver can even read most
> of them. But there are DDC monitors that need special wakeup sequences
> before their ROMs will appear.
> 
> EEPROM and DDC are both algo_bit clients. When you attach a bus to
> algo_bit both clients will run. There is concern that sending the
> special DDC wake up sequence down non-DDC buses might mess up the bus.
> 
> A proposal was made to implement different classes of algo_bit clients
> but this was never implemented. Would a class solution help with the
> dvb problem too?

It would help to separate dvb clients and dvb busses. I just posted 
another mail titled "Adding .class field to struct i2c_client (was Re: 
[PATCH][2.6] Add command function to struct i2c_adapter" that adds a 
.class entry to the struct i2c_client.

With that addition, it's possible for the i2c core to check if the 
.class entries of the adapter and the client match. If they don't then 
there is no need to probe a driver. This will help to keep non-i2c 
drivers to be probed on dvb i2c busses (and screw them up accidently). 
Currently it's up to the driver to decide wheter to probe a bus or not.

CU
Michael.

