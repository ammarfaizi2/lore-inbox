Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbUKPUW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbUKPUW2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 15:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbUKPUWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 15:22:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:23230 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261783AbUKPUUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 15:20:35 -0500
Date: Tue, 16 Nov 2004 21:20:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os@analogic.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Work around a lockup?
In-Reply-To: <Pine.LNX.4.61.0411161456030.983@chaos.analogic.com>
Message-ID: <Pine.LNX.4.53.0411162111440.32739@yvahk01.tjqt.qr>
References: <Pine.LNX.4.53.0411162038490.8374@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0411161456030.983@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No driver code should ever wait forever. Some module code may
>be broken where the writter assumed that some bit must eventually
>be set or some FIFO must eventually empty, etc. Hardware breaks.

The box has locked up and I would like to know if there's a way around it.

>If you need to wait a long time for something, you can execute
>schedule_timeout(n) in your counted loop. This will give up
>the CPU to other tasks while you are waiting. More sophisticated
>code sleeps until interrupted, etc. Of course, the interrupt
>may never happen so your driver needs to plan for that too.

Let's *do* assume that some module's algorithm is not perfect, and further
assume that ATM, it's in an endless loop. Moreover, editing the module's source
is not an option.

This is not a homework or something, it's real. And I do not know where it's
hanging. Sure, SYSRQ+P would tell me where, but that could get hard to track if
it's the Nth stack frame (seen from the inner-most) for big N.

So for the moment to keep downtimes small, best option would be to have
something to circumvent the blocker process. E.g. putting it to sleep and
(then, finally, when I regain control) poke with the module's/kernel's source.

I've generalized the case into the above-mentioned for(;;); because that's the
worst case for uniprocessors, and I think it's best to start tackling there.


Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
