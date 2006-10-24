Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWJXJo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWJXJo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 05:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbWJXJo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 05:44:57 -0400
Received: from www.osadl.org ([213.239.205.134]:33154 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030226AbWJXJo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 05:44:56 -0400
Subject: Re: rtmutex's wait_lock in 2.6.18-rt7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610231150500.12557@frodo.shire>
References: <Pine.LNX.4.64.0610231150500.12557@frodo.shire>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 11:46:03 +0200
Message-Id: <1161683163.22373.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 11:55 +0200, Esben Nielsen wrote:
> Hi,
>   I see that in 2.6.18-rt7 the rtmutex's wait_lock is sudden interrupt 
> disabling. I don't see the need as no (hard) interrupt-handlers should be 
> touching any mutex.

It does not touch mutexes, but the dynamic priority adjustment of the
hrtimer softirq needs it. 

The correct solution will be moving the timer callback into the process
context, as it will be woken up anyway, but that's more complex to do
than it looks in the first place.

	tglx


