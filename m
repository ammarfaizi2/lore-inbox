Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWC3RXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWC3RXp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWC3RXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:23:45 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:13857 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751216AbWC3RXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:23:45 -0500
Message-ID: <442C1415.6080906@cfl.rr.com>
Date: Thu, 30 Mar 2006 12:23:33 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, beware <wimille@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr> <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Mar 2006 17:23:51.0910 (UTC) FILETIME=[B6CA4860:01C6541E]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14355.000
X-TM-AS-Result: No--8.100000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> No. Any file I/O, or anything that takes time sleeps and gives up
> the CPU, ultimately calling schedule(). That means that anybody
> can have its coprocessor state dorked. This has been discussed many

The FPU state is saved across normal thread switches if either the new 
or old thread uses the fpu, so this should be safe.  Unless this does 
not apply to kernel threads?

> times. Also, floating-point is never required for anything!!! It's
> just a convenience for people who like to write code using 10 fingers.
> It has real problems when trying to exactly represent real numbers.
> For instance __all__ real numbers, except for transcendentals, can
> be represented as a ratio of two integers. For instance, you can't
> represent 1/3 exactly as a decimal. It is, however exactly the ratio
> of 1 and 3, two integers. Given this, I'm sure you can find a way
> to perform high-precision mathematics within the kernel without
> using the coprocessor. Usually, it's just a little thought that
> is required. Somebody needs 8 bits to feed into a volume-control
> register, but the value needs to be log-scale. Trivial, even if
> you don't want to use a table.
> 

Agreed, adjusting your thinking a bit to stick to integer math is 
usually preferred for efficiency reasons.

> If you divulge the mathematics you need calculated, I'll bet you
> will get many answers from responders to the linux-kernel list.
> However, if you expect to use the coprocessor as part of an image
> processing routine and your driver was designed to use that
> coprocessor, then you need a private coprocessor or you need
> a user-space 'driver' that probably communicates using shared-
> memory, this not involving kernel code at all.
> 
> 

