Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbSJ1Q2d>; Mon, 28 Oct 2002 11:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbSJ1Q2d>; Mon, 28 Oct 2002 11:28:33 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:1927 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261344AbSJ1Q2c> convert rfc822-to-8bit; Mon, 28 Oct 2002 11:28:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Date: Mon, 28 Oct 2002 17:34:40 +0100
User-Agent: KMail/1.4.1
Cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
References: <200210280132.33624.efocht@ess.nec.de> <3128418467.1035736310@[10.10.2.3]>
In-Reply-To: <3128418467.1035736310@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210281734.41115.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 October 2002 01:31, Martin J. Bligh wrote:
> OK, so I'm trying to read your patch 1, fairly unsucessfully
> (seems to be a lot more complex that Michael's).
>
> Can you explain pool_lock? It does actually seem to work, but
> it's rather confusing ....

The pool data is needed to be able to loop over the CPUs of one node,
only. I'm convinced we'll need to do that sometime, no matter how simple
the core of the NUMA scheduler is.

The pool_lock is protecting that data while it is built. This can happen
in future more often, if somebody starts hotplugging CPUs.

> build_pools() has a comment above it saying:
>
> +/*
> + * Call pooldata_lock() before calling this function and
> + * pooldata_unlock() after!
> + */
>
> But then you promptly call pooldata_lock inside build_pools
> anyway ... looks like it's just a naff comment, but doesn't
> help much.

Sorry, the comment came from a former version...

> just block). If you really still need to do this, RCU is now
> in the kernel ;-) If not, can we just chuck all that stuff?

I'm preparing a core patch which doesn't need the pool_lock. I'll send it
out today.

Regards,
Erich

