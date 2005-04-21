Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVDUSlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVDUSlG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261716AbVDUSlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:41:05 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:65422 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261710AbVDUSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:40:52 -0400
Message-ID: <4267F367.3090508@ammasso.com>
Date: Thu, 21 Apr 2005 13:39:35 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: Andy Isaacson <adi@hexapodia.org>
CC: Troy Benjegerdes <hozer@hozed.org>, Bernhard Fischer <blist@aon.at>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC][0/4] InfiniBand userspace verbs
 implementation
References: <20050421173821.GA13312@hexapodia.org>
In-Reply-To: <20050421173821.GA13312@hexapodia.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson wrote:

> If you take the hardline position that "the app is the only thing that
> matters", your code is unlikely to get merged.  Linux is a
> general-purpose OS.

The problem is that our driver and library implement an API that we don't fully control. 
The API states that the application allocates the memory and tells the library to register 
it.  The app then goes on its merry way until it's done, at which point it tells the 
library to deregister the memory.  Neither the app nor the API has any provision for the 
app to be notified that the memory is no longer pinned and therefore can't be trusted. 
That would be considered a critical failure from the app's perspective, so the kernel 
would be doing it a favor by killing the process.

> You might want to consider what happens with your communication system
> in a machine running power-saving modes (in the limit, suspend-to-disk).
> Of course most machines with Infiniband adapters aren't running swsusp,
> but it's not inconceivable that blade servers might sleep to lower power
> and cooling costs.

Any application that registers memory, will in all likelihood be running at 100% CPU 
non-stop.  The computer is not going to be doing anything else but whatever that app is 
trying to do.  The application could conceiveable register gigabytes of RAM, and if even a 
single page becomes unpinned, the whole thing is worthless.  The application cannot do 
anything meaningful if it gets a message saying that some of the memory has become 
unpinned and should not be used.

So the real question is: how important is it to the kernel developers that Linux support 
these kinds of enterprise-class applications?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
