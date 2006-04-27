Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWD0DbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWD0DbO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 23:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWD0DbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 23:31:14 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:44379 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964909AbWD0DbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 23:31:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZAH+urJ4N11q6a5Rfv500F9lMC4YqApKoeaBgHdZaTMDV3TN5R5YUxGebAW5x3wQOOac5hn3a4b0H36K1utyPCajAH4HNyrbeGTR3iLgKHFz0f+SsNMwzxKEHaD1Jv8wKXnlpyj9z6a/OQK1IFHwCm3v0PwYjP+U+wsEyXbpJ94=  ;
Message-ID: <44503AD5.9020605@yahoo.com.au>
Date: Thu, 27 Apr 2006 13:30:29 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Zachary Amsden <zach@vmware.com>
CC: Andrew Morton <akpm@osdl.com>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Jan Beulich <jbeulich@novell.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>
Subject: Re: [PATCH 2/2] I386 convert pae wmb to non smp
References: <200604262203.k3QM3qOC009581@zach-dev.vmware.com> <445009A2.3030305@yahoo.com.au> <445019E7.80900@vmware.com>
In-Reply-To: <445019E7.80900@vmware.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden wrote:

> Nick Piggin wrote:
>
>> wmb() means that it also orders IO memory. It is no difference for
>> i386, but smp_wmb() actually has the right semantics of the abstract
>> Linux memory model.
>
>
> The name is pretty confused.  smp_wmb seems to imply an SMP-only 
> barrier, whereas we want here a write barrier on regular memory.


That is just a compiler barrier (barrier()). A CPU should always be 
consistent with
itself so memory ordering doesn't really apply there (hence smp_ prefix, 
which also
are compiler barriers, of course).

>   Both smp_wmb and wmb() are identical in that they both reduce to 
> barrier today, but I confess not to know which one semantically is 
> correct.


Well you're only looking at i386. True it is i386 specific code, but 
sticking
to the Linux memory model is more clear and consistent I think.

>   Your call on this patch - it is unecessary, I thought it was more 
> semantically correct, but you probably know that better than me.  So, 
> drop part 2 of this patch?


Yes, and make part 1 use smp_wmb.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
