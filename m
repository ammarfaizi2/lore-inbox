Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRDDPHR>; Wed, 4 Apr 2001 11:07:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132835AbRDDPHI>; Wed, 4 Apr 2001 11:07:08 -0400
Received: from [193.120.224.170] ([193.120.224.170]:53399 "EHLO
	florence.itg.ie") by vger.kernel.org with ESMTP id <S132834AbRDDPGy>;
	Wed, 4 Apr 2001 11:06:54 -0400
Date: Wed, 4 Apr 2001 16:05:05 +0100 (IST)
From: Paul Jakma <paulj@itg.ie>
To: christophe barbe <christophe.barbe@lineo.fr>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: uninteruptable sleep (D state => load_avrg++)
In-Reply-To: <20010404164858.A14009@pc8.inup.com>
Message-ID: <Pine.LNX.4.33.0104041548120.1150-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Apr 2001, christophe barbe wrote:

> From me, a POV without technical reasons is not a philosical one
> but more certainly an historical one.

there may be (and indeed probably are) good technical reasons, however
i am not well enough informed to say what they are.

> Process that will be runnable are not participating to the load so
> why incrementing the load average.

As i understand it:

load avg by nature is a measure of how many processes are 'runnable'
(ie waiting to run) over time.

a process waiting for the kernel to complete IO will indeed be
runnable as soon as the kernel is finished.

instead of waiting for CPU time (as with processes marked R), instead
these processes are waiting for kernel to complete.

> Moreover if a process should be
> in state D only for a short time, the influence of the
> incrementation should be near null for an AVERAGE value.

because the number of processes asleep, waiting on kernel to complete
IO may reasonably be considered to be a load.

imagine a box with a bunch of processes that do almost nothing but
call on the kernel to do IO. If you only count the runnable state
towards load_avg then your load_avg will be very low, even though your
box is swamped - you are ignoring the work of the kernel.

if you count D towards load_avg then it will reflect this abstract
'load' concept more accurately.

Ie, counting D towards load_avg is a way of taking kernel IO work into
account when calculating the load average figures.

> What's the technical reason behind this load_avrg++ ???
>
> Christophe
>

--paulj

