Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267786AbUIURL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267786AbUIURL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 13:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUIURL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 13:11:27 -0400
Received: from smtp07.web.de ([217.72.192.225]:9935 "EHLO smtp07.web.de")
	by vger.kernel.org with ESMTP id S267786AbUIURLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 13:11:24 -0400
Message-ID: <41506099.8000307@web.de>
Date: Tue, 21 Sep 2004 19:10:49 +0200
From: Michael Hunold <hunold-ml@web.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Michael Hunold <hunold@linuxtv.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
In-Reply-To: <20040921154111.GA13028@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21.09.2004 17:41, Greg KH wrote:
> On Mon, Sep 20, 2004 at 07:19:24PM +0200, Michael Hunold wrote:
> 
>> 
>>+	/* a ioctl like command that can be used to perform specific functions
>>+	 * with the adapter.
>>+	 */
>>+	int (*command)(struct i2c_adapter *adapter, unsigned int cmd, void *arg);

> Ick ick ick.  We don't like ioctls for the very reason they aren't type
> safe, and you can pretty much stick anything in there you want.  So
> let's not try to add the same type of interface to another subsystem.

Ok.

> How about we add the exact explicit functionality that you want, one
> function per "type" of operation, like all other subsystems have.

Hm, but the functionality depends heavily on the types of clients and 
adapters.

For the dvb subsystem, for example, if we know that the i2c adapter is 
some sort of dvb device, we might need to set the pll from the frontend 
i2c client if the user wants to tune to some frequency. The pll settings 
are very h/w specific, so they should be in the driver implementing the 
i2c adapter. So from the dvb frontend dvb i2c client we would call 
adapter->command(adapter, DVB_FE_SET_PLL, &arg).

You don't mean to add a int(*dvb_fe_set_pll)(...) function to the struct 
i2c_adapter instead, don't you?

Isn't this is a general problem? Isn't there the need to have some 
abstraction to allow message passing between i2c clients and i2c 
adapters in both ways, because i2c clients are never that independend 
from the i2c adapter and have always some h/w dependend parts inside?

> thanks,
> greg k-h

Regards
Michael.
