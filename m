Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262067AbVBARBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262067AbVBARBR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 12:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVBARBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 12:01:17 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:63710 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262067AbVBARBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 12:01:09 -0500
Message-ID: <41FFB5BB.2070400@nortelnetworks.com>
Date: Tue, 01 Feb 2005 11:00:43 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linuxppc-dev@ozlabs.org, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on symbol exports
References: <41FECA18.50609@nortelnetworks.com>	 <1107243398.4208.47.camel@laptopd505.fenrus.org>	 <41FFA21C.8060203@nortelnetworks.com> <1107273017.4208.132.camel@laptopd505.fenrus.org>
In-Reply-To: <1107273017.4208.132.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2005-02-01 at 09:37 -0600, Chris Friesen wrote:

>>I've got a module that I'm porting forward from 2.4.  The basic idea is 
>>that we want to be able to track pages dirtied by an application.  The 
>>system has no swap, so we use the dirty bit to get this information.  On 
>>demand we walk the page tables belonging to the process, store the 
>>addresses of any dirty ones, flush the tlb, and mark them clean.
> 
> 
> afaik one doesn't need to do a tlb flush in code that clears the dirty
> bit, as long as you use the proper vm functions to do so. 
> (if those need a tlb flush, those are supposed to do that for you
> afaik).

I've been in contact with one of the developers of the code.  The reason 
we flush the tlb is so that on the next write the cpu has to fault it in 
and set the dirty bit.  Does that make sense?  I should try 
experimenting.....

> Also note that your code isn't dealing with 4 level pagetables.... 

2.6.9 doesn't have 4 level pagetables.  We'll have to port it forward 
when we eventually upgrade.

 > And
> pagetable walking in drivers is basically almost always a mistake and a
> sign that something is wrong.

I'd rather not be doing it, but there's no nice generic va_to_pte() 
function.  There have been patches, and ppc has one, but as a whole I 
don't know of any nice way to do this.

Chris

