Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317396AbSHHJBA>; Thu, 8 Aug 2002 05:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317398AbSHHJBA>; Thu, 8 Aug 2002 05:01:00 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:62363 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S317396AbSHHJBA>; Thu, 8 Aug 2002 05:01:00 -0400
Date: Thu, 8 Aug 2002 11:03:59 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020808110359.1aa8f4a1.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208080314.WAA04821@ccure.karaya.com>
References: <20020808032704.73d7fdda.us15@os.inf.tu-dresden.de>
	<200208080314.WAA04821@ccure.karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Aug 2002 22:14:42 -0500
Jeff Dike <jdike@karaya.com> wrote:
> 
> Not really.  What we really want is for signals not to be delivered at all.
> That's why the ptrace signal annulling capability is nice.
> 
> I'm not sure if this makes any sense, but coupling the new aio mechanism with
> something that queues up siginfos might be interesting.  It would be a magic
> descriptor that would feed you signals when you read it.
> 
> Is that at all sane?

I know that we're trying to avoid signal handlers, because they are expensive.
But the signal would not need to be delivered in the task. We need a mechanism to
stop the task and force it into kernel. The task is uncooperative and doesn't
dequeue signals itself. When it gets a signal it stops. The kernel then sees the
signal and accepts it using sigwaitinfo, at which point it is no longer pending
in the task either. The siginfo structure then provides the necessary info,
i.e. which fd caused the i/o.

When running in a kernel context, you actually need to deliver SIGIO in order
to interrupt the current context.

If you have a magic aio descriptor, how does the task process read signals
from it and stop?

-Udo.
