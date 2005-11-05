Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbVKEHya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbVKEHya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 02:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbVKEHya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 02:54:30 -0500
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:23567 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751180AbVKEHy3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 02:54:29 -0500
Date: Sat, 5 Nov 2005 08:54:40 +0100
From: Jean Delvare <khali@linux-fr.org>
To: James Chapman <jchapman@katalix.com>,
       Michael Burian <dynmail1@gassner-waagen.at>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH: 2.6.14] i2c chips: ds1337 1/2
Message-Id: <20051105085440.07ddb2ce.khali@linux-fr.org>
In-Reply-To: <436A71B9.6060205@katalix.com>
References: <436A71B9.6060205@katalix.com>
X-Mailer: Sylpheed version 2.0.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James, Michael, all,

> Patch for ds1337 i2c driver:
> 
> Add code to handle case where board firmware does not start the
> RTC.

I understand the idea, but I don't like the implementation. Why did you
add the initialization code to ds1337_set_datetime, rather than to
ds1337_init_client where is seems to belong?

Also, the initialization loop is way less efficient than it could be,
given the fact that the DS1337 autoincrements its address register on
write. You could at least use i2c_smbus_write_byte (instead of
i2c_smbus_write_byte_data), but even more efficient would be a block
transfer, like the ds1337_set_datetime function use.

Care to respin a patch?

Thanks,
-- 
Jean Delvare
