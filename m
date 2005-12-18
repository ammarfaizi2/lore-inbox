Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbVLRPD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbVLRPD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 10:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbVLRPD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 10:03:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34434 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965114AbVLRPD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 10:03:58 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	<200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	<20051217131456.GA13043@infradead.org>
	<m1irtn75pk.fsf@ebiederm.dsl.xmission.com>
	<p73oe3fdr2w.fsf@verdi.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 18 Dec 2005 08:02:47 -0700
In-Reply-To: <p73oe3fdr2w.fsf@verdi.suse.de> (Andi Kleen's message of "18
 Dec 2005 04:25:27 +0100")
Message-ID: <m1ek4a78iw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Christoph Hellwig <hch@infradead.org> writes:
>> 
>> > please always used fixes-size types for user communication.  also please
>> > avoid ioctls like the rest of the IB codebase.
>> 
>> Could someone please explain to me how the uverbs abuse of write
>> is better that ioctl?  
>
> It's actually worse because if they have a 32bit compat issue
> then ioctl can be fixed up, but read/write can't. 
>
> I wish the people arguing against ioctl all the time would
> just stop that because the alternatives are usually worse.

Some of the suggestions like using sysfs aren't too bad.
One value per file in text format is clean and not going
to change when you switch architectures :)

The rule should really be that you can't just argue against ioctl but
instead you must argue for something.

>> - 64bit compilers will not pad every structure to 8 bytes.  This
>>   only will happen if you happen to have an 8 byte element in your
>>   structure that is only aligned to 32bits by a 32bit structure.
>>   Unfortunately the 32bit gcc only aligns long long to 32bits on
>>   x86, which triggers the described behavior.
>
> Exactly - and driver writers usually don't get that right so we
> need to have a tool to fix it up in the end. And with ioctl
> that's easiest.

In this case I don't see any current problems.  But I don't
think this is a pattern we want to encourage, and if there
is a more maintainable pattern now would be the time to fix it.

Eric
