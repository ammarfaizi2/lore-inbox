Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275408AbTHNRT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 13:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275411AbTHNRT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 13:19:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:53635 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275408AbTHNRTW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 13:19:22 -0400
Date: Thu, 14 Aug 2003 10:19:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: John Levon <levon@movementarian.org>, Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
In-Reply-To: <1060880781.5983.9.camel@dhcp23.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308141014550.8148-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Aug 2003, Alan Cox wrote:
> 
> And why can't you put the pointer size at the start of the buffer ?

Historical aside: this was pretty much _exactly_ the bug that we used to
have in the old style timer tick profiler: it was impossible to figure out 
what the "profile shift" value was. So you got a series of "unsigned int" 
counts, but you didn't know what the granularity was for the hit counting.

That was fixed by just making read_profile() return the sample step size 
as the first word. See

	fs/proc/proc_misc.c: read_profile()

and note the small 

        while (p < sizeof(unsigned int) && count > 0) {
                put_user(*((char *)(&sample_step)+p),buf);
                buf++; p++; count--; read++;
        }

loop (and a few "+1" things for adjusting size comparisons).

		Linus

