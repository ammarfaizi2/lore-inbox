Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbWDIT1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbWDIT1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 15:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWDIT1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 15:27:13 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19932 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750921AbWDIT1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 15:27:12 -0400
To: Andi Kleen <ak@suse.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>,
       Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Black box flight recorder for Linux
References: <5ZjEd-4ym-37@gated-at.bofh.it> <200604080917.39562.ak@suse.de>
	<4437E4B7.40208@superbug.co.uk> <200604091704.47566.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 09 Apr 2006 13:25:42 -0600
In-Reply-To: <200604091704.47566.ak@suse.de> (Andi Kleen's message of "Sun,
 9 Apr 2006 17:04:47 +0200")
Message-ID: <m1odzaima1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Saturday 08 April 2006 18:28, James Courtier-Dutton wrote:
>> Andi Kleen wrote:
>> > On Saturday 08 April 2006 16:05, Robert Hancock wrote:
>> >> Andi Kleen wrote:
>> >>> James Courtier-Dutton <James@superbug.co.uk> writes:
>> >>>> Now, the question I have is, if I write values to RAM, do any of those
>> >>>> values survive a reset?
>> >>> They don't generally.
>> >>>
>> >>> Some people used to write the oopses into video memory, but that
>> >>> is not portable.
>> >> I wouldn't think most BIOSes these days would bother to clear system RAM
>> >> on a reboot. Certainly Microsoft was encouraging vendors not to do this
>> >> because it slowed down system boot time.to
>> > 
>> > Reset button is like a cold boot and it generally ends up with cleared 
>> > RAM.
>> > 
>> > -Andi
>> 
>> Thank you. That saved me 30mins hacking. :-)

Actually clearing the memory can be done at full memory bandwidth
which can happen in seconds.  On systems with ECC you need initialize
all of the check bits so some kind of write to memory needs to happen.

In practice a reset does not clear the memory and only a few bits
tend to get flipped.  Unless you can get support from the
BIOS/firmware developers it isn't a practical approach though.

> First if you're not aware of this - the "official" way right now
> to solve this problem is kexec + kdump + a preloaded crash kernel. But in 
> practice it still has many problems because a lot of drivers cannot 
> reinitialize the hardware properly. And of course it will users need
> to load the crash kernel in advance and lose about 64MB of RAM.

Does a kernel really need 64M?  That number seems insanely large
to me.  8M should be more than sufficient if someone actually
tried to be small.  If you are aiming for a dedicated hardware
solution you don't need even need a kernel in there and the
amount reserved could be reduced to less than a meg.

The size etc becomes a trade off between what is expedient
and maintainable.

Eric
