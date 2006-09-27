Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbWI0OJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbWI0OJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 10:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWI0OJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 10:09:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16352 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932260AbWI0OJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 10:09:31 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       adurbin@google.com
Subject: Re: 2.6.18-mm1
References: <20060924040215.8e6e7f1a.akpm@osdl.org>
	<200609270913.15688.ak@suse.de>
	<m14putpxks.fsf@ebiederm.dsl.xmission.com>
	<200609270951.17124.ak@suse.de>
Date: Wed, 27 Sep 2006 08:08:09 -0600
In-Reply-To: <200609270951.17124.ak@suse.de> (Andi Kleen's message of "Wed, 27
	Sep 2006 09:51:17 +0200")
Message-ID: <m1hcyto112.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 27 September 2006 09:39, Eric W. Biederman wrote:
>> Andi Kleen <ak@suse.de> writes:
>> 
>> > On Wednesday 27 September 2006 04:04, Eric W. Biederman wrote:
>> >> 
>> >> When I apply:
>> >> x86_64-mm-insert-ioapics-and-local-apic-into-resource-map
>> >> 
>> >> My e1000 fails to initializes and complains about a bad eeprom checksum.
>> >> I haven't tracked this down to root cause yet and I am in the process of
>> > building
>> >> 2.6.18-mm1 with just that patch reverted to confirm that is the only cause.
>> >
>> > Is this with Linux BIOS?
>> 
>> Yes.  Not that it matters in this case.
>
> Well Linus BIOS is known to play very fast-and-lose regarding supplying
> correct BIOS tables.

Agreed it does tend to push the envelop of what is allowed, and doesn't
try to work around OS bugs.  Which does tend to expose things.

> Perhaps it conflicts with a broken e820 map?

No. Did you not get the other part of the discussion?

The reservation was wrong because those IOAPICs were on ordinary pci
devices.  So the two reservations for the same resource conflicted,
so the pci allocator tried to move the pci device.

The problem is totally contained within the patch under discussion.

The role LinuxBIOS plays seems to be that it is atypical to enable
ioapics as ordinary pci devices.

Eric
