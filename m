Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbTIMAbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbTIMAbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:31:06 -0400
Received: from fed1mtao07.cox.net ([68.6.19.124]:19887 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S261965AbTIMAbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:31:02 -0400
Message-ID: <3F626544.40000@cox.net>
Date: Fri, 12 Sep 2003 17:31:00 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Andreas Schwab <schwab@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
References: <3F621AC4.4070507@cox.net> <200309121453.07111.arnd@arndb.de> <3F625A26.7050305@cox.net> <200309130222.43612.arnd@arndb.de>
In-Reply-To: <200309130222.43612.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

> This doesn't work, because size_t is a typedef, not a macro.

Yeah, I should have thought of that. Sorry.

> The type checking this in user space is not necessary, because 
> the point of the check is only to keep people from adding *new*
> invalid ioctl numbers and doing the check for the kernel does that.
> However, the old numbers need to be kept for a long time and there
> is no point in breaking user applications that use established
> interfaces.

Hmm, obviously I misunderstood how this worked. Does that mean that 
these two lines:

#define BLKGETSIZE64	_IOR(0x12,114,sizeof(__uint64_t))
#define BLKGETSIZE64	_IOR(0x12,114,__uint64_t)

actually produce different ioctl numbers? If so, then I don't 
understand how the kernel can continue to offer the old/invalid 
interface when the new _IOR macro won't accept the first version any 
longer.

