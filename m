Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262861AbVBDAE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbVBDAE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVBDAE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:04:57 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:44027 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262861AbVBDAEZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:04:25 -0500
Message-ID: <4202BBF9.3020104@mvista.com>
Date: Thu, 03 Feb 2005 17:04:09 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@mail.ru>
CC: Greg KH <greg@kroah.com>, phil@netroedge.com, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org, khali@linux-fr.org
Subject: Re: [PATCH][I2C] Marvell mv64xxx i2c driver
References: <200502020315.14281.adobriyan@mail.ru> <200502031556.59319.adobriyan@mail.ru> <4202779C.6010304@mvista.com> <200502040238.57048.adobriyan@mail.ru>
In-Reply-To: <200502040238.57048.adobriyan@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:

>On Thursday 03 February 2005 21:12, Mark A. Greer wrote:
>
>  
>
>>>>+		mv64xxx_i2c_fsm(drv_data, status);
>>>>        
>>>>
>>>It can set drv_data->rc to -ENODEV or -EIO. In both cases ->action goes to
>>>MV64XXX_I2C_ACTION_SEND_STOP and mv64xxx_i2c_do_action() will writel()
>>>something. Is it correct to _not_ check ->rc here?
>>>      
>>>
>>I think so.  It still needs to go into do_action even when rc != 0 (in 
>>which case it'll do a STOP condition).
>>    
>>
>
>Ok. Thanks for the explanation. Agree, ->rc should be left as is.
>

Okay.

>  
>
>>--- a/include/linux/i2c-id.h
>>+++ b/include/linux/i2c-id.h
>>    
>>
>
>  
>
>>+					/* 0x170000 - USB		*/
>>+					/* 0x180000 - Virtual buses	*/
>>+#define I2C_ALGO_MV64XXX 0x190000       /* Marvell mv64xxx i2c ctlr	*/
>>    
>>
>
>While I searched for typos and you're fixing them, au1550 owned 0x170000.
>2.6.11-rc3 says:
>
>	#define I2C_ALGO_AU1550 0x170000 /* Au1550 PSC algorithm */
>
>So, I'd remove first two comments.
>

I added the comments b/c of this email from Jean Delvare, 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0501.3/0977.html.  The 
relevant part being:

"0x170000 is reserved within the legacy i2c project for an USB algorithm,
and 0x180000 for virtual busses. Could you please use 0x190000 instead,
so as to avoid future collisions?"

It looks like I2C_ALGO_AU1550 was just added so my guess is Jean is 
correct and I2C_ALGO_AU1550 should be made 0x1a0000 (or I move mine back 
one).  Would someone confirm that 0x170000 is used by legacy i2c stuffs? 
I don't really know where to look.  If so, I can easily make a patch 
moving it back.

>Oh, and the last note: current sparse and gcc 4 don't produce any warnings.
>  
>

Cool!

Mark

