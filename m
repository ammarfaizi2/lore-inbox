Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUCHVC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 16:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbUCHVC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 16:02:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:60853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261221AbUCHVC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 16:02:27 -0500
Date: Mon, 8 Mar 2004 13:02:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in
 <=16G machines)
Message-Id: <20040308130231.59deef80.akpm@osdl.org>
In-Reply-To: <20040308202433.GA12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> without this patch not even the 4:4 tlb overhead would allow intensive
> shm (shmfs+IPC) workloads to surivive on 32bit archs. Basically without
> this fix it's like 2.6 is running w/o pte-highmem.

yes.

> But the real reason of this work is for huge 64bit archs, so we speedup
> and avoid to waste tons of ram.

pte_chain space consumption is approximately equal to pagetable page space
consumption.  Sometimes a bit more, sometimes a lot less, approximately
equal.

So why do you say it saves "tons of ram"?

> on 32-ways the scalability is hurted
> very badly by rmap, so it has to be removed (Martin can provide the
> numbers I think).

I don't recall that the objrmap patches ever significantly affected CPU
utilisation.

I'm not saying that I'm averse to the patches, but I do suspect that this is
a case of large highmem boxes dragging the rest of the kernel along behind
them, and nothing else.
