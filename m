Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTE3Rdo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 13:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263845AbTE3Rdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 13:33:44 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:16026 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263837AbTE3Rdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 13:33:41 -0400
Date: Fri, 30 May 2003 10:48:05 -0700
From: Hanna Linder <hannal@us.ibm.com>
Reply-To: Hanna Linder <hannal@us.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
cc: Hanna Linder <hannal@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] sx tty_driver add .owner field remove MOD_INC_DEC_USE_COUNT 
Message-ID: <31470000.1054316885@w-hlinder>
In-Reply-To: <20030530080556.EC79C17DE1@ozlabs.au.ibm.com>
References: <20030530080556.EC79C17DE1@ozlabs.au.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Heh. I figured out why I deleted it, it was not a mistake. The whole
function is commented out! Except the func_enter and exit calls which
are printk wrappers. Besides, no one ever calls this function anyway...

So leave it out. No need to put it back in...

Hanna


--On Friday, May 30, 2003 06:05:24 PM +1000 Rusty Russell <rusty@au1.ibm.com> wrote:
> In message <12430000.1054244110@w-hlinder> you write:
>> --On Thursday, May 29, 2003 12:02:50 PM -0700 Greg KH <greg@kroah.com> wrote:
>> 
>> > 
>> > Ick, this patch should be reverted, it should not be removing
>> > sx_hungup() for no reason.  I think Hanna agrees with this.
>> 
>> Yup. Sorry. Not sure what happened there. Here is the patch
>> to replace the sx_hangup function. This is based off 2.5.70-bk3
>> and I have compiled it but dont have the hardware to test it.
> 
> Yes, but I don't think you need to put back the comment about
> decrementing use counts 8)
> 
>> +/* I haven't the foggiest why the decrement use count has to happen
>> +   here. The whole linux serial drivers stuff needs to be redesigned.
>> +   My guess is that this is a hack to minimize the impact of a bug
>> +   elsewhere. Thinking about it some more. (try it sometime) Try
>> +   running minicom on a serial port that is driven by a modularized
>> +   driver. Have the modem hangup. Then remove the driver module. Then
>> +   exit minicom.  I expect an "oops".  -- REW */
> 
> Cheers,
> Rusty.
> --
>   Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
> 


