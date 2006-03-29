Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWC2GGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWC2GGg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 01:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWC2GGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 01:06:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11171 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751086AbWC2GGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 01:06:36 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au>
	<1143228339.19152.91.camel@localhost.localdomain>
	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>
	<4428FB29.8020402@yahoo.com.au>
	<20060328142639.GE14576@MAIL.13thfloor.at>
	<44294BE4.2030409@yahoo.com.au>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Mar 2006 23:05:28 -0700
In-Reply-To: <44294BE4.2030409@yahoo.com.au> (Nick Piggin's message of "Wed,
 29 Mar 2006 00:44:52 +1000")
Message-ID: <m1psk5kcpj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> I don't think I could give a complete answer...
> I guess it could be stated as the increase in the complexity of
> the rest of the code for someone who doesn't know anything about
> the virtualization implementation.
>
> Completely non intrusive is something like 2 extra function calls
> to/from generic code, changes to data structures are transparent
> (or have simple wrappers), and there is no shared locking or data
> with the rest of the kernel. And it goes up from there.
>
> Anyway I'm far from qualified... I just hope that with all the
> work you guys are putting in that you'll be able to justify it ;)

As I have been able to survey the work, the most common case
is replacing a global variable with a variable we lookup via
current.

That plus using the security module infrastructure you can
implement the semantics pretty in a straight forward manner.

The only really intrusive part is that because we tickle the
code differently we see a different set of problems.  Such
as the mess that is the proc and sysctl code, and the lack of
good resource limits.

But none of that is inherent to the problem it is just when
you use the kernel harder and have more untrusted users you
see a different set of problems.

Eric
