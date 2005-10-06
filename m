Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbVJFNch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbVJFNch (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbVJFNch
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:32:37 -0400
Received: from ns2.suse.de ([195.135.220.15]:61376 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750918AbVJFNcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:32:36 -0400
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru,
       "Andrey Savochkin" <saw@sawoct.com>, st@sw.ru, discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru>
From: Andi Kleen <ak@suse.de>
Date: 06 Oct 2005 15:32:30 +0200
In-Reply-To: <434520FF.8050100@sw.ru>
Message-ID: <p73hdbuzs7l.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev <dev@sw.ru> writes:

> Please help with a not simple question about spin_lock/spin_unlock on
> SMP archs. The question is whether concurrent spin_lock()'s should
> acquire it in more or less "fair" fashinon or one of CPUs can starve
> any arbitrary time while others do reacquire it in a loop.

They are not fully fair because of the NUMAness of the system.
Same on many other NUMA systems.

We considered long ago to use queued locks to avoid this, but 
they are quite costly for the uncongested case and never seemed worth it.

So live with it.

-Andi
