Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271346AbTGWWGp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 18:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271348AbTGWWGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 18:06:45 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:54510 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271346AbTGWWGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 18:06:44 -0400
Subject: Re: compact flash IDE hot-swap summary please
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Dave Lawrence <dgl@integrinautics.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030723221525.A3397@flint.arm.linux.org.uk>
References: <3F1ECFDD.D561D861@integrinautics.com>
	 <1058984303.5515.105.camel@dhcp22.swansea.linux.org.uk>
	 <20030723204954.A439@flint.arm.linux.org.uk>
	 <1058991230.5515.126.camel@dhcp22.swansea.linux.org.uk>
	 <20030723221525.A3397@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058998510.6890.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 23:15:11 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 22:15, Russell King wrote:
> Ok, I see a couple of problems here.
> 
> Firstly, how does ide_cs in 2.6.0-test1 know that ide_unregister has
> failed?  In my copy of 2.6.0-test1, it doesn't return any values.

It does in 2.4. For 2.6 check with Bart - it may be the need has gone
away or that stuff got "cleaned up" that was needed

> Secondly, 2.4.21 seems to fail with value '1' for two cases:
>  - the ide interface wasn't found to be present
>  - the drive is in use
>  - the shutdown fails

Right. We want multiple fail cases. I know this - ditto it needs to
zap the iops

> not going to complete.  Hopefully an in-progress request should time
> out, but we shouldn't try to start a new request.

Once we've flipped the iops it wont matter if we accidentally queue 
new requests.

> So, in short, I think that IDE unplug is broken in the core IDE driver
> and needs significant work in _both_ 2.4 and 2.6 before we can think
> about getting PCMCIA-based IDE cards to work sufficiently well.  Yes,
> ide-cs.c may need some work, but ide.c also requires work.

You need a call in it to zap the iops, 3 return codes so you can tell
the difference - anything else ? If not I'll fix those.

