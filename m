Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316043AbSGSQNG>; Fri, 19 Jul 2002 12:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316892AbSGSQNG>; Fri, 19 Jul 2002 12:13:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28545 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316043AbSGSQNF>; Fri, 19 Jul 2002 12:13:05 -0400
Date: Fri, 19 Jul 2002 12:16:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Hildo.Biersma@morganstanley.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value
Message-ID: <20020719121604.A11443@devserv.devel.redhat.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716.165241.123987278.davem@redhat.com> <1026869741.2119.112.camel@irongate.swansea.linux.org.uk> <20020716.172026.55847426.davem@redhat.com> <mailman.1026868201.10433.linux-kernel2news@redhat.com> <200207180001.g6I015f02681@devserv.devel.redhat.com> <15671.8335.526673.92376@axolotl.ms.com> <20020718195501.A21027@devserv.devel.redhat.com> <15671.63658.675586.540958@axolotl.ms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15671.63658.675586.540958@axolotl.ms.com>; from Hildo.Biersma@morganstanley.com on Fri, Jul 19, 2002 at 07:31:54AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Fri, 19 Jul 2002 07:31:54 -0400 (EDT)
> From: Hildo.Biersma@morganstanley.com

> Pete>  1. Make close to block indefinitely, retrying writes.
> Pete>     Allow overlapping writes, let clients to sort it out.
> 
> None of these things work, as security may be denied, a volume may be
> taken off-line, or hvaing overlppaing writes from clients increases
> the amount of client<->server interaction.
> 
> Pete>  2. Provide an ioctl to flush writes before close() or
> Pete>     make fsync() work right. Your "smart" applications have had
> Pete>     to use that, so that no ambiguity existed between tearing down
> Pete>     the descriptor and writing out the data.
> 
> This is provided - sync, fsync, msync all work.

It is unfair for you to separate 1. and 2. They should work
together. Remember, you said "return error from close is
useful BECAUSE my smart application may deal with it."
If fsync works, the argument does not hold water at all.
Your smart application can do fsync just as easily.
If it does, it does not need the return code from close.

> That's work the trade-offs come in.  The AFS designers found that
> relaxing the Unix filesystem semantics vastly improves scalability.

I know about the improvements. They are applicable to NFS too.
What I am trying to tell you is that there was NO reason to break
close in particular. Even on ancient AIXes without fsync they
could have used an ioctl.

-- Pete
