Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbULEPWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbULEPWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 10:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbULEPWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 10:22:53 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:21662 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261158AbULEPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 10:22:51 -0500
Date: Sun, 5 Dec 2004 16:22:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041205152202.GA30536@dualathlon.random>
References: <20041201104820.1.patchmail@tglx> <20041205025236.GN2714@holomorphy.com> <1102253902.13353.344.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102253902.13353.344.camel@tglx.tec.linutronix.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 05, 2004 at 02:38:22PM +0100, Thomas Gleixner wrote:
> Andrea provided a quite good fix for the invokation problem. I'm just
> tracking down a different problem which was revieled by his changes.
> 
> The selection mechanism is currently taking a couple of things into
> account:
> 
>  - VM size
>  - nice value
>  - CPU time
>  - owner == root ?
>  - CAP_SYS_RAWIO
> 
> I found out, that it is neccecary to take the child processes into
> account to detect processes which fork a lot of childs.
> 
> The current mechanism rather kills sshd or portmap as they happen to
> have a bigger VM size than the process which forked a lot of childs.

Taking childs into account looks fine to me.
