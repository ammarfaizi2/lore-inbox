Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWGMSmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWGMSmZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030286AbWGMSmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:42:25 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22737 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030282AbWGMSmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:42:24 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: olson@pathscale.com
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, discuss@x86-64.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<p734pxnojyt.fsf@verdi.suse.de>
	<m1wtajed4d.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.61.0607112307130.10551@osa.unixfolk.com>
	<m1psgbcnv9.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0607122048230.4819@topaz.pathscale.com>
	<m1d5c94jx8.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0607131109540.3583@topaz.pathscale.com>
Date: Thu, 13 Jul 2006 12:41:11 -0600
In-Reply-To: <Pine.LNX.4.64.0607131109540.3583@topaz.pathscale.com> (Dave
	Olson's message of "Thu, 13 Jul 2006 11:15:17 -0700 (PDT)")
Message-ID: <m1ac7d1h6g.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Olson <olson@pathscale.com> writes:

> On Thu, 13 Jul 2006, Eric W. Biederman wrote:
> | And I tested it on one of them.  The problem is that there is no API in
> | the kernel for properly handling hypertransport interrupts or even faking
> | it well currently.  There is no shame in breaking a bad unmaintainable
> | hack, as I did.  The responsible thing is to when you find one to
> | fix up the code so that things work by design in a maintainable way,
> | which I am attempting to do.
>
> There's no problem providing a better replacement, just make sure
> that the existing drivers can use it.

I am working on that.  What broke the drivers was the removal of
the assumption that irq == vector.  Which was a bad hack and never
always true.

> | All existing drivers that use HT interrupts are broken by design.
>
> That's a statement designed to provoke arguments, and I'll just leave
> it that we disagree.

I am just saying that if you don't have the infrastructure you need 
you cannot implement things correctly.  It is no fault of the driver
authors.  Except possibly not standing up and asking for some
infrastructure to do what needs to be done.

> | Sure.  In that case can I please have a good description of what
> | weird hacks your hardware designers have done.
>
> There's really nothing special at all about the interrupt
> setup, except in one very minor way.   The value of the HT interrupt
> destination address needs to be copied from HT config space, to
> an internal chip register (which is, can, and should be, handled by
> the driver init code).

The kernel changes the value at runtime, based upon user input.
I assume your mirror register needs to be updated after every change.

Since the kernel changes the value at runtime, and since a different
register needs to be written to, I can't quite use the generic code I
have written as is.  

> | The functions I exported I intend to export.  The complaint seems to
> | be that you don't have anything that will work on earlier kernels.
> | I have to agree you don't.
>
> Huh?  I didn't say anything that could possibly be read as applying
> to earlier kernels, and to be crystal clear, that's not my concern
> at all.
>
> Maybe somebody else can articulate what I'm trying to say, but I don't
> think I can say it in a clearer way.

Ok.  I guess I was reading something in that wasn't there.  So see a
similarity and say it looks like that can be generalized.  I look and
I don't see what having a magic DWIM enable irq interface would help
with.  The counter argument is essentially that if you have multiple
options implemented but some of them are buggy

Eric
