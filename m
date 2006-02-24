Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751050AbWBXOSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbWBXOSa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWBXOSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:18:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54948 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750881AbWBXOSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:18:30 -0500
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order
 explicit
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
	<200602231442.19903.ak@suse.de> <43FDBF55.3060502@linux.intel.com>
	<200602231514.03001.ak@suse.de>
	<m11wxs50ki.fsf@ebiederm.dsl.xmission.com>
	<43FF0FE5.8040300@linux.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 24 Feb 2006 07:17:13 -0700
In-Reply-To: <43FF0FE5.8040300@linux.intel.com> (Arjan van de Ven's message
 of "Fri, 24 Feb 2006 14:53:41 +0100")
Message-ID: <m1irr4deom.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>>
>>> On Thursday 23 February 2006 14:57, Arjan van de Ven wrote:
>>>
>>>>> (or at least
>>>>> it shouldn't), but arch/x86_64/boot/compressed/head.S
>>>>> seems to have the entry address hardcoded. Perhaps you can just change this
>>>>> to pass in the right address?
>>>> the issue is that the address will be a link time thing, which means lots of
>>>> complexity.
>>> bzImage image should be only generated after vmlinux is done and then the
>>> address should be available with a simple grep in System.map
>> Andi it is more than that.  At least it was last I payed attention.
>> There are symbols like stext that various things depend on being early,
>> at least last time I looked.  So while it is doable it requires some
>> careful looking.
>
> _stext and such are very easy. That is actually not a real variable just a
> linker script thing, and since the reordering works on the linker script level
> that's already taken care of ;-)

It is currently a symbol defined in head.S though.  Not hard to fix
but the point is that there are a few subtle things.

> I've looked some yesterday at generating this at runtime, and haven't found a
> clean enough solution yet (esp one that doesn't break kdump); I'll keep poking
> at it for a bit more though....

I suspect the easy way to do this is to put a variable with the start location
either at the very start or the very end of the data that gets compressed that
has the address to jump to.  Once we uncompressed the data we can lookup
the pointer and jump to it.

Eric
