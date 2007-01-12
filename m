Return-Path: <linux-kernel-owner+w=401wt.eu-S1161050AbXALJtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbXALJtO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 04:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbXALJtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 04:49:14 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56018 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161050AbXALJtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 04:49:13 -0500
Date: Fri, 12 Jan 2007 09:59:40 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sched: avoid div in rebalance_tick
Message-ID: <20070112095940.0795a998@localhost.localdomain>
In-Reply-To: <20070112060213.GB28611@wotan.suse.de>
References: <20070112060213.GB28611@wotan.suse.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 07:02:13 +0100
Nick Piggin <npiggin@suse.de> wrote:

> Just noticed this while looking at a bug.
> Avoid an expensive integer divide 3 times per CPU per tick.

Integer divide is cheap on some modern processors, and multibit shift
isn't on all embedded ones.

How about putting back scale = 1 and using

scale += scale;

instead of the shift and getting what ought to be even better results

