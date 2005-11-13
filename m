Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVKMTIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVKMTIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 14:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbVKMTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 14:08:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38836 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750846AbVKMTIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 14:08:23 -0500
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>,
       torvalds@osdl.org
Subject: Re: [PATCH 1/10] Cr4 is valid on some 486s
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>
	<p734q6g4xuc.fsf@verdi.suse.de>
	<1131902775.25311.16.camel@localhost.localdomain>
	<200511132000.45836.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 13 Nov 2005 12:07:16 -0700
In-Reply-To: <200511132000.45836.ak@suse.de> (Andi Kleen's message of "Sun,
 13 Nov 2005 20:00:44 +0100")
Message-ID: <m1oe4onz8b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Sunday 13 November 2005 18:26, Alan Cox wrote:
>
>> I'd hope the vendors are not doing that by default because we have
>> kernel code that uses lock against not other processors but other bus
>> masters. The ECC code is one example. 
>
> It's a bad hack anyways. Better would be probably to use a uncached WC write.
> I would rather use that.

For read modify write?

The point is to make the cache line dirty so that the
memory controller will write the data back.

The interesting sequence is:
lock; addl $0, %(reg)

I'm not actually sure the lock is even necessary.  Mostly this is
for brain-dead chipsets, chipsets you can't trust, or at least
chipsets that won't do a background scrub for you.

I don't think it is possible to do an uncached read modify write?

Eric
