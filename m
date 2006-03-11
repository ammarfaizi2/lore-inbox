Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWCKM35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWCKM35 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 07:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWCKM35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 07:29:57 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:37046 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750793AbWCKM34 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 07:29:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=na7qqvr6yX0W+/Xta2cI9gQ8Xxnkxc+m6MbtveS3KXH3sZd2p2y8Vnf2Y22K9bzqd0E1GOeEt7afpqkM/7P02YmSSLj24eKjtXdYPpZlB6jcdshovklOnRp2TLUDeivmIXD3UkLWneKpA/zOcNyfxCmBmQ7wfNIScOr5+Y+kDl8=
Message-ID: <aec7e5c30603110429tcad0ff1lc0073c613486eec5@mail.gmail.com>
Date: Sat, 11 Mar 2006 21:29:55 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: sekharan@us.ibm.com
Subject: Re: [PATCH 03/03] Unmapped: Add guarantee code
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Magnus Damm" <magnus@valinux.co.jp>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       "Valerie Clement" <Valerie.Clement@bull.net>
In-Reply-To: <1142005277.8174.107.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <20060310034429.8340.61997.sendpatchset@cherry.local>
	 <44110727.802@yahoo.com.au>
	 <aec7e5c30603092204h21fa7639wf90e6d4e2fdee128@mail.gmail.com>
	 <1142005277.8174.107.camel@linuxchandra>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/06, Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> On Fri, 2006-03-10 at 15:04 +0900, Magnus Damm wrote:
> > On 3/10/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> > > Magnus Damm wrote:
> > > If your app is really that specialised then maybe it can use mlock. If
> > > not, maybe the VM is currently broken.
> > >
> > > You do have a real-world workload that is significantly improved by this,
> > > right?
> >
> > Not really, but I think there is a demand for memory resource control today.
>
> As a person who is working on CKRM, I totally agree with this :)

Hehe, good to head that I'm not alone. =)

> > The memory controller in ckrm also breaks out the LRU, but puts one
> > LRU instance in each class. My code does not depend on ckrm, but it
> > should be possible to have some kind of resource control with this
>
> i do not understand how breaking lru lists into mapped/unmapped pages
> and providing a knob to control the proportion of mapped/unmapped pages
> in a node help in resource control.

It is one type of resource control. It is of course not a complete
solution like ckrm, but on machines with more than one node (or a
regular PC with numa emulation) it is possible to create partitions
using CPUSETS and then use this patch to control the amount of memory
that should be dedicated for say mapped pages on each node.

CKRM and CPUSETS are the ways to provide resource control today.
CPUSETS is coarse-grained, but CKRM aims for finer granularity. None
of them have a way to control the ratio between mapped and unmapped
pages, excluding this patch.

I'd like to see CKRM merged, but I'm not the one calling the shots
(probably fortunate enough for everyone). I think CKRM has the same
properties as the ClockPRO work - it would be nice to have it included
in mainline, but these patches modify lots of crital code and
therefore has problems getting accepted that easily.

So this patch is YASSITRD. (Yet Another Small Step In The Right Direction)

Thank you!

/ magnus
