Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVH3PU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVH3PU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 11:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbVH3PU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 11:20:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54945 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932181AbVH3PUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 11:20:55 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<1125413136.8276.14.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Aug 2005 09:20:19 -0600
In-Reply-To: <1125413136.8276.14.camel@localhost.localdomain> (Alan Cox's
 message of "Tue, 30 Aug 2005 15:45:36 +0100")
Message-ID: <m14q97qwng.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
>> ways.  Currently this code only allows for an additional flavor
>> of uncached access to physical memory addresses which should be hard
>> to abuse, and should raise no additional aliasing problems.  No
>> attempt has been made to fix theoretical aliasing problems.
>
> Even an uncached/cached alias causes random memory corruption or an MCE
> on x86 systems. In fact it can occur even for an alias not in theory
> touched by the CPU if it happens to prefetch into or speculate the
> address.

Right.  To the best of my understanding problem aliases are either
uncached/write-back or write-combine/write-back.  I don't think
uncached/write-combine can cause problems.  My basic reason for
believing this patch is safe is that sane usage will only convert
areas of memory that are now uncached to write-combine.

> Also be sure to read the PII Xeon errata - early PAT has a bug or two.
>
> Definitely a much needed improvement to the kernel though.

Thanks.  As best as I can tell by reading the errata, the only
bugs are confined to (a) the upper for PAT entries are used and 
(b) when mtrrs are disabled and caching is still enabled.  

I don't make use of either case so my patch should avoid those
errata.

Eric

