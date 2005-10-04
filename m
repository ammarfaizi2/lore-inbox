Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVJDPnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVJDPnm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVJDPnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:43:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20444 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964826AbVJDPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:43:41 -0400
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
Subject: Re: [PATCH 2/2] x86_64: move apic init in init_IRQs
References: <m13bnh8gdo.fsf@ebiederm.dsl.xmission.com>
	<200510041724.36535.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 04 Oct 2005 09:42:12 -0600
In-Reply-To: <200510041724.36535.ak@suse.de> (Andi Kleen's message of "Tue,
 4 Oct 2005 17:24:36 +0200")
Message-ID: <m1u0fx70h7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Tuesday 04 October 2005 17:13, Eric W. Biederman wrote:
>> All kinds of ugliness exists because we don't initialize
>> the apics during init_IRQs.
>> - We calibrate jiffies in non apic mode even when we are using apics.
>> - We have to have special code to initialize the apics when non-smp.
>> - The legacy i8259 must exist and be setup correctly, even
>>   we won't use it past initialization.
>
> Actually some setups use its timer even in ACPI mode. Do you take this into 
> account?

The patch is basically code motion and duplication removal with just a
few tweaks thrown in to account for the change in location in the
kernel boot process when all of occurs.

So everything that was working should continue to work.

> In theory it looks reasonable, but I guess it won't work without the bogus
> watchdog change. That would need to be resolved first.

Sure.  That should be straight forward.  The only part that breaks is
the watchdog initialization/testing.  As I recall there was no obvious
place to put it.  The call has to happen after everything is running
so it is a bit tricky to find a good place to put it.

Eric

