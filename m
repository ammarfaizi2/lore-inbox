Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751065AbVLLOiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751065AbVLLOiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 09:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbVLLOiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 09:38:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46236 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751065AbVLLOiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 09:38:13 -0500
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, pj@sgi.com, rth@twiddle.net,
       davej@redhat.com, zwane@arm.linux.org.uk, ak@suse.de,
       ashok.raj@intel.com
Subject: Re: [PATCH] move pm_power_off and pm_idle declaration to common
 code
References: <E1EloGS-0005gf-00@dorka.pomaz.szeredi.hu>
	<m1pso29z37.fsf@ebiederm.dsl.xmission.com>
	<E1Elof7-0005j7-00@dorka.pomaz.szeredi.hu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 12 Dec 2005 07:36:05 -0700
In-Reply-To: <E1Elof7-0005j7-00@dorka.pomaz.szeredi.hu> (Miklos Szeredi's
 message of "Mon, 12 Dec 2005 15:28:21 +0100")
Message-ID: <m1lkyq9ycq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

>> > So move declaration of pm_power_off (and with it pm_idle) from the
>> > archs that do define it to kernel/sys.c.  This should fix the link
>> > problem, and at the same time remove some duplication.
>> 
>> Sounds sane.  
>> 
>> Does powerpc still build?  A key question is how do we handle architectures
>> that always want to want to call machine_power_off.
>
> I didn't (and can't) check, but it should.  IIRC multiple declaration
> of a variable is OK, as long as at most one has an initializer.

It should be easy enough to put that declaration on an architecture
you can build and check that way.

Multiple declaration of a variable with only one having an initializer
work because the variable gets put into the common section as I recall.
I don't believe this is portable to all C implementations. but the
important question is does this construct work in the kernel.

If it doesn't work as is we should be able to get similar behavior
from weak symbols.

Could you test that part of your patch please?

Eric
