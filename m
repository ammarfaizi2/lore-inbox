Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWCMDLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWCMDLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 22:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWCMDLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 22:11:12 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:42898 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750969AbWCMDLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 22:11:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=UvZ+z4MS65Yx1x9RWJhyvnzDE3eAhmkVuBDR2h4Lm/8TcWgnWVmcGcuDUSPMd0L3ZIwHe5SbWFH6QeRvUhTd+kPWw9udziru0872vDVqvhYlIkF6YLJtag17VB2Fzpku0Cf2qJmI/wU8R9iV2GzksISHTkXvQwE+kTx+zO9LnmM=  ;
Message-ID: <4414E2CB.7060604@yahoo.com.au>
Date: Mon, 13 Mar 2006 14:11:07 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Nick Piggin <npiggin@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 1/3] radix tree: RCU lockless read-side
References: <20060207021822.10002.30448.sendpatchset@linux.site>	 <20060207021831.10002.84268.sendpatchset@linux.site>	 <661de9470603110022i25baba63w4a79eb543c5db626@mail.gmail.com>	 <44128EDA.6010105@yahoo.com.au> <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
In-Reply-To: <661de9470603121904h7e83579boe3b26013f771c0f2@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir Singh wrote:
> On 3/11/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Balbir Singh wrote:
>>
>>><snip>
>>>
>>>>               if (slot->slots[i]) {
>>>>-                       results[nr_found++] = slot->slots[i];
>>>>+                       results[nr_found++] = &slot->slots[i];
>>>>                       if (nr_found == max_items)
>>>>                               goto out;
>>>>               }
>>>
>>>
>>>A quick clarification - Shouldn't accesses to slot->slots[i] above be
>>>protected using rcu_derefence()?
>>>
>>
>>I think we're safe here -- this is the _address_ of the pointer.
>>However, when dereferencing this address in _gang_lookup,
>>I think we do need rcu_dereference indeed.
>>
> 
> 
> Yes, I saw the address operator, but we still derefence "slots" to get
> the address.
> 

But we should have already rcu_dereference()ed "slot", right
(in the loop above this one)? That means we are now able to
dereference it, and the data at the other end will be valid.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
