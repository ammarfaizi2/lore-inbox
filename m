Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWAFID6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWAFID6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751929AbWAFID6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:03:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58815 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751267AbWAFID6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:03:58 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Yinghai Lu <yinghai.lu@amd.com>, vgoyal@in.ibm.com, ak@muc.de,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linuxbios@openbios.org
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
References: <20060103044632.GA4969@in.ibm.com>
	<86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
	<20060105163848.3275a220.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 06 Jan 2006 01:02:16 -0700
In-Reply-To: <20060105163848.3275a220.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 5 Jan 2006 16:38:48 -0800")
Message-ID: <m164ox6ayf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> Please don't top-post.
>
>> 
>> On 1/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
>> > Hi Andi,
>> >
>> > Can you please include the following patch. This patch has already been
> pushed
>> > by Andrew.
>> >
>> >
> http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
>
> IIRC, I dropped this patch because of discouraging noises from Andi and
> because underlying x86_64 changes broke it in ugly ways.

Ok.  I just as extensively as I could and I can't find the under laying
x86_64 changes that Andi mentioned he was working on.  I have looked
in current -mm and in Andi merge and experimental quilt trees.  It
could be that I'm  blind but I looked and I did not see them.

Even in the discussion where this was mentioned there never was a 
semantic conflict.  But rather two patches passing so close they
touched the same or neighboring lines of code.

> It needs to be
> redone and Andi's objections (whatever they were) need to be addressed or
> argued about.

The difference was one of approach.  Andi wanted us to treat the apics
as black boxes and save and restore register values with no regard as
to what the registers did.  This is theoretically more future proof,
but it looses flexibility.

My approach is to treat the apics as something we understand, and
simply save off the one small piece of information from the boot
time state that we can't discover any other way.

The x86_64-ioapic-virtual-wire-mode-fix.patch in 2.6.15-mm1 actually
takes advantage of the fact we understand what the apics are doing
to change the destination cpu, in the kexec on panic case.  This
is something that cannot be done if we simply saved off the registers.
     
> Right now the patch is rather dead.

Current the referred to patch applies just fine, to 2.6.15,
and except for a conflict with the above mentioned patch which
applies fine to 2.6.15-mm1 as well.

Putting the apics in a state where we can use them if fundamental
so to booting a kernel so this is something we need to resolve
if we want kexec to be usable.

A revived version of the patch that applies without patch
follows.


Eric

