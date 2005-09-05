Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932326AbVIEQ2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932326AbVIEQ2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 12:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbVIEQ2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 12:28:11 -0400
Received: from [81.2.110.250] ([81.2.110.250]:17024 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932315AbVIEQ2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 12:28:09 -0400
Subject: Re: Linux Kernel 2.6.13-rc7 (WORKS) (2.6.13, DRQ/System CRASH)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, linux-ide@vger.kernel.org, apiszcz@lucidpixels.com
In-Reply-To: <58cb370e050905002630a0e02e@mail.gmail.com>
References: <Pine.LNX.4.63.0508311328230.1945@p34>
	 <Pine.LNX.4.63.0508311408320.1945@p34>
	 <58cb370e050905002630a0e02e@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 05 Sep 2005 13:29:57 +0100
Message-Id: <1125923397.8714.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-05 at 09:26 +0200, Bartlomiej Zolnierkiewicz wrote:
> After DMA timeout driver reverted back to PIO,
> ide-taskfile.c also holds PIO code besides IDE Taskfile Access.


On SMP after a DMA timeout it will potentially freeze. There are some
paths in that code which lead to double lock takes and hangs, plus some
timer races.

Justin can you make a backup (I mean that seriously), then build a
kernel with spin lock debug enabled and see if you can reproduce the
problem and get a trace. 

If its the locking you'll get a trace and the kernel will continue. At
that point because the spinlock debug continues unsafely through a
double lock after the trace you are in the "danger zone" hence the
backup warning

[Yes the spin lock debug code really should warn you its dangerous for
non debug uses or get patched as it is in Fedora to trace and stop]

If its a hardware or other problem it will still hang

if its an unrelated lock problem it should still get a trace.


Why you see this only on 2.6.13 not 2.6.13-rc7 I don't know. It makes me
wonder if you have a bad drive - but then you imply going back to rc7
goes back to stable. Can you therefore also check the .config options
between the two kernels match.

Alan

