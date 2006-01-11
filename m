Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWAKXBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWAKXBc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 18:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWAKXBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 18:01:32 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:26232 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932511AbWAKXBb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 18:01:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rdMwmOv7rEuz7D9AZ0inM809fANt5lvLueg3nScvpQ1Ov/uOqN7in9iiypLDlhsqjfWFZTHTZPC5bReAVi7etxsP+peizkCIJZLporgfDlqN/VdquK9IkIkkVzQ7ikzITGNmxQgLyfG+g0cEHjoofORuCniRKVyqbzQFaLM6uZI=
Message-ID: <29495f1d0601111501j5c52b847v92bc95253513c280@mail.gmail.com>
Date: Wed, 11 Jan 2006 15:01:30 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: load average wraps at 1024
Cc: LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <9a8748490601111440m53fdab80pfefc10efb214f3bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a8748490601111440m53fdab80pfefc10efb214f3bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> Hi,
>
> Don't know if this is a kernel issue or userspace issue, but load
> average values wrap back to 0 once they hit 1024.
>
> I've been trying to stress 2.6.15-mm3 by putting a *lot* of load on it
> and seeing if it stays alive, how it copes, how long it seems to take
> to recover etc.
> While doing that I've done some test runs that start thousands of
> processes and the load average quickly shoots up to several hundred
> and eventually reach 1000 - when it continues to climb it goes to 1023
> and then wraps down to small numbers like 4-5 and then continue
> climbing from there. Once I kill all my processes it slowly goes down
> to zero, then wraps back to ~1000 and continues to climb down from
> there until it's eventually back to normal.
>
> Is this expected behaviour?

I'm going to say yes, based on the comments in sched.h:

/*
 * These are the constant used to fake the fixed-point load-average
 * counting. Some notes:
 *  - 11 bit fractions expand to 22 bits by the multiplies: this gives
 *    a load-average precision of 10 bits integer + 11 bits fractional
 *  - if you want to count load-averages more often, you need more
 *    precision, or rounding will get you. With 2-second counting freq,
 *    the EXP_n values would be 1981, 2034 and 2043 if still using only
 *    11 bit fractions.
 */

That is, 10 bits of integer is 1024, the remaining 11 bits being used
for fractions.

Thanks,
Nish
