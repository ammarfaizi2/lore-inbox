Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUBQVsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 16:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266664AbUBQVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 16:45:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:12767 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266652AbUBQVme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 16:42:34 -0500
Date: Tue, 17 Feb 2004 13:43:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Florian Schanda <ma1flfs@bath.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 99% System load
Message-Id: <20040217134350.0da17784.akpm@osdl.org>
In-Reply-To: <200402172116.18254.ma1flfs@bath.ac.uk>
References: <200402111423.02217.ma1flfs@bath.ac.uk>
	<20040211234413.3d90df5d.akpm@osdl.org>
	<200402172116.18254.ma1flfs@bath.ac.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schanda <ma1flfs@bath.ac.uk> wrote:
>
> Finally it happened again. I attached the output of that dmesg.
> 
> > It would help if you could make a note of the PIDs of the hung processes,
> > so they can be correlated with the sysrq output.
> 
> The PIDs hanging are 3303, 3305, 3306, 3307.

It _looks_ like all four CPUs are madly taking timer interrupts.  Which
tends to point at some APIC problem, failing to clear the interrupt source.
But if that happened one wouldn't expect userspace to remain in a runnable
state, and you say that you can still run commands.

> An advance warning: I had the nvidia driver (yes, I know, closed source makes 
> debugging impossible) loaded, and before the trace begins, there are some 
> messages of that module:

It is probably unrelated, but I'd suggest that you not use the nvidia
driver for a while, verify that the lockup happens without it loaded.

