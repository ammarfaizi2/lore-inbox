Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318280AbSGRRjs>; Thu, 18 Jul 2002 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318281AbSGRRjs>; Thu, 18 Jul 2002 13:39:48 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8434 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318280AbSGRRjr>; Thu, 18 Jul 2002 13:39:47 -0400
Subject: Re: [PATCH] strict VM overcommit for stock 2.4
From: Robert Love <rml@tech9.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207181806220.30902-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207181806220.30902-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Jul 2002 10:42:41 -0700
Message-Id: <1027014161.1086.123.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 09:36, Szakacsits Szabolcs wrote:

> This is what I would do first [make sure you don't hit any resource,
> malloc, kernel memory mapping, etc limits -- this is a simulation that
> must eat all available memory continually]:
> main(){void *x;while(1)if(x=malloc(4096))memset(x,666,4096);}
> 
> When the above used up all the memory try to ssh/login to the box as
> root and clean up the mess. Can you do it?

Three points:

- with strict overcommit and the "allocations must meet backing store"
rule (policy #3) the above can never use all physical memory

- if your point is that a rogue user can use all of the systems memory,
then you need per-user resource accounting.

- the point of this patch is to not use MORE memory than the system
has.  I say nothing else except that I am trying to avoid OOM and push
the allocation failures into the allocations themselves.  Assuming the
accounting is correct (and it seems to be) then Alan and I have
succeeded.

	Robert Love

