Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270899AbUKAPV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270899AbUKAPV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUKAOM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:12:26 -0500
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:10023 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S262764AbUKAOLB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:11:01 -0500
Message-ID: <418643E2.9080006@microgate.com>
Date: Mon, 01 Nov 2004 08:10:42 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
CC: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Russell King'" <rmk+lkml@arm.linux.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UPkernel
References: <000201c4bfe2$7389eeb0$294b82ce@stuartm>
In-Reply-To: <000201c4bfe2$7389eeb0$294b82ce@stuartm>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart MacDonald wrote:
> From: Paul Fulghum
> I always thought the whole point of low_latency was to make the
> receive-path very fast, which means specifically allowing the flip
> routine to run from the ISR. So checking for calling from the ISR and
> specifically disallowing that is basically negating the entire raison
> d'etre for low_latency.

I was thought it was to speed processing if the
caller was already in process context. Maybe the
real intentions are lost to history.

Moving forward, Alan stated that the flip
routine should not be called in interrupt context.
His last post concerning some transient state
of low_latency has confused me.

Currently, with the 8250 driver and N_TTY
line discipline, calling the flip routine from
ISR causes an SMP deadlock. There are two paths that
cause this:
1. low_latency is set
2. flip buffer becomes full

So calling the flip routine from the ISR may work
with some specific drivers, but it would be
dangerous to assume this works in all cases.

-- 
Paul Fulghum
paulkf@microgate.com
