Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTIGUbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 16:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTIGUbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 16:31:35 -0400
Received: from ns.suse.de ([195.135.220.2]:49590 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261406AbTIGUbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 16:31:34 -0400
To: Adrian Bunk <bunk@fs.tum.de>
Cc: marcelo.tosatti@cyclades.com.br, linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
References: <20030907195557.GK14436@fs.tum.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Sep 2003 22:30:52 +0200
In-Reply-To: <20030907195557.GK14436@fs.tum.de.suse.lists.linux.kernel>
Message-ID: <p73u17ojq83.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@fs.tum.de> writes:

> With CONFIG_M686 CONFIG_X86_L1_CACHE_SHIFT was set to 5, but a Pentium 4 
> requires 7.

It doesn't require 7, it just prefers 7. 

> The patch below does:
> - set CONFIG_X86_L1_CACHE_SHIFT 7 for all Intel processors (needed for 
>   the Pentium 4)
> - set CONFIG_X86_L1_CACHE_SHIFT 6 for the K6 (needed for the Athlon)

I think these changes should be only done with CONFIG_X86_GENERIC is set.

Otherwise the people who want kernels really optimized for their CPUs
won't get the full benefit. On UP it does not make that much difference,
but on a SMP kernel having a bigger than needed cache size wastes a lot
of memory.

-Andi
