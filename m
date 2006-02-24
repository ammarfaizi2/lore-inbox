Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWBXNx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWBXNx6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWBXNx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:53:58 -0500
Received: from fmr20.intel.com ([134.134.136.19]:37514 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751034AbWBXNx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:53:58 -0500
Message-ID: <43FF0FE5.8040300@linux.intel.com>
Date: Fri, 24 Feb 2006 14:53:41 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Patch to make the head.S-must-be-first-in-vmlinux order explicit
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>	<200602231442.19903.ak@suse.de> <43FDBF55.3060502@linux.intel.com>	<200602231514.03001.ak@suse.de> <m11wxs50ki.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11wxs50ki.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
>> On Thursday 23 February 2006 14:57, Arjan van de Ven wrote:
>>
>>>> (or at least
>>>> it shouldn't), but arch/x86_64/boot/compressed/head.S
>>>> seems to have the entry address hardcoded. Perhaps you can just change this
>>>> to pass in the right address?
>>> the issue is that the address will be a link time thing, which means 
>>> lots of complexity.
>> bzImage image should be only generated after vmlinux is done 
>> and then the address should be available with a simple grep in System.map
> 
> Andi it is more than that.  At least it was last I payed attention.
> There are symbols like stext that various things depend on being early,
> at least last time I looked.  So while it is doable it requires some
> careful looking.

_stext and such are very easy. That is actually not a real variable just 
a linker script thing, and since the reordering works on the linker 
script level that's already taken care of ;-)

I've looked some yesterday at generating this at runtime, and haven't 
found a clean enough solution yet (esp one that doesn't break kdump); 
I'll keep poking at it for a bit more though....
