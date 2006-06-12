Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWFLTMb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWFLTMb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752191AbWFLTMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:12:31 -0400
Received: from mail.suse.de ([195.135.220.2]:55462 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1752179AbWFLTMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:12:30 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: broken local_t on i386
Date: Mon, 12 Jun 2006 20:11:52 +0200
User-Agent: KMail/1.8
Cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121955.47803.ak@suse.de> <Pine.LNX.4.64.0606121156460.20195@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121156460.20195@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606122011.52841.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 June 2006 20:59, Christoph Lameter wrote:
> On Mon, 12 Jun 2006, Andi Kleen wrote:
> > Possible, but is it worth reinventing the linker?
>
> How would that work?

Either changing the linker and telling everybody to upgrade 
or writing a mini linker that works at kernel boot time.

Upgrading binutils is imho not acceptable and doing
the runtime relocation would be a lot of code for 
questionable gain.


> IMHO The linker cannot help with virtual to physical address translations.
> A linker that will link per processor would be amazing. What happens if
> the process is rescheduled? We dynamically relink to the new processor?
>
> I thought you had some funky segment registers on i386 and x86_64. Cant
> they be switched on context switch? If an inc/dec could work relative to
> those then you would not need a virtual mapping.

The segment register needs an offset. So you need the linker to generate
the offset from the base of the per cpu segment somehow. At compile time the 
address is not known so it cannot be done then.

To work around this we do it at runtime.

User space TLS has some specialized relocations for this, but they
are so hack^wspecialized that they are not usable for the kernel.

-Andi
