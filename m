Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWING2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWING2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 02:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWING2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 02:28:18 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:32234 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751365AbWING2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 02:28:17 -0400
Message-ID: <4508F680.8030501@vmware.com>
Date: Wed, 13 Sep 2006 23:28:16 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, torvalds@osdl.org,
       jeremy@goop.org, mingo@elte.hu, ak@suse.de, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Assignment of GDT entries
References: <787b0d920609132106p492cc990na471484d7dee8afb@mail.gmail.com>	 <m11wqf12hh.fsf@ebiederm.dsl.xmission.com> <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>
In-Reply-To: <787b0d920609132319y660c62c5rc245843aa55fd615@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> Eeeeeew.
>
> So if I grabbed the first two slots before glibc got to
> mess with them, glibc wouldn't break horribly?
> If I grabbed one slot and glibc grabbed another, Wine
> would be OK with the third instead of the second?

Glibc should allocate a slot just the same way, just like wine does as 
well.  Glibc just usually gets its slot allocated first.

>
> So basically it's not allowed to just grab the 3rd slot?

You can, but you should be prepared for it to fail as well.

>
> What if I want to find out what is already in use?
> Am I supposed to iterate over all 8191 possible
> GDT entries? How do I even tell how many slots
> are available without using them all up?

There are only 32 possible GDT entries in 32-bit i386 Linux, and only 
three of them are usable for userspace.  You can't find out which slots 
are in use, but you can cause one to be allocated and returned to you.  
This seems like a perfectly reasonable API to me, why do you think it is 
so ugly?

Zach
