Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751785AbWB1AOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWB1AOw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 19:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWB1AOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 19:14:52 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:46306 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751785AbWB1AOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 19:14:51 -0500
Message-ID: <44038C63.7010606@tmr.com>
Date: Mon, 27 Feb 2006 18:33:55 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060130 SeaMonkey/1.0
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [Patch 4/4] Tell GCC 4.1 to move unlikely() code to a separate
 section
References: <1141053825.2992.125.camel@laptopd505.fenrus.org> <1141054284.2992.136.camel@laptopd505.fenrus.org> <200602271639.34776.ak@suse.de>
In-Reply-To: <200602271639.34776.ak@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 27 February 2006 16:31, Arjan van de Ven wrote:
>> This patch is more controversial I assume; it offers the option 
>> to use the gcc 4.1 option to move unlikely() code to a separate section.
>> On the con side, this means that longer byte sequences are needed to jump
>> to this code, on the Pro side it means that the unlikely() code isn't sharing
>> icache cachelines and tlbs anymore.
> 
> I don't think this will do anything because the default Makefile
> still has
> 
> CFLAGS += -fno-reorder-blocks 
> 
> That was me because it made assembly debugging much easier. I would be willing
> to reconsider this if you can give me some hard data just from this change:
> - benchmark changes
> - .text size increase
> 
> Also I don't like it being an separate CONFIG options. We already have too many
> obscure ones. Either it should be on by default or not there at all.

I think you just made the case for an option, if it does produce 
substantially better code and justify being done, you still would want a 
way to kill it for debugging.

I'd like to see what it gains in general, and how much it depends on 
processor type and cache size.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

