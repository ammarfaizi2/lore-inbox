Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbUKDCO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUKDCO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 21:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUKDCIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 21:08:25 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:12703 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S262064AbUKDB4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:56:41 -0500
To: Russell Miller <rmiller@duskglow.com>
Cc: Kurt Wall <kwall@kurtwerks.com>, linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<200411031901.28977.rmiller@duskglow.com>
	<87654m4clz.fsf@asmodeus.mcnaught.org>
	<200411031945.20894.rmiller@duskglow.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 03 Nov 2004 20:56:28 -0500
In-Reply-To: <200411031945.20894.rmiller@duskglow.com> (Russell Miller's
 message of "Wed, 3 Nov 2004 20:45:20 -0500")
Message-ID: <87zn1y2x83.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> writes:

> Wouldn't it help with device driver problems?  Couldn't ring 1 be
> used to make sure an errant driver doesn't drop the kernel, at least
> on x86 machines?

As I understand it:

1) Ring transitions aren't free.
2) The API between drivers and kernel is always in flux; drivers
   expect to be able to access internal kernel data structures.
   Making drivers run in ring 1 on even one of the N architectures
   would be a major refactoring and would constrain API changes.
   Freezing the internal API is something the developers don't want to
   do.
3) There are probably plenty of ways for a buggy driver to crash the
   kernel even if it's running in ring 1 (turn off interrupts and
   leave them off, etc).

So the upshot is that it's probably not worth the work and portability
hassles.

-Doug
