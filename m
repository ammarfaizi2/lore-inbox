Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWFGIE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWFGIE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWFGIE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:04:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:61788 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751116AbWFGIE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:04:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WsxAk/vbH8O/rtUJYLB92sW6d/q5+ZP4OFfKZiTpXc6gLIO06meD8JmHVtGLmXfK3Fpg9HonA7SIaTc4llsABzc2wCoaRlRCtONrhA78tNqC/ugQq1WTlQ8FJvD8PSuPiVVv+5WksSwNiIa/XSsO6/eoEj4Mw38yyjks3xApNWA=
Message-ID: <9a8748490606070104i2401e82cm6b4f1170bf543f00@mail.gmail.com>
Date: Wed, 7 Jun 2006 10:04:24 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nish Aravamudan" <nish.aravamudan@gmail.com>
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
Cc: "Heiko Gerstung" <heiko.gerstung@meinberg.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <29495f1d0606061130s5451db8r102c7e1e75981994@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44854F74.50406@meinberg.de>
	 <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com>
	 <29495f1d0606061130s5451db8r102c7e1e75981994@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/06, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
> On 6/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 06/06/06, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:
> > > Hi!
> > >
> > > Short Version (tm): I try to backport a USB driver (rtl8150.c) from
> > > 2.6.15.x to 2.4.32 and have no idea how to substitue two functions:
> > > in_atomic() and schedule_timeout_uninterruptible() ... I really would
> > > appreciate any help, because I am no kernel hacker at all ...
> > >
> > in_atomic() is used to test if the kernel is in a state where sleeping
> > is allowed or not. The 2.4.x kernel is not preemptive and has quite
> > coarse grained SMP support (the BKL "Big Kernel Lock"), it didin't
> > need in_atomic() in the same way as 2.6.x does.
> >
> > schedule_timeout_uninterruptible() is used to sleep on a wait-queue,
> > which 2.4.x does not have.
>
> schedule_timeout_uninterruptible(timeout_value) is just a wrapper for
>
> set_current_state(TASK_UNINTERRUPTIBLE);
> schedule_timeout(timeout_value);
>
> Maybe you were thinking of sleep_on*()?
>

Yeah, you are right, that was what I was thinking of. My bad.
Thank you for the correction.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
