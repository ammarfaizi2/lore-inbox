Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWFBLyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWFBLyA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWFBLyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:54:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45215 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750713AbWFBLx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:53:59 -0400
To: Preben Traerup <Preben.Trarup@ericsson.com>
Cc: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530183359.a8d5d736.akiyama.nobuyuk@jp.fujitsu.com>
	<20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
	<44800E1A.1080306@ericsson.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 02 Jun 2006 05:52:32 -0600
In-Reply-To: <44800E1A.1080306@ericsson.com> (Preben Traerup's message of
 "Fri, 02 Jun 2006 12:08:26 +0200")
Message-ID: <m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Preben Traerup <Preben.Trarup@ericsson.com> writes:

> Since I'm one of the people who very much would like best of both worlds,
> I do belive Vivek Goyal's concern about the reliability of kdump must be
> adressed properly.
>
> I do belive the crash notifier should at least be a list of its own.
>   Attaching element to the list proves your are kdump aware - in theory
>
> However:
>
> Conceptually I do not like the princip of implementing crash notifier
> as a list simply because for all (our) practical usage there will only
> be one element attached to the list anyway.
>
> And as I belive crash notifiers only will be used by a very limited
> number of users, I suggested in another mail that a simple
>
> if (function pointer)
>    call functon
>
> approach to be used for this special case to keep things very simple.

I am completely against crash notifiers.  The code crash_kexec switches to
is what is notified and it can do whatever it likes.  The premise is
that the kernel does not work.  Therefore  we cannot safely notify
kernel code.  We do the very minimal to get out of the kernel,
and it is my opinion we still do to much.

The crash_kexec entry point is not about taking crash dumps.  It is
about implementing policy when the kernel panics.  Generally the
policy we want is a crash dump but the mechanism is general purpose
and not limited to that.

You can put anything you want for crash_kexec to execute.

If the problem is strictly limited to hardware failure and software
can cope with that then don't panic the kernel and execute an orderly
transition.

If software cannot cope, and must panic the kernel it clearly cannot
do something sensible.

Eric
