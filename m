Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbTIGV2r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 17:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbTIGV2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 17:28:47 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:51093 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S261493AbTIGV2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 17:28:46 -0400
Message-Id: <200309072128.h87LScJZ009118@post.webmailer.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
To: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>
Date: Sun, 07 Sep 2003 23:28:55 +0200
References: <tbGb.75d.15@gated-at.bofh.it> <tbPO.7j9.5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
>> Ie, change the (sizeof(x)) to something like
>>
>>      ({ x __dummy; sizeof(__dummy); })
>>
>> which should work with all compiler versions.
> 
> This won't work with array types, eg. in <linux/random.h>:
> 
> #define RNDGETPOOL    _IOR( 'R', 0x02, int [2] )

How about changing (sizeof(x)) to (sizeof(x[1]))?
It will result in "parse error before `['" when x is not
a type or an array type.

        Arnd <><
