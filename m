Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWDEXtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWDEXtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 19:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWDEXtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 19:49:50 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:16765 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751206AbWDEXtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 19:49:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=mO9UcOT0gfA2ItvAP3c+J9KvWBFAzFzQ+GzYcLnyt+qViVFIRev7UW1EG6Jb9/L7AQ3l5iXm93NicfPzUthU2ItABWX3roItJxHbc5xMulTlGtD1Vmb/X8IqOHH/8uKTvVQWcsJ6J0lQNG+wDHQQPZZ0vfyFK8tuS8nf98sL5CI=  ;
Message-ID: <44330DC6.1040805@yahoo.com.au>
Date: Wed, 05 Apr 2006 10:22:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2/3] mm: speculative get_page
References: <20060219020140.9923.43378.sendpatchset@linux.site> <20060219020159.9923.94877.sendpatchset@linux.site> <Pine.LNX.4.64.0604040814140.26807@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604040814140.26807@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> Looks like the NoNewRefs flag is mostly == 
> spin_is_locked(mapping->tree_lock)? Would it not be better to check the 
> tree_lock?
> 

Well there are other uses for the tree_lock (eg. tag operations)
which do not need the "no new references" guarantee.

> 
> 
>>--- linux-2.6.orig/mm/migrate.c
>>+++ linux-2.6/mm/migrate.c
>> 
>>+	SetPageNoNewRefs(page);
>> 	write_lock_irq(&mapping->tree_lock);
> 
> 
> A dream come true! If this is really working as it sounds then we can 
> move the SetPageNoNewRefs up and avoid the final check under 
> mapping->tree_lock. Then keep SetPageNoNewRefs until the page has been 
> copied. It would basically play the same role as locking the page.
> 

Yes we could do that but at this stage I wouldn't like to seperate
SetPageNoNewRefs from tree_lock, as it is replacing a traditional
guarantee that tree_lock no longer provides.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
