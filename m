Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWFFSaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWFFSaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWFFSaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:30:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:60782 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750951AbWFFSav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:30:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fdd8rh+Z+wY9bicHZweiG79pa7tWPrc177ZJ41oC6RK/0zR4vJMsyavGtiu+HMg+9vHG5V0aJBNP3Wv8Uhr+a7iA06jcfsH00Pe6PgAY6eI43HlOCy9A/oOksQnglhJG3DvG+jQeToyJecMz/1N+4mNkpX5j6xXRPmAoAZ0TBrw=
Message-ID: <29495f1d0606061130s5451db8r102c7e1e75981994@mail.gmail.com>
Date: Tue, 6 Jun 2006 11:30:51 -0700
From: "Nish Aravamudan" <nish.aravamudan@gmail.com>
To: "Jesper Juhl" <jesper.juhl@gmail.com>
Subject: Re: Backport of a 2.6.x USB driver to 2.4.32 - help needed
Cc: "Heiko Gerstung" <heiko.gerstung@meinberg.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44854F74.50406@meinberg.de>
	 <9a8748490606060423t102384f4m626b4366898ce9cd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 06/06/06, Heiko Gerstung <heiko.gerstung@meinberg.de> wrote:
> > Hi!
> >
> > Short Version (tm): I try to backport a USB driver (rtl8150.c) from
> > 2.6.15.x to 2.4.32 and have no idea how to substitue two functions:
> > in_atomic() and schedule_timeout_uninterruptible() ... I really would
> > appreciate any help, because I am no kernel hacker at all ...
> >
> in_atomic() is used to test if the kernel is in a state where sleeping
> is allowed or not. The 2.4.x kernel is not preemptive and has quite
> coarse grained SMP support (the BKL "Big Kernel Lock"), it didin't
> need in_atomic() in the same way as 2.6.x does.
>
> schedule_timeout_uninterruptible() is used to sleep on a wait-queue,
> which 2.4.x does not have.

schedule_timeout_uninterruptible(timeout_value) is just a wrapper for

set_current_state(TASK_UNINTERRUPTIBLE);
schedule_timeout(timeout_value);

Maybe you were thinking of sleep_on*()?

Thanks,
Nish
