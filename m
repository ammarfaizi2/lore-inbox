Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbTEHUdF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTEHUdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:33:05 -0400
Received: from maild.telia.com ([194.22.190.101]:27614 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id S262118AbTEHUck convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:32:40 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux rt priority  thread corrupt  global variable?
Date: Thu, 8 May 2003 22:45:39 +0200
User-Agent: KMail/1.5.9
References: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
In-Reply-To: <029601c31540$b57f1280$0305a8c0@arch.sel.sony.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200305082245.39336.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On torsdag 08 maj 2003 11:03, Ming Lei wrote:
> 
> Is linux kernel 2.4.10 considered strictly preemptive such as VxWorks or
> other RTOS? I guess 2.4.10 may simulate preemptive with running scheduler on
> every syscall or interrupt returns. Am I right?
>

Yes, but what else is there?
- A timer interrupt that ends a sleep for a RT process.
- A device interrupt that notifies a RT process about new data.
- A process that wakes up another process.
The problem with 2.4.10 is that while the current process is
executing IN kernel, the wakened RT process will need to wait
until the current leaves kernel or goes to sleep.

This is not a huge problem since there are patches for 2.4.10 that adds
explicit checks in found kernel spots (loops over long lists).

Later kernels got some of these improvements. There are patches for
these as well.

In the 2.5 series you can specify preemptive kernel.
With that a preemption can happen in the kernel but not
when being inside a spin lock. There are patches for this case
as well.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

