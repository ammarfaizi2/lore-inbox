Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVA0KwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVA0KwL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 05:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbVA0Ksf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 05:48:35 -0500
Received: from one.firstfloor.org ([213.235.205.2]:736 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262562AbVA0Klh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 05:41:37 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch 2/6 introduce helper infrastructure
References: <20050127101117.GA9760@infradead.org>
	<20050127101228.GC9760@infradead.org>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 Jan 2005 11:41:33 +0100
In-Reply-To: <20050127101228.GC9760@infradead.org> (Arjan van de Ven's
 message of "Thu, 27 Jan 2005 10:12:28 +0000")
Message-ID: <m1is5j40iq.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:
> +unsigned int get_random_int(void)
> +{
> +	static unsigned int val = 0;
> +
> +	val += current->pid + jiffies;

Shouldn't there be some kind of locking for this? It's random,
but still random corruption sounds a bit too random.

Also you probably have a very hot cache line here, which
may hurt on the bigger machines.

I think it would be better to just get a global random number
for each mm as it is created and then run a fast PRNG with that
state. Maybe even make it per task to improve performance on
multithreaded programs. Or alternatively per cpu state with
different starting points.

-Andi
