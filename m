Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVFURTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVFURTH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 13:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbVFURTH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 13:19:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29905 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262212AbVFURPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 13:15:12 -0400
Date: Tue, 21 Jun 2005 13:15:09 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: cutaway@bellsouth.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] do_execve() perf improvement opportunity?
In-Reply-To: <027401c57683$a261a9f0$2800000a@pc365dualp2>
Message-ID: <Pine.LNX.4.61.0506211314010.14739@chimarrao.boston.redhat.com>
References: <000d01c5762c$5e399dc0$2800000a@pc365dualp2>
 <Pine.LNX.4.61.0506210954090.14739@chimarrao.boston.redhat.com>
 <027401c57683$a261a9f0$2800000a@pc365dualp2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2005 cutaway@bellsouth.net wrote:

> I'll try to code this up and benchmark it and see if there's anything 
> measurable.  If there is, this sort of simple minded "cache the last 
> one" scheme might be applicable elsewhere too - pipes, maybe net 
> packets, etc. It looks like Slab already sort of "caches the last one" 
> on the different granularities, but it takes a bit more code to get to 
> the point where it finally figures out it can give you back a cached 
> one.

The thing is, that code may well be in cache already, while
a cache miss on a piece of data from another CPU is really
really expensive on SMP systems.

I suspect you may be able to get more performance gains
from inserting prefetches in strategic places than from
cutting out a bit of code.

-- 
The Theory of Escalating Commitment: "The cost of continuing mistakes is
borne by others, while the cost of admitting mistakes is borne by yourself."
  -- Joseph Stiglitz, Nobel Laureate in Economics
