Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268650AbUILKrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268650AbUILKrb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268658AbUILKra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:47:30 -0400
Received: from ozlabs.org ([203.10.76.45]:9612 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268652AbUILKqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:46:44 -0400
Date: Sun, 12 Sep 2004 20:43:06 +1000
From: Anton Blanchard <anton@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] Yielding processor resources during lock contention
Message-ID: <20040912104306.GA25741@krispykreme>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com> <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com> <200409121210.32259.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409121210.32259.arnd@arndb.de>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> For s390, this was solved by simply defining cpu_relax() to the hypervisor
> yield operation, because we found that cpu_relax() is used only in busy-wait
> situations where it makes sense to continue on another virtual CPU.
> 
> What is the benefit of not always doing a full hypervisor yield when
> you hit cpu_relax()?

cpu_relax doesnt tell us why we are busy looping. In this particular
case we want to pass to the hypervisor which virtual cpu we are waiting
on so the hypervisor make better scheduling decisions.

Did you manage to see any improvement by yielding to the hypervisor
in cpu_relax?

Anton
