Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVARQWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVARQWD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVARQWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:22:03 -0500
Received: from mail.joq.us ([67.65.12.105]:28061 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261333AbVARQV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:21:59 -0500
To: Con Kolivas <kernel@kolivas.org>
Cc: hihone@bigpond.net.au, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com
Subject: Re: [ck] [PATCH][RFC] sched: Isochronous class for unprivileged
 soft rt	scheduling
References: <41ED08AB.5060308@kolivas.org> <41ED2F1F.1080905@bigpond.net.au>
	<41ED30EB.4090904@kolivas.org>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 18 Jan 2005 10:23:37 -0600
In-Reply-To: <41ED30EB.4090904@kolivas.org> (Con Kolivas's message of "Wed,
 19 Jan 2005 02:53:15 +1100")
Message-ID: <87y8eqso3a.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> writes:

> Cal wrote:
>
> SCHED_ISO
> /proc/sys/kernel/iso_cpu . . .: 70
> /proc/sys/kernel/iso_period . : 5
> XRUN Count  . . . . . . . . . :   110
>
> vs
>
> SCHED_FIFO
> XRUN Count  . . . . . . . . . :   114
> XRUN Count  . . . . . . . . . :   187
>
> vs
>
> SCHED_RR
> XRUN Count  . . . . . . . . . :     0
> XRUN Count  . . . . . . . . . :     0
>
> Something funny going on here... You had more xruns with SCHED_FIFO
> than the default SCHED_ISO settings, and had none with SCHED_RR. Even
> in the absence of the SCHED_ISO results, the other results dont make a
> lot of sense.

Actually it makes perfect sense.  Running non-realtime JACK threads
SCHED_FIFO will do the most harm.  The others less.

I predict that using normal jackd -R (without schedtool) will produce
the same results running SCHED_FIFO and SCHED_ISO (within the normal
variance).

I think schedtool is too blunt and instrument for making these
measurements.
-- 
  joq
