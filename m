Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbTILXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbTILXpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 19:45:09 -0400
Received: from fed1mtao08.cox.net ([68.6.19.123]:59887 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261957AbTILXpF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 19:45:05 -0400
Message-ID: <3F625A26.7050305@cox.net>
Date: Fri, 12 Sep 2003 16:43:34 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: Andreas Schwab <schwab@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] new ioctl type checking causes gcc warning
References: <3F621AC4.4070507@cox.net> <je65jx3hdk.fsf@sykes.suse.de> <200309121453.07111.arnd@arndb.de>
In-Reply-To: <200309121453.07111.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

> I had tried that first, but found that there are places that
> use asm/ioctl.h without including asm/posix_types.h first, so 
> size_t might not be declared. unsigned int (or unsigned long)
> is the better alternative here. Does this look ok to everyone?

After working on this some more this afternoon, I realize now that 
it's much better to have the typechecking in place than not, even for 
userspace. Maybe the best solution is to still leave the typechecking 
(don't wrap it in #ifdef __KERNEL__), and just

#ifdef size_t
extern size_t __invalid_size_argument_for_IOC;
#else
extern unsigned int __invalid_size_argument_for_IOC;
#endif

Would the type specification of this non-existent variable ever 
actually effect the generated code? If not, then even putting this 
#ifdef in is overkill.

