Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbVI3R1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbVI3R1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbVI3R1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:27:09 -0400
Received: from moraine.clusterfs.com ([66.96.26.190]:23522 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751151AbVI3R1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:27:08 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17213.30072.553155.302230@gargle.gargle.HOWL>
Date: Fri, 30 Sep 2005 21:27:20 +0400
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Newsgroups: gmane.linux.kernel
In-Reply-To: <433D2B21.6040406@namesys.com>
References: <432AFB44.9060707@namesys.com>
	<20050918110658.GA22744@infradead.org>
	<432E8282.6060905@namesys.com>
	<20050919092444.GA17501@infradead.org>
	<43302CF7.2010901@namesys.com>
	<20050920154711.GA6698@infradead.org>
	<433D2B21.6040406@namesys.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir V. Saveliev writes:
 > Hello
 > 
 > Christoph Hellwig wrote:
 > > ...
 > > Looking at the actual code all these point to the spin lock obsufcation
 > > SPIN_LOCK_FUNCTIONS/RW_LOCK_FUNCTIONS from spin_macros.h which I told
 > > to get rid of in the first round of reviews. 
 > > ...
 > 
 > reiser4 spinlock macros provide following functionality:
 > 
 >     (1) encapsulation of locks: instead of writing spin_lock(&obj->lock),
 >     where obj is object of type foo, one writes spin_lock_foo(obj).
 > 
 >     (2) keeping information about number of locks of particular type currently
 > held by thread
 > 
 >     (3) checking that locks are acquired in the proper order.
 > 
 >     (4) collection of spin lock contention statistics
 > 
 > 
 > I agree that (1) is not very necessary. (2) and (4) helped a lot in early
 > debugging. Now we are about to remove it.

This was already discussed during earlier attempts to merge reiser4. The
proper solution purportedly is to make useful features of reiser4
spin-lock code generic and merge them so that the rest of kernel can
enjoy their superiority.

 > 
 > However, we would prefer to keep (3). It makes catching spinlock deadlocks very
 > easy. Don't you think that makes sence?

Lock-ordering monitoring was _immensely_ useful. For one thing it forces
one to have complete and up to date description of lock ordering.

 > 
 > Thanks

Nikita.
