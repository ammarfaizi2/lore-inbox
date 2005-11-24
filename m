Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbVKXNcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVKXNcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbVKXNcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:32:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21733 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750929AbVKXNb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:31:58 -0500
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de>
	<437B5A83.8090808@suse.de> <438359D7.7090308@suse.de>
	<p7364qjjhqx.fsf@verdi.suse.de>
	<1132764133.7268.51.camel@localhost.localdomain>
	<20051123163906.GF20775@brahms.suse.de>
	<1132766489.7268.71.camel@localhost.localdomain>
	<20051123165923.GJ20775@brahms.suse.de>
	<1132783243.13095.17.camel@localhost.localdomain>
	<20051124131310.GE20775@brahms.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 24 Nov 2005 06:30:08 -0700
In-Reply-To: <20051124131310.GE20775@brahms.suse.de> (Andi Kleen's message
 of "Thu, 24 Nov 2005 14:13:10 +0100")
Message-ID: <m1zmnugom7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> 2. Uncached mappings are unworkable for this because we must never have
>> a page mapped with conflicting cache types - thats ugly, and plain
>> horrific on SMP.
>
> For kernel mapping change_page_attr() takes care of it,
> and for user space memory following all mappings is the only
> reliable way to find out which process needs to be killed
> anyways - and when you do that you can as well unmap
> or just kill.

I think I see the source of the confusion.  Scrubbing is the
process of taking data that is correctable and writing it back to
memory so that if a second correctable error occurs the net is still
corrected.

Directed killing of processes is something that must be done
inside a synchronous exception (like a machine check) because otherwise
it is so racy you don't know who has seen the bad data.  

Eric
