Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbVI3MKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbVI3MKX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 08:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbVI3MKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 08:10:23 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:61915 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S1030285AbVI3MKW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 08:10:22 -0400
Message-ID: <433D2B21.6040406@namesys.com>
Date: Fri, 30 Sep 2005 16:10:09 +0400
From: "Vladimir V. Saveliev" <vs@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <20050918110658.GA22744@infradead.org> <432E8282.6060905@namesys.com> <20050919092444.GA17501@infradead.org> <43302CF7.2010901@namesys.com> <20050920154711.GA6698@infradead.org>
In-Reply-To: <20050920154711.GA6698@infradead.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Christoph Hellwig wrote:
> ...
> Looking at the actual code all these point to the spin lock obsufcation
> SPIN_LOCK_FUNCTIONS/RW_LOCK_FUNCTIONS from spin_macros.h which I told
> to get rid of in the first round of reviews. 
> ...

reiser4 spinlock macros provide following functionality:

    (1) encapsulation of locks: instead of writing spin_lock(&obj->lock),
    where obj is object of type foo, one writes spin_lock_foo(obj).

    (2) keeping information about number of locks of particular type currently
held by thread

    (3) checking that locks are acquired in the proper order.

    (4) collection of spin lock contention statistics


I agree that (1) is not very necessary. (2) and (4) helped a lot in early
debugging. Now we are about to remove it.

However, we would prefer to keep (3). It makes catching spinlock deadlocks very
easy. Don't you think that makes sence?

Thanks
