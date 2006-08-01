Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWHAFWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWHAFWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 01:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWHAFWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 01:22:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:59769 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161012AbWHAFWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 01:22:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QeglwtEyPRDZ4jpNwuP4bxnGz4T2m9vG/tRNfqXOAeM/OIzk97rW252BQcm7g+5WgJdwOHp9JseSjD0GnKnikXCMkGDERRbJJc+3/5d7v0nx32u5y6yV7CtA+HF6AXHA8zOVpxP4/lqooA2ZZz+aAa1p1qEYYeY20tZsF6SgX3E=
Message-ID: <787b0d920607312222v582c3d8dg9a97c80319d9fdc2@mail.gmail.com>
Date: Tue, 1 Aug 2006 01:22:17 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
In-Reply-To: <20060801013708.GA25965@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
	 <20060727203128.GA26390@nevyn.them.org>
	 <787b0d920607271817u4978d2bdiac261d916971c1b3@mail.gmail.com>
	 <20060728034741.GA3372@nevyn.them.org>
	 <787b0d920607281528w56472db2u81268aad523d5c72@mail.gmail.com>
	 <20060731190018.GA13735@nevyn.them.org>
	 <787b0d920607311708y3642e41cue49cd47ccc39e77d@mail.gmail.com>
	 <20060801013708.GA25965@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/06, Daniel Jacobowitz <dan@debian.org> wrote:
> On Mon, Jul 31, 2006 at 08:08:35PM -0400, Albert Cahalan wrote:
> > The execve event is unreliable anyway.
> > Thus, it is necessary to use syscall tracing.
>
> You keep saying this "unreliable" thing, and I don't think it means
> what you think it means.  It should always be delivered.  When it
> isn't, there's a bug.  I don't know of any, unless you're talking about
> the thread group issue you just reported.

Yeah, I figure there is a bug.

It'd be great if you could reproduce the bug.
My setup:

2-core CPU
64-bit kernel (2.6.17 FC5, next-to-latest revision)
32-bit target app (assembly - no C library)
32-bit debugger

The target app does CLONE_THREAD. The child does
that again, then execve. The first and last threads spin
in a loop, either burning CPU time or doing the pause
system call. (the middle thread does the execve)

I see the messages just fine on many 32-bit non-SMP
systems that I tested with: Gentoo 2.6.16, Gentoo 2.6.13,
plain 2.6.16, maybe 2.6.17.7... mostly in VMWare.
Perhaps it is the SMP, the 64-bit, or Fedora being broken.
I can not say, and most likely can not investigate more.

I hope that helps.
