Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbTEGEzg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 00:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTEGEzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 00:55:35 -0400
Received: from [12.47.58.20] ([12.47.58.20]:16561 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262473AbTEGEze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 00:55:34 -0400
Date: Tue, 6 May 2003 22:08:02 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: johnstul@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: tg3 - irq #: nobody cared!
Message-Id: <20030506220802.6d494326.akpm@digeo.com>
In-Reply-To: <1052283509.9817.1.camel@rth.ninka.net>
References: <1052258580.4495.12.camel@w-jstultz2.beaverton.ibm.com>
	<1052283509.9817.1.camel@rth.ninka.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 May 2003 05:08:01.0209 (UTC) FILETIME=[A1E07290:01C31456]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> On Tue, 2003-05-06 at 15:03, john stultz wrote:
> > 	Not sure if this is the proper fix, but it stops the kernel from
> > complaining. I saw Andrew suggest something similar for a sound driver.
> 
> Definitely not the right fix.  If the hardware status struct
> indicates no event is pending, then we return 0 since we
> didn't "handle" the interrupt.

This is about the fifth report of unhandled interrupts.  Against the fifth
driver which looks to be correct.

So I'd be suspecting the scenario which Alan outlined: the IRQ handler looped
around, scooped up the interrupt source before the APIC delivered the IRQ.

I'm working on the actual detection code - it tries to filter out the false
positives.

Suggest we ignore these reports until that is sorted out.
