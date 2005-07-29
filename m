Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbVG2QE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbVG2QE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVG2QE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 12:04:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50567 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262636AbVG2QEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 12:04:55 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: sync_tsc fix the race (so we can boot)
References: <m1slxz1ssn.fsf@ebiederm.dsl.xmission.com>
	<20050729074419.GB3726@bragg.suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 10:04:48 -0600
In-Reply-To: <20050729074419.GB3726@bragg.suse.de> (Andi Kleen's message of
 "Fri, 29 Jul 2005 09:44:19 +0200")
Message-ID: <m1pst14mzj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wed, Jul 27, 2005 at 10:03:04PM -0600, Eric W. Biederman wrote:
>> I believe this patch suffers from apicid versus logical cpu number confusion.
>> I copied the basic logic from smp_send_reschedule and I can't find where
>> that translates from the logical cpuid to apicid.  So it isn't quite
>> correct yet.  It should be close enough that it shouldn't be too hard
>> to finish it up.
>> 
>> More bug fixes after I have slept but I figured I needed to get this
>> one out for review.
>
> Thanks looks good. This should fix the unexplained
> hang for various people. Logical<->apicid  is actually ok, the low
> level _mask function takes care of that (it differs depending on the 
> APIC mode anyways) 

I guess my confusion comes from looking at the code in flat_send_IPI_mask.
cpus_addr(mask)[0] reduces it to just the first word but I don't
see any translation being done.

Eric
