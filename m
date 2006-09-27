Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030722AbWI0TtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030722AbWI0TtW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 15:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030723AbWI0TtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 15:49:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53717 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030722AbWI0TtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 15:49:21 -0400
Date: Wed, 27 Sep 2006 12:49:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Markus Schoder <lists@gammarayburst.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: PROBLEM with 2.6.18: BUG: scheduling while atomic
Message-Id: <20060927124904.1a0d94c2.akpm@osdl.org>
In-Reply-To: <200609271444.20845.lists@gammarayburst.de>
References: <200609271444.20845.lists@gammarayburst.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 14:44:20 +0200
Markus Schoder <lists@gammarayburst.de> wrote:

> Twice within the last 4 days the kernel started generating
> 
> BUG: scheduling while atomic: swapper/0x00000001/0
> 
> messages like crazy (several hundreds per second) and would not stop until
> rebooted.  I have no idea what triggered it.
> 
> Did not have this problem with the 2.6.17 series which I am back to
> using now.
> 
> I am using the proprietary nvidia module so if people think it helps I can try
> to recreate the problem without this module (might take a few days though).
> 
> The logged call traces are not always completely identical here are some
> examples:
> 
> Sep 24 13:29:24 gondolin kernel: Call Trace:
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff80268ca5>] thread_return+0x0/0xeb
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff802684fa>] __sched_text_start+0x7a/0x825
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff88000000>] :unix:unix_poll+0x0/0xb0
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff8026ef30>] default_idle+0x0/0x60
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff8024f276>] cpu_idle+0x96/0xb0
> Sep 24 13:29:24 gondolin kernel:  [<ffffffff805e5641>] start_secondary+0x4f1/0x500

This might indicate that some code somewhere forgot to do
spin_unlock/preempt_enable/kunmap_atomic/whatever.

Ingo, do you have a current version of the patch which allows us to locate
the culprit?

Thanks.
