Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932512AbWBVBuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512AbWBVBuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWBVBuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:50:50 -0500
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:46504 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932512AbWBVBuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:50:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ARzBEcvw6vpQlEhxpiPZn11Kkff3z63ERg6nLGAx7BetWY5PKtJpZf2+5lw652nvGzRyx03vsPkDOmtgX+DrxC+0evzsl/GUDH17Yzti7ulrrl37+PbY85BWhitis14svHdCBGKeG8RgPV6kmOOnGv+0LeXBfgXJURgeaWKqSno=  ;
Message-ID: <43FBB2E8.2020300@yahoo.com.au>
Date: Wed, 22 Feb 2006 11:40:08 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [patch] Cache align futex hash buckets
References: <20060220233242.GC3594@localhost.localdomain> <43FA8938.70006@yahoo.com.au> <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0602211030240.20166@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Tue, 21 Feb 2006, Nick Piggin wrote:
> 
> 
>>Ravikiran G Thirumalai wrote:
>>
>>>Following change places each element of the futex_queues hashtable on a
>>>different cacheline.  Spinlocks of adjacent hash buckets lie on the same
>>>cacheline otherwise.
>>>
>>
>>It does not make sense to add swaths of unused memory into a hashtable for
>>this purpose, does it?
> 
> 
> It does if you essentially have a 4k cacheline (because you are doing NUMA 
> in software with multiple PCs....) and transferring control of that 
> cacheline is comparatively expensive.
> 

Instead of 1MB hash with 256 entries in it covering 256 cachelines, you
have a 1MB hash with 65536(ish) entries covering 256 cachelines.

-
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
