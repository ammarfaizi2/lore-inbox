Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUGOCj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUGOCj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 22:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUGOCj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 22:39:58 -0400
Received: from holomorphy.com ([207.189.100.168]:41633 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265784AbUGOCj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 22:39:57 -0400
Date: Wed, 14 Jul 2004 19:39:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: VM Problems in 2.6.7 (Too active OOM Killer)
Message-ID: <20040715023951.GK3411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Zaitsev <peter@mysql.com>, Andrew Morton <akpm@osdl.org>,
	andrea@suse.de, linux-kernel@vger.kernel.org
References: <1089771823.15336.2461.camel@abyss.home> <20040714031701.GT974@dualathlon.random> <1089776640.15336.2557.camel@abyss.home> <20040713211721.05781fb7.akpm@osdl.org> <1089848823.15336.3895.camel@abyss.home> <20040714154427.14234822.akpm@osdl.org> <1089851451.15336.3962.camel@abyss.home> <20040715015431.GF3411@holomorphy.com> <1089857602.15336.4120.camel@abyss.home> <20040715023300.GJ3411@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040715023300.GJ3411@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2004 at 07:33:00PM -0700, William Lee Irwin III wrote:
> At the rebalance label, failure will only be delivered when the
> check if (current->flags & (PF_MEMALLOC|PF_MEMDIE)), otherwise,
> __alloc_pages() retries indefinitely and ignores signals.

Careful not to make too much of ignoring signals, mm/oom_kill.c sets
PF_MEMDIE out-of-context, so when an OOM kill is issued while a task
is looping in __alloc_pages() it will eventually break out of the
rebalance loop due to the flag.


-- wli
