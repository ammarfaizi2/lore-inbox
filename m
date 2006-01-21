Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWAUK10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWAUK10 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 05:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932101AbWAUK1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 05:27:25 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:32144
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932096AbWAUK1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 05:27:25 -0500
Subject: Re: divide error at sample_to_timespec
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Aleksander Salwa <A.Salwa@osmosys.tv>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43CE44F1.6020107@osmosys.tv>
References: <43CE44F1.6020107@osmosys.tv>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 11:28:07 +0100
Message-Id: <1137839287.28034.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 14:38 +0100, Aleksander Salwa wrote:
> Hi all,
> 
> I got a "divide error" message from the kernel in my system log file 
> (x86, P4 HT, kernel 2.6.14-1.1653_FC4smp). System is still alive, but 
> probably something bad happened with thread that made a syscall which 
> caused that divide error. Should it be considered a kernel bug ?
> It looks like there is an overflow (too big value in edx:aex divided by 
> relatively small value in ebx).

Actually the value is negative: 0xffffffffffc2f700
This is -4000000 ns == -4ms

So the accounting is off by one jiffie.

Does this happen with current kernels too ?

	tglx


