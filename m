Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263597AbTG1LTn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTG1LTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:19:42 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:43957 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S263597AbTG1LTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:19:39 -0400
Message-ID: <3F250E3A.60305@genebrew.com>
Date: Mon, 28 Jul 2003 07:51:22 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: davem@redhat.com, arjanv@redhat.com, torvalds@transmeta.com,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
References: <20030725173900.D7DE12C2A9@lists.samba.org>
In-Reply-To: <20030725173900.D7DE12C2A9@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> 	If module removal is to be a rare and unusual event, it
> doesn't seem so sensible to go to great lengths in the code to handle
> just that case.  In fact, it's easier to leave the module memory in
> place, and not have the concept of parts of the kernel text (and some
> types of kernel data) vanishing.

Rusty and others,

Module removal is *not* a rare event. One common case it is used is on 
laptops during suspend. A lot of drivers do not do proper PM and so must 
be unloaded before suspend and relaoaded after resume. How will this be 
affected by removing module refcounting, even if we use your <deleted> 
idea? If nothing else, having the ability to *reload* a module -- 
thereby reinitializing the device and achieving the same effect as 
actually rmmod/insmod is what is needed.

I must say that it is somewhat disconcerting that I can rmmod a network 
driver while it is being used by a network interface. A stupid user like 
me can definitely shoot myself in the foot now.

Last but not least weren't we moving towards a more modular kernel with 
early userspace loading things from initrd as needed? Removing existing 
module functionality, however broken it may be, seems to me a step 
backward in this regard.

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

