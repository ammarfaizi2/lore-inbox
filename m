Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272676AbTHKPXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272686AbTHKPXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 11:23:07 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:43968 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S272676AbTHKPXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 11:23:05 -0400
Message-ID: <3F37B4B7.9010108@colorfullife.com>
Date: Mon, 11 Aug 2003 17:22:31 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@math.psu.edu>
Subject: Re: 4GB+DEBUG_PAGEALLOC oopses with 2.6.0-test3-mm1
References: <3F361F5E.10106@colorfullife.com> <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.56.0308111024330.19887@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

>(in theory it's possible that kernel-internal mounts pass in a pointer
>where pointer + PAGE_SIZE is not a valid kernel address - if this happens
>then we'd get a hard crash.)
>  
>
Exactly that happens.
I'm running with CONFIG_PAGE_DEBUG, i.e. unallocated pages are marked as 
non-present in the linear mapping.

Regarding the i386 trap handler: show_registers tries to hexdump the 
current instructions. It did a __get_user, to avoid causing a fault when 
%eip is invalid.
Now it contains:

>      if ((user_mode(regs) && get_user(c, eip)) ||
>           (!user_mode(regs) && __direct_get_user(c, eip))) {
>              printk(" Bad EIP value.");
>              break;
>      }

I.e. it's already fixed.

--
    Manfred

