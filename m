Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262137AbSJAQf6>; Tue, 1 Oct 2002 12:35:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262138AbSJAQf6>; Tue, 1 Oct 2002 12:35:58 -0400
Received: from dsl-213-023-043-077.arcor-ip.net ([213.23.43.77]:2460 "EHLO
	starship") by vger.kernel.org with ESMTP id <S262137AbSJAQf5>;
	Tue, 1 Oct 2002 12:35:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Dave McCracken <dmccr@us.ibm.com>,
       "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Page table sharing
Date: Tue, 1 Oct 2002 18:28:52 +0200
X-Mailer: KMail [version 1.3.2]
References: <E17wMl3-0005tY-00@starship> <851859439.1033463169@[10.10.2.3]>
In-Reply-To: <851859439.1033463169@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17wPtF-0005uu-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 October 2002 18:06, Martin J. Bligh wrote:
> > I'm not sure how relevant page table sharing has to the halloween 
> > deadline since it's not a feature per se, just an optimization.   
> > It has more to do with getting numa ia32 boxes to survive, so it's 
> > an ideal out-of-tree patch.
> 
> Any large 32 bit box with significant numbers of processes will need 
> it to cope with the bloat that rmap introduced - this has nothing to
> do with NUMA (some apps may be saved by large pages, some not). 
> Avoiding hangs from ZONE_NORMAL oom is not an "optimisation", and I 
> doubt optimisations involving major VM changes would be very welcome
> after the freeze. This is something we need to get working ASAP ...

Any reason why page table swapping wouldn't deliver just as much bang
for the buck?  Same argument re VM changes.

Anyway, I don't necessarily buy the VM change argument.  I've already
established that turning sharing off either at compile time or run
time is trivial, so there is no element of risk.  I'd suggest: take
a deep breath, relax, go slow and get it right.

What we should be coding right now is the patch Linus already asked
for, to recover page table pages as soon as possible instead of in
clear_page_tables.  With that in place the locking for shared page
tables gets a lot nicer, as Linus showed.

-- 
Daniel
