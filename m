Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVHaBkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVHaBkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 21:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbVHaBkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 21:40:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3241 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932327AbVHaBkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 21:40:32 -0400
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386, x86_64 Initial PAT implementation
References: <m1psrwmg10.fsf@ebiederm.dsl.xmission.com>
	<1125413136.8276.14.camel@localhost.localdomain>
	<20050830170600.GA10042@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 30 Aug 2005 19:39:43 -0600
In-Reply-To: <20050830170600.GA10042@redhat.com> (Dave Jones's message of
 "Tue, 30 Aug 2005 13:06:00 -0400")
Message-ID: <m1mzmyq3z4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> On Tue, Aug 30, 2005 at 03:45:36PM +0100, Alan Cox wrote:
>  > On Llu, 2005-08-29 at 18:20 -0600, Eric W. Biederman wrote:
>  > > ways.  Currently this code only allows for an additional flavor
>  > > of uncached access to physical memory addresses which should be hard
>  > > to abuse, and should raise no additional aliasing problems.  No
>  > > attempt has been made to fix theoretical aliasing problems.
>  > 
>  > Even an uncached/cached alias causes random memory corruption or an MCE
>  > on x86 systems. In fact it can occur even for an alias not in theory
>  > touched by the CPU if it happens to prefetch into or speculate the
>  > address.
>  > 
>  > Also be sure to read the PII Xeon errata - early PAT has a bug or two.
>
> There are various PAT errata all the way through to Pentium-M iirc.

Thanks, I have just read through all of them and none of them look
like a problem.

The primary issue is that you can't count on being able to use
the upper 4 PAT entries.

The most painful is that on the Pentium-III and I believe on the Pentium-M
there are occasions where PAT will fail to promote an UC entry from
the mtrrs to WC.  The page will remain UC resulting in louzy performance.

It looks like you can hard hang a Pentium-4 by mixing uncached and
writeback memory attributes.

Eric

