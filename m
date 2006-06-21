Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932149AbWFUPFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWFUPFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 11:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751639AbWFUPFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 11:05:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:14711 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751635AbWFUPFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 11:05:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CID/gwKvJICejnniJ5TP0brC47Pak40IiLOqBImUjx3L8rqkHJJOhsqdS7hJ/ZGcp7gGWHvf+4AkKapl7Tsxx5G28U/IzeLoTMpmaJ5Y7DXcidbLAMztTyR+WZvd3uq44wu5jkuvk/oQKbLiFCSnuLX/FovF4kan5yPkzYb+8MU=
Message-ID: <642640090606210804k282085efm84476af3a8fa08b1@mail.gmail.com>
Date: Wed, 21 Jun 2006 09:04:58 -0600
From: "Ryan McAvoy" <ryan.sed@gmail.com>
To: "Steven Rostedt" <rostedt@goodmis.org>
Subject: Re: realtime-preempt for MIPS - compile problem with rwsem
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>
In-Reply-To: <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <642640090606201208g31a0a57bm268910b026ccd335@mail.gmail.com>
	 <Pine.LNX.4.58.0606210354050.29673@gandalf.stny.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thanks for your reply.

Steven Rostedt wrote:

> First, whenever sending mail about the -rt patch, always CC Ingo (and
> perhaps Thomas Gliexner and myself).

Thanks, I will do that.

> 2.6.15 had lots of problems with -rt.  Mainly the patch went through some
> major rework, and Ingo was busy getting mutexes into mainline.  So the
> 2.6.15-rtX was sort of neglected.  It would be best to use 2.6.16-rtX and
> maybe even 2.6.17-rtX
>
> Which also comes the question: Which -rt patch are you actually trying?

patch-2.6.15-rt21 .  I have also tried using the 2.6.16 kernel and
patch-2.6.16-rt29 and have the same problems with it.  (I may be
constrained in having to use a 2.6.15 kernel ... but would be happy to
get 2.6.16 working /stable as a starting point.)

> Yep, try the following patch: (completey untested since I don't have a
> mips machine).
>
>  config RWSEM_GENERIC_SPINLOCK
>         bool
> -       depends on !PREEMPT_RT
> +       depends on PREEMPT_RT
>         default y

I did just that when I first started with these patches and did
succeed in getting it compiling and booting.  The resulting kernel,
however, is very unstable and hangs frequently with no output.  (It
will hang within hours if left idle.  I can hang it more quickly by
attempting to use it).  I have deadlock detection turned on and have
confirmed that it does produce output at least for some deadlocks:
http://groups.google.com/group/linux.kernel/browse_frm/thread/1559667001b7da2d/2558b539a5adc660?lnk=st&q=realtime+preempt+mips&rnum=2&hl=en#2558b539a5adc660
In the more common hangs though, I get no output.

I decided to review the changes I made in getting it to compile and
was hoping that this one may be the cause of the instability.  I
thought that perhaps this change was incorrect because
include/asm-mips/rwsem.h is introduced by the rt-preempt patch and
would only be used if RWSEM_GENERIC_SPINLOCK was off.  [As well, it
seemed like something fundamental enough to account for the general
instability I am seeing.]

Ryan
