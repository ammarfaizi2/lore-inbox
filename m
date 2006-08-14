Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751831AbWHNDnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbWHNDnj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 23:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWHNDnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 23:43:39 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:18070 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751829AbWHNDni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 23:43:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kmI0z/gBSomEvlIDfskHEBzxyeQGI4DF1teKvTA0erhb1oGF52wtZn4fAW2vRKDdpNtkQkjEisNViK7p0j9suFn/Mg/RaW5JM1Zzcg6jACmgl7T/FsYc3AgGZMnQwg4ro62peBdHPiMmQ8wfDhfOmNFVGkoprTAPGw4BPoz3Sdo=  ;
Message-ID: <44DFF11C.406@yahoo.com.au>
Date: Mon, 14 Aug 2006 13:42:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Daniel Phillips <phillips@google.com>, a.p.zijlstra@chello.nl,
       jeff@garzik.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, indan@nul.nu, johnpol@2ka.mipt.ru,
       riel@redhat.com, davem@davemloft.net
Subject: Re: rename *MEMALLOC flags
References: <20060812141415.30842.78695.sendpatchset@lappy>	<20060812141445.30842.47336.sendpatchset@lappy>	<44DDE8B6.8000900@garzik.org>	<1155395201.13508.44.camel@lappy>	<44DFBEA3.5070305@google.com> <20060813180054.65201239.pj@sgi.com>
In-Reply-To: <20060813180054.65201239.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> Daniel wrote:
> 
>>Inventing a new name for an existing thing is very poor taste on grounds of
>>grepability alone.
> 
> 
> I wouldn't say 'very poor taste' -- just something that should be
> done infrequently, with good reason, and with reasonable concensus,
> especially from the key maintainers in the affected area.
> 
> Good names are good taste, in my book.  But stable naming is good too.
> 
> I wonder what Nick thinks of this?  Looks like he added
> __GFP_NOMEMALLOC a year ago, following the naming style of PF_MEMALLOC.
> 
> I added him to the cc list.
> 

__GFP_NOMEMALLOC was added to prevent mempool backed allocations from
accessing the emergency reserve. Because that would just shift deadlocks
from mempool "safe" sites to those which have not been converted.

PF_MEMALLOC is a good name: PF_MEMALLOC says that the task is currently
allocating memory. It does not say anything about the actual allocator
implementation details to handle this (1. don't recurse into reclaim; 2.
allow access to reserves), but that is a good thing.

__GFP_NOMEMALLOC and __GFP_MEMALLOC are poorly named (I take the blame).
It isn't that the task is suddenly no longer allocating in the context
of an allocation, it is just that you want to allow or deny access to
the reserve.

__GFP_NOMEMALLOC should be something like __GFP_EMERG_NEVER and
__GFP_MEMALLOC should be _ALWAYS. Or something like that.

NOMEMALLOC is specific enough that I don't mind a rename at this stage.
Renaming PF_MEMALLOC would be wrong, however.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
