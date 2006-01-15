Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751655AbWAOF3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655AbWAOF3G (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 00:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbWAOF3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 00:29:06 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:62347 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751655AbWAOF3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 00:29:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Q95eJQJEtKXvu5/5vt0X+zjFT6PL1XiC3ddBhafw6mh1vyGjrT+00LUF9PJhJHI+e1mSM5ZzicsIRLL+8knHb3YNGF7+ojX4juSeMjfO1yLBsT1RnajHpaEa/x5jD0eZTxHMLRlaGwlUxOr9XX+6Z8Xa7aGTo7s2rtjGB0Wywn0=  ;
Message-ID: <43C9DD98.5000506@yahoo.com.au>
Date: Sun, 15 Jan 2006 16:28:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@engr.sgi.com>
CC: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: Race in new page migration code?
References: <20060114155517.GA30543@wotan.suse.de> <Pine.LNX.4.62.0601140955340.11378@schroedinger.engr.sgi.com> <20060114181949.GA27382@wotan.suse.de> <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0601141040400.11601@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sat, 14 Jan 2006, Nick Piggin wrote:
> 
> 
>>>We take that reference count on the page:
>>
>>Yes, after you have dropped all your claims to pin this page
>>(ie. pte lock). You really can't take a refcount on a page that
> 
> 
> Oh. Now I see. I screwed that up by a fix I added.... We cannot drop the 
> ptl here. So back to the way it was before. Remove the draining from 
> isolate_lru_page and do it before scanning for pages so that we do not
> have to drop the ptl. 
> 

OK (either way is fine), but you should still drop the __isolate_lru_page
nonsense and revert it like my patch does.

> Also remove the WARN_ON since its now even possible that other actions of 
> the VM move the pages into the LRU lists while we scan for pages to
> migrate.
> 

Well, it has always been possible since vmscan started batching scans a
long time ago. Actually seeing as you only take a read lock on the semaphore
it is probably also possible to have a concurrent migrate operation cause
this as well.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
