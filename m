Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946025AbWKJI0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946025AbWKJI0J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 03:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424380AbWKJI0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 03:26:08 -0500
Received: from mail.suse.de ([195.135.220.2]:55513 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424379AbWKJI0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 03:26:06 -0500
To: "Bela Lubkin" <blubkin@vmware.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: touch_cache() only touches two thirds
References: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com>
From: Andi Kleen <ak@suse.de>
Date: 10 Nov 2006 09:25:51 +0100
In-Reply-To: <FE74AC4E0A23124DA52B99F17F441597DA118C@PA-EXCH03.vmware.com>
Message-ID: <p734pt7k8s0.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bela Lubkin" <blubkin@vmware.com> writes:
> 
> /*
>  * Dirty a big buffer in a hard-to-predict (for the L2 cache) way. This
>  * is the operation that is timed, so we try to generate unpredictable
>  * cachemisses that still end up filling the L2 cache:
>  */

The comment is misleading anyways. AFAIK several of the modern
CPUs (at least K8, later P4s, Core2, POWER4+, PPC970) have prefetch 
predictors advanced enough to follow several streams forward and backwards
in parallel.

I hit this while doing NUMA benchmarking for example.

Most likely to be really unpredictable you need to use a
true RND and somehow make sure still the full cache range 
is covered.


-Andi
