Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWDNON1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWDNON1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWDNON1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:13:27 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:55224 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1750752AbWDNON0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:13:26 -0400
Subject: Re: [PATCH 0/5] Swapless page migration V2: Overview
From: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       taka@valinux.co.jp, marcelo.tosatti@cyclades.com,
       kamezawa.hiroyu@jp.fujitsu.com
In-Reply-To: <Pine.LNX.4.64.0604131721340.15802@schroedinger.engr.sgi.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	 <20060413170853.0757af41.akpm@osdl.org>
	 <Pine.LNX.4.64.0604131721340.15802@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: HP/OSLO
Date: Fri, 14 Apr 2006 10:14:43 -0400
Message-Id: <1145024083.5211.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 17:27 -0700, Christoph Lameter wrote:
> On Thu, 13 Apr 2006, Andrew Morton wrote:
> 
> > > Currently page migration is depending on the ability to assign swap entries
> > > to pages. However, those entries will only be to identify anonymous pages.
> > > Page migration will not work without swap although swap space is never
> > > really used.
> > 
> > That strikes me as a fairly minor limitation?
> 
> Some people want never ever to use swap. Systems that have no swap defined 
> will currently not be able to migrate pages. Its kind of difficult to 
> comprehend that you need to have swap for migration, but then its not 
> going to be used. 
> 
> > > The patchset will allow later patches to enable migration of VM_LOCKED vmas,
> > > the ability to exempt vmas from page migration, and allow the implementation
> > > of a another userland migration API for handling batches of pages.
> > 
> > These seem like more important justifications.  Would you agree with that
> > judgement?
> 
> The swapless thing is the most important for us because many of our 
> customers do not have swap setup. Then follow the above 
> features then the efficiency consideration.

I do have the migration cache working against 17-rc1-mm2.  I tried to
address Christoph's prior comments.  I just haven't posted yet, as I was
working the migrate-on-fault/auto-migration series.  If one accepts lazy
migration, then the migration cache becomes more important because anon
pages can/will stay in the swap cache until the page is finally freed
[or maybe gets evicted from the swap cache?].

The migration cache still uses the swap infrastructure, so must
configure SWAP.  But, no swap devices need be configured.  Should
address that particular concern w/o major surgery to the existing
migration code.  

 Let me know if I should repost the patches.  Meanwhile, they're
available at:  
http://free.linux.hp.com/~lts/Patches/PageMigration/ [which seems
temporarily, I hope, unavailable].  Look for the migcache tarball.

Lee


