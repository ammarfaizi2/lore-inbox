Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261511AbTCZJJA>; Wed, 26 Mar 2003 04:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbTCZJI7>; Wed, 26 Mar 2003 04:08:59 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:47023 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261511AbTCZJI7>; Wed, 26 Mar 2003 04:08:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Boot Speedup
Date: Wed, 26 Mar 2003 10:23:24 +0100
X-Mailer: KMail [version 1.3.2]
References: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
In-Reply-To: <1046909941.1028.1.camel@gandalf.ro0tsiege.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030326092010.3EDA8124023@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06 Mar 03 01:19, Ro0tSiEgE LKML wrote:
> What are some things I can change/disable/etc. to cut down the boot time
> of the kernel (i386) ? I would like to get one to boot in a couple
> seconds, tops. Is this possible, and how?

I just noticed this post in an oldish Kernel Traffic.  I got the following 
timing for booting a uml kernel to an IDE root disk:

time ./linux ubd0=/dev/hda6 init=/sbin/halt >/dev/null
real    0m3.146s
user    0m0.310s
sys     0m0.040s

This includes shutdown, and the IDE disk is only 5400 RPM (1 GHz PIII).  UML 
isn't initializing any physical devices, which would account for most of the 
delay on a native kernel.  It doesn't do any decompression either.  On the 
other hand, there are ways to trim the boot time further, e.g., with run-time 
precedence relations to control task start order.  As others have mentioned, 
the limiting factor is likely to be hard disk spin-up time.

To cut down the bios initialization time, use Linux Bios:

   http://www.linuxbios.org/index.html

Claimed fastest boot time is 3 seconds, which sounds like they are talking 
about a full kernel boot as opposed to just bios start.

I suppose a cold start time in the one second range is achievable without 
major hacking of the kernel, using a flash disk, Linux Bios, and minimal 
startup scripts.

Regards,

Daniel
