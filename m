Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315754AbSFTWza>; Thu, 20 Jun 2002 18:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSFTWza>; Thu, 20 Jun 2002 18:55:30 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:2889 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315754AbSFTWz1>; Thu, 20 Jun 2002 18:55:27 -0400
Date: Fri, 21 Jun 2002 08:59:35 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.23 cpu_online_map undeclared
Message-Id: <20020621085935.7650d28a.rusty@rustcorp.com.au>
In-Reply-To: <aep588$21j$1@penguin.transmeta.com>
References: <3D0FF715.7040601@linuxhq.com>
	<aep588$21j$1@penguin.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2002 05:36:08 +0000 (UTC)
torvalds@transmeta.com (Linus Torvalds) wrote:

> Actually, it _should_ be declared, it's just that on UP it should be
> defined to the constant 1.
> 
> Somehow that #define got dropped by the hotplug-CPU stuff.

Actually, was deliberate.  Not exposing the mask when almost everyone
just wants to know "are any of these cpus online" was a preemptive strike
against NR_CPUS > BITS_PER_LONG (I wouldn't have bothered but I was so
close anyway).

My mistake was not noticing that x86 SMP was still exposing it and that
scheduler changes since my original patch were using it.  Fixed with
cpu_online_mask(res, mask) in prior patch.

Apologies, and hope that clarifies,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
