Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTFKTEg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 15:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTFKTEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 15:04:36 -0400
Received: from ns.suse.de ([213.95.15.193]:63760 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263930AbTFKTEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 15:04:32 -0400
Date: Wed, 11 Jun 2003 21:18:15 +0200
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: ak@suse.de, vojtech@suse.cz, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
Message-ID: <20030611191815.GA30411@wotan.suse.de>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 11:50:32AM -0700, Bryan O'Sullivan wrote:
> The time code for x86-64 in 2.5.70 isout of date and wildly unstable,
> setting the clock to the year 1,115,117 (!) during boot about 60% of the
> time.  This subsequently causes other pieces of completely unrelated
> userspace software to crash randomly for no obvious reason once the
> system comes up.

Thanks for doing this work.

Does it only look this way or is your white space really broken?

> Right now, the only known problem is with the fixup of jiffies if a
> timer interrupt is lost, which I've hence turned off.  There's
> preliminary support for using HPET for the gettimeofday vsyscall, but
> since vsyscalls are disabled on x86-64 for now, that's obviously
> untested.

What makes you think they are disabled? They are used for every 64bit
program that uses gettimeofday or time and enabled by default.

> +static inline void rdtscll_sync(unsigned long *tsc)
> +{
> +	sync_core();
> +	rdtscll(*tsc);

On UP the sync_core is not really needed, but more reliable. May be worth
it to stick into an #ifdef though.
>  
>  	}
>   
> +	call++;
> +

What's that?


-Andi
