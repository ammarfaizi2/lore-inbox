Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWC2PHb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWC2PHb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 10:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWC2PHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 10:07:31 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:63411 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750777AbWC2PHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 10:07:30 -0500
Message-ID: <442AA2A4.5010104@aitel.hist.no>
Date: Wed, 29 Mar 2006 17:07:16 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: beware <wimille@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
In-Reply-To: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

beware wrote:

>Hi
>
>i wonder if it is available to use float numbers in a module programming.
>Because, when I'm look for the param_get functions, i find them only
>for integers (long, short, and others) but none for the float numbers.
>
>Thanks for yours answer.
>  
>
The short answer is no, don't bother.

If you touch the floating point registers in kernel code, then
you mess them up for any user program that use floating point.

It can be done, but then you have to take all sorts of precations
saving the registers before using them, and restoring them
when finished.  And you must prevent context switching
while you have them! 

If you need a few computations, try to do it with fixed point
instead if at all possible. Or emulate floating point,
or have a userspace helper app to do it.
It all depends on what you think you need floats for.

Helge Hafting
