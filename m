Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264251AbUFPRZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264251AbUFPRZY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 13:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbUFPRZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 13:25:24 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:54684 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264251AbUFPRZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 13:25:23 -0400
Message-ID: <40D08225.6060900@colorfullife.com>
Date: Wed, 16 Jun 2004 19:23:49 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dimitri Sivanich <sivanich@sgi.com>
CC: linux-kernel@vger.kernel.org, lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH]: Option to run cache reap in thread mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimitri wrote:

>In the process of testing per/cpu interrupt response times and CPU availability,
>I've found that running cache_reap() as a timer as is done currently results
>in some fairly long CPU holdoffs.
>
What is fairly long?
If cache_reap() is slow than the caches are too large.
Could you limit cachep->free_limit and check if that helps? It's right 
now scaled by num_online_cpus() - that's probably too much. It's 
unlikely that all 500 cpus will try to refill their cpu arrays at the 
same time. Something like a logarithmic increase should be sufficient.
Do you use the default batchcount values or have you increased the values?
I think the sgi ia64 system do not work with slab debugging, but please 
check that debugging is off. Debug enabled is slow.

--
    Manfred

