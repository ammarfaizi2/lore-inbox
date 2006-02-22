Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWBVEJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWBVEJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 23:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWBVEJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 23:09:01 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:20370 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751333AbWBVEJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 23:09:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=oVXpCB4hEZHgygiuypuqUf97sLN732Kaj/lZeuLLBLgD9N541xbApr6ZoCGCYr8hcHzFWa7W8n/JceWvImDGbM+w47dHBSkbHxdpiDGardTcuM9RVk4kfTWS7tyRvodODG0MmtV/mQiaQl88sHl3qp3pEjU2hlMPk8pEstYAS/I=  ;
Message-ID: <43FBCE56.9020001@yahoo.com.au>
Date: Wed, 22 Feb 2006 13:37:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: clameter@engr.sgi.com, kiran@scalex86.org, linux-kernel@vger.kernel.org,
       shai@scalex86.org
Subject: Re: [patch] Cache align futex hash buckets
References: <20060220233242.GC3594@localhost.localdomain>	<43FA8938.70006@yahoo.com.au>	<Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>	<43FBB2E8.2020300@yahoo.com.au> <20060221180845.79a44449.akpm@osdl.org>
In-Reply-To: <20060221180845.79a44449.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>Instead of 1MB hash with 256 entries in it covering 256 cachelines, you
>>have a 1MB hash with 65536(ish) entries covering 256 cachelines.
>>
> 
> 
> Good (if accidental point).  Kiran, if you're going to gobble a megabyte,
> you might as well use all of it and make the hashtable larger, rather than
> just leaving 99% of that memory unused...
> 

We chould probably also convert the list_head over to an hlist_head,
for a modest saving in size (although that's more important from a
cache footprint POV rather than improving cacheline bouncing).

Although speaking of cacheline footprint: making the hash table so
large will increase the "real" CPU cacheline footprint on your VSMP
systems, so perhaps it is not always such an easy decision.

Definitely for "normal" systems, we do not want to pad out to a
single entry per cacheline, so the current patch can not go upstream
as is.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
