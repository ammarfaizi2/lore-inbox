Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424376AbWKJH37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424376AbWKJH37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 02:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424377AbWKJH37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 02:29:59 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5770 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1424376AbWKJH36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 02:29:58 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andi Kleen <ak@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       alan@redhat.com, "Russell King" <rmk+lkml@arm.linux.org.uk>,
       "Jakub Jelinek" <jakub@redhat.com>, "Mike Galbraith" <efault@gmx.de>,
       "Albert Cahalan" <acahalan@gmail.com>,
       "Bill Nottingham" <notting@redhat.com>,
       "Marco Roeland" <marco.roeland@xs4all.nl>,
       "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: [PATCH] sysctl:  Undeprecate sys_sysctl (take 2)
References: <m1zmb13gsl.fsf@ebiederm.dsl.xmission.com>
	<9a8748490611081110m4cc62c1bp3a36aba3fc314e56@mail.gmail.com>
	<m1ejsd3e38.fsf_-_@ebiederm.dsl.xmission.com>
	<200611100750.10990.ak@suse.de>
Date: Fri, 10 Nov 2006 00:28:54 -0700
In-Reply-To: <200611100750.10990.ak@suse.de> (Andi Kleen's message of "Fri, 10
	Nov 2006 07:50:10 +0100")
Message-ID: <m1u017lpzd.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On Wednesday 08 November 2006 20:58, Eric W. Biederman wrote:
>> 
>> The basic issue is that despite have been ``deprecated'' and
>> warned about as a very bad thing in the man pages since it's
>> inception there are a few real users of sys_sysctl. 
>
> But they only seem to use a small number of actually used with
> sysctl(2) sysctls.
> I still think just maintaining a conversion table for 
> those is the right thing to do.

I don't know.  Every distinct user of the binary sysctl interface
used a different entry.  So the fact that there are a small number of
programs and thus a small number of sysctls used I agree with.  I do
not agree with the conclusion that we can predict the set of binary
sysctl that are in use.  We do not get good enough feedback from
the user community.

I don't have a problem with the principle of a conversion table
if it meant that we would never add any additional binary sysctls.

> The important part really is to get rid of the crufty 
> old infrastructure internally.

There is certainly some cleanup we could do there.  For absolutely
simple values sysctl isn't too bad.  But generated values are
horrible.

Certainly some of the parts are crufty and harder to use then
they should be.  The /proc side actually seems worse than the
binary side.

That said I have some plans on attacking sysctl in a very practical
sense, because it is required to implement multiple namespaces.

Eric
