Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUEEI3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUEEI3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbUEEI3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:29:10 -0400
Received: from [213.133.118.2] ([213.133.118.2]:25472 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S263962AbUEEI3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:29:05 -0400
Message-ID: <4098A6BF.4090507@shadowconnect.com>
Date: Wed, 05 May 2004 10:33:03 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O subsystem fixing and cleanup for 2.6 - i2o-passthru.patch
References: <40916621.50509@shadowconnect.com> <4097DEA2.7000808@pobox.com>
In-Reply-To: <4097DEA2.7000808@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jeff Garzik wrote:
>> +struct sg_simple_element {
>> +    u32  flag_count;
>> +    u32 addr_bus;
>> +};
> if this is truly the structure, then S/G to a 64-bit address looks 
> impossible.

The structure is only used for the management software. This is only 
used, because there is no sg_io() function for char devices like it is 
for block devices.

>> +    get_user(reply_size, &user_reply[0]);
> unchecked return val?

That's true, i'll fix this.

>> +    memset(reply, 0, REPLY_FRAME_SIZE*4);
>> +    sg_offset = (msg[0]>>4)&0x0f;
>> +    msg[2] = (u32)i2o_cfg_context;
>> +    msg[3] = (u32)reply;
> when filling in message, you should probably be using cpu_to_le32()

AFAIK the msg[2] and msg[3] is not used by the I2O controller itself. It 
is only used by the driver to track messages (when a reply message comes 
back). So it should be save to not use the cpu_to_le32() here.

>> +    memset(sg_list,0, sizeof(sg_list[0])*SG_TABLESIZE);
>> +    if(sg_offset) {
>> +        // TODO 64bit fix
>> +        struct sg_simple_element *sg = (struct sg_simple_element*) 
>> (msg+sg_offset);
>> +        sg_count = (size - sg_offset*4) / sizeof(struct 
>> sg_simple_element);
> You're de-refencing based on a userland-supplied value, without checking 
> the bounds of the variable for proper range.

Okay, i'll try fix this too.

Thank you very much that you take time to review my patch.



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
