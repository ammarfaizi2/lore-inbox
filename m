Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbVKEKzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbVKEKzX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 05:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVKEKzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 05:55:23 -0500
Received: from s14.s14avahost.net ([66.98.146.55]:63460 "EHLO
	s14.s14avahost.net") by vger.kernel.org with ESMTP id S1751374AbVKEKzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 05:55:22 -0500
Message-ID: <436C8F8A.7040803@katalix.com>
Date: Sat, 05 Nov 2005 10:55:06 +0000
From: James Chapman <jchapman@katalix.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Michael Burian <dynmail1@gassner-waagen.at>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: 2.6.14] i2c chips: ds1337 1/2
References: <436A71B9.6060205@katalix.com> <20051105085440.07ddb2ce.khali@linux-fr.org>
In-Reply-To: <20051105085440.07ddb2ce.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PopBeforeSMTPSenders: jchapman@katalix.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s14.s14avahost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - katalix.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi James, Michael, all,
> 
> 
>>Patch for ds1337 i2c driver:
>>
>>Add code to handle case where board firmware does not start the
>>RTC.
> 
> 
> I understand the idea, but I don't like the implementation. Why did you
> add the initialization code to ds1337_set_datetime, rather than to
> ds1337_init_client where is seems to belong?

Michael originally put the code in init_client. I moved it because I 
thought some might not want the RTC started at init time, only when 
userspace explicitely set time. It's no big deal to move it again.

> Also, the initialization loop is way less efficient than it could be,
> given the fact that the DS1337 autoincrements its address register on
> write. You could at least use i2c_smbus_write_byte (instead of
> i2c_smbus_write_byte_data), but even more efficient would be a block
> transfer, like the ds1337_set_datetime function use.

I agree. I missed that.

> Care to respin a patch?

Michael?

-- 
James Chapman
Katalix Systems Ltd
http://www.katalix.com
Catalysts for your Embedded Linux software development

