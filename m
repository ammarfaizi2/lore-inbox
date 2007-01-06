Return-Path: <linux-kernel-owner+w=401wt.eu-S932090AbXAFTMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbXAFTMK (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbXAFTMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:12:10 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36183 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092AbXAFTMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:12:09 -0500
Date: Sat, 6 Jan 2007 11:11:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-Id: <20070106111117.54bb2307.akpm@osdl.org>
In-Reply-To: <20070106163851.GA13579@in.ibm.com>
References: <20061217223416.GA6872@tv-sign.ru>
	<20061218162701.a3b5bfda.akpm@osdl.org>
	<20061219004319.GA821@tv-sign.ru>
	<20070104113214.GA30377@in.ibm.com>
	<20070104142936.GA179@tv-sign.ru>
	<20070104091850.c1feee76.akpm@osdl.org>
	<20070106151036.GA951@tv-sign.ru>
	<20070106154506.GC24274@in.ibm.com>
	<20070106163035.GA2948@tv-sign.ru>
	<20070106163851.GA13579@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 22:08:51 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> 	This workqueue problem has exposed a classic example of how 
> tough/miserable it can be to write hotplug safe code w/o something like
> lock_cpu_hotplug() ..Are you still inclined towards banning it? :)

I don't ban stuff - I just advocate ;)

I would still prefer that we not try to invent a new magical lock,
but yes, the current approach is looking troublesome.

> FYI, the lock_cpu_hotplug() rewrite proposed by Gautham at
> http://lkml.org/lkml/2006/10/26/65 may still need refinement to avoid
> all the kind of deadlocks we have unearthed with workqueue example. I
> can review that design with Gautham if there is some interest to
> revive lock_cpu_hotplug() ..

Has anyone thought seriously about using the process freezer in the
cpu-down/cpu-up paths?  That way we don't need to lock anything anywhere?
