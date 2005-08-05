Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVHEPUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVHEPUj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 11:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVHEPSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 11:18:39 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:46810 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S263042AbVHEPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 11:17:43 -0400
Subject: Re: Is it a process?
From: Steven Rostedt <rostedt@goodmis.org>
To: lab liscs <liscs.lab@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1132fcd6050805060216a03fb6@mail.gmail.com>
References: <1132fcd6050805060216a03fb6@mail.gmail.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 11:17:39 -0400
Message-Id: <1123255059.18332.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 21:02 +0800, lab liscs wrote:
> when linux kernel receives a packet from the netcard and the forwards it .
> 
> the process can be viewed as a kernel process ?
> 
> and if this process can be interrupted ?
> 
> thanks a lot!!

When a packet is received from the kernel, this is first done by an
interrupt handler to just get the packet. Then the rest (forwarding) is
done by a tasklet. This tasklet can be run either by the softirqd (a
kernel thread) or at certain locations in the kernel. So this is not a
normal process and no it can not be preempted or scheduled out (it can
be interrupted by an interrupt though).

-- Steve


