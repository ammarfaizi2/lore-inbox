Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWFLRwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWFLRwW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWFLRwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:52:22 -0400
Received: from mx1.suse.de ([195.135.220.2]:52378 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750842AbWFLRwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:52:22 -0400
Message-ID: <448DA9D3.1090908@suse.de>
Date: Mon, 12 Jun 2006 19:52:19 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] scheduler issue & patch
References: <448D88A2.1060002@suse.de> <20060612102847.A5687@unix-os.sc.intel.com>
In-Reply-To: <20060612102847.A5687@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> I don't think it is the problem with sched_balance_self(). sched_balance_self()
> probably is doing the right thing based on the load that is present at the
> time of fork/exec. Once the node-1 becomes idle, we expect the two threads
> on node-0 cpu-1 to get distributed between the two nodes.

That happens indeed.  Problem with that is that the thread which gets
migrated from cpu1 (node0) to cpu3 (node1) ends up with memory for the
working set being allocated from node0 memory because it ran on node0
for a short time.  Which is a noticable performance hit on a NUMA system.

I think the scheduler should try harder to spread the threads across
cpus in a way that they can stay on the initial cpu instead of migrating
them later on.

> In my opinion, this patch is not the correct fix for the issue.

Sure, it's sort-od band-aid fix, thats why I'm trying to find something
better.

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
