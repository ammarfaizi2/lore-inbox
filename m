Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTDRRJD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbTDRRJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:09:03 -0400
Received: from air-2.osdl.org ([65.172.181.6]:51091 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263182AbTDRRI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:08:58 -0400
Date: Fri, 18 Apr 2003 10:20:15 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [cpumask_t 1/3] core changes for 2.5.67-bk6
Message-Id: <20030418102015.2527ff40.rddunlap@osdl.org>
In-Reply-To: <20030415225036.GE12487@holomorphy.com>
References: <20030415225036.GE12487@holomorphy.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Apr 2003 15:50:36 -0700 William Lee Irwin III <wli@holomorphy.com> wrote:

| Core changes for extended cpu masks. Basically use a machine word
| #if NR_CPUS < BITS_PER_LONG, otherwise, use a structure with an array
| of unsigned longs for it. Sprinkle it around the scheduler and a few
| other odd places that play with the cpu bitmasks. Back-ended by a
| bitmap ADT capable of dealing with arbitrary-width bitmaps, with the
| obvious micro-optimizations for NR_CPUS < BITS_PER_LONG and UP.
| 
| NR_CPUS % BITS_PER_LONG != 0 is invalid while NR_CPUS > BITS_PER_LONG.

Where/why this restriction (above)?
I don't see the need for it or implementation of it.

I'm only looking at the core patch.


| diff -urpN linux-2.5.67-bk6/include/linux/bitmap.h cpu-2.5.67-bk6-1/include/linux/bitmap.h
| --- linux-2.5.67-bk6/include/linux/bitmap.h	1969-12-31 16:00:00.000000000 -0800
| +++ cpu-2.5.67-bk6-1/include/linux/bitmap.h	2003-04-15 14:39:40.000000000 -0700

| +static inline void bitmap_shift_left(volatile unsigned long *,volatile unsigned long *,int,int);

Do you need this prototype?  I don't see why.

Rest of core looks good to me.

--
~Randy
