Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964875AbWH2SSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964875AbWH2SSG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWH2SSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:18:06 -0400
Received: from mail.suse.de ([195.135.220.2]:36520 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751148AbWH2SSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:18:02 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Tue, 29 Aug 2006 20:18:01 +0200
User-Agent: KMail/1.9.3
Cc: David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Dong Feng <middle.fengdong@gmail.com>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <44F395DE.10804@yahoo.com.au> <200608291922.04354.ak@suse.de> <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608291033380.19174@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608292018.01602.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 August 2006 19:36, Christoph Lameter wrote:
> On Tue, 29 Aug 2006, Andi Kleen wrote:
> 
> > On Tuesday 29 August 2006 17:56, Christoph Lameter wrote:
> > > On Tue, 29 Aug 2006, David Howells wrote:
> > > 
> > > > Because i386 (and x86_64) can do better by using XADDL/XADDQ.
> > > 
> > > And Ia64 would like to use fetchadd....
> > 
> > This might be a dumb question, but I would expect even on altix 
> > with lots of parallel faulting threads rwsem performance be basically
> > limited by aquiring the cache line and releasing it later to another CPU.
> 
> Correct. However, a cmpxchg may have to acquire that cacheline multiple 
> times in a highly contented situation.

Hmm, thinking about it that sounds unlikely because only the first and the last
user should touch the rwsem head. But ok it might be possible.

BTW maybe it would be a good idea to switch the wait list to a hlist,
then the last user in the queue wouldn't need to 
touch the cache line of the head. Or maybe even a single linked
list then some more cache bounces might be avoidable.

That is really why we need a single C implementation. If we had that 
such optimizations would be pretty easy. Without it it's a big mess.

> We have long tuned that portion of the code and therefore we are 
> skeptical of changes. But if we cannot measure a difference to a 
> generic implemenentation then it would be okay.

Would you be willing to run numbers comparing them? (or provide a benchmark?) 

-Andi
