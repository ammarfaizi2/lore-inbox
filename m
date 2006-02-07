Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWBGHuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWBGHuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 02:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbWBGHuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 02:50:44 -0500
Received: from ns1.siteground.net ([207.218.208.2]:59018 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964998AbWBGHun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 02:50:43 -0500
Date: Mon, 6 Feb 2006 23:50:53 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Christoph Lameter <clameter@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, manfred@colorfullife.com,
       shai@scalex86.org, alok.kataria@calsoftinc.com, sonny@burdell.org
Subject: Re: [patch 2/3] NUMA slab locking fixes - move irq disabling from cahep->spinlock to l3 lock
Message-ID: <20060207075053.GA3664@localhost.localdomain>
References: <20060203205341.GC3653@localhost.localdomain> <20060203140748.082c11ee.akpm@osdl.org> <Pine.LNX.4.62.0602031504460.2517@schroedinger.engr.sgi.com> <20060204010857.GG3653@localhost.localdomain> <20060204012800.GI3653@localhost.localdomain> <20060204014828.44792327.akpm@osdl.org> <20060206225117.GB3578@localhost.localdomain> <20060206153008.361202e1.akpm@osdl.org> <Pine.LNX.4.62.0602061610530.19350@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0602070925180.25555@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602070925180.25555@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 09:36:40AM +0200, Pekka J Enberg wrote:
> On Mon, 6 Feb 2006, Andrew Morton wrote:
> > > This is getting scary.  Manfred, Christoph, Pekka: have you guys taken a
> > > close look at what's going on in here?
> 
> On Mon, 6 Feb 2006, Christoph Lameter wrote:
> > I looked at his patch and he seems to be right. Most of the kmem_cache 
> > structure is established at slab creation. Updates are to the debug 
> > counters and to nodelists[] during node online/offline and to array[] 
> > during cpu online/offline. The chain mutex is used to protect the 
> > setting of the tuning parameters. I still need to have a look at the 
> > details though.
> 
> The patch looks correct but I am wondering if we should keep the spinlock 
> around for clarity? The chain mutex doesn't really have anything to do 
> with the tunables, it's there to protect the cache chain. I am worried 
> that this patch makes code restructuring harder. Hmm?

IMHO, if you keep something around which is not needed, it might later get
abused/misused.  And what would you add in as comments for the
cachep->spinlock?  

Instead,  bold comments on cachep structure stating what all members are 
protected by which lock/mutex should be sufficient no?

Thanks,
Kiran
