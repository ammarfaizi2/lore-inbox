Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269636AbUJLLaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269636AbUJLLaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 07:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269633AbUJLLaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 07:30:19 -0400
Received: from gate.crashing.org ([63.228.1.57]:42951 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269621AbUJLL3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 07:29:14 -0400
Subject: Re: Totally broken PCI PM calls
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@linuxmail.org
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <1097578189.3728.14.camel@desktop.cunninghams>
References: <1097455528.25489.9.camel@gaston>
	 <200410110915.33331.david-b@pacbell.net> <1097533363.13795.22.camel@gaston>
	 <200410111946.03634.david-b@pacbell.net>  <1097553724.7778.34.camel@gaston>
	 <1097578189.3728.14.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1097580477.26690.5.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 21:27:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > In the first case, it makes even sense to keep the driver operating
> > while the device is D1, the driver would then just wake the device on an
> > incoming request (provided this is allowed by the policy). In the later
> > case, the driver state is the only thing that matters.
> 
> Not quite - you have to be able to get the device into a matching state
> at resume time. Probably not a problem in most cases, I realise, but
> thought it was worth a mention.

Wait, I'm not talking about swsusp here, that's exactly my distinction
between driver state and device state :) Only system suspend like swsusp
and suspend-to-ram require a completely coherent and frozen memory
"image".

All sorts of dynamic PM, including system-wide "idle" can deal with
scenarios where the driver can stay functional and decide by itself to
wake up the device upon incoming requests.

> [...]
> 
> > Yup, with the exception that it becomes hell when those devices are
> > anywhere on the VM path... which makes userspace policy unuseable for
> > system suspend.
> 
> A device on the VM path? I don't follow here. Can I have a hand please?

Any block device basically, I don't even want to think about the issues
between NFS & suspend :)

That is anything that userspace potentially requires to operate (device on
the path to an mmap'd file, swap, whatever)...

Ben.


