Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264379AbTICTWu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 15:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTICTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 15:21:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6160
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264195AbTICTTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 15:19:30 -0400
Date: Wed, 3 Sep 2003 12:19:46 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH]O20int
Message-ID: <20030903191946.GB16361@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200309040053.22155.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309040053.22155.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 12:53:10AM +1000, Con Kolivas wrote:
> Smaller timeslice granularity for most interactive tasks and larger for less 
> interactive. Smaller for each extra cpu.

> +#ifdef CONFIG_SMP
> +#define TIMESLICE_GRANULARITY(p) \
> +	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))) * \
> +		num_online_cpus())
> +#else
> +#define TIMESLICE_GRANULARITY(p) \
> +	(MIN_TIMESLICE * (1 << (MAX_BONUS - CURRENT_BONUS(p))))
> +#endif
> +

Don't you want to put a max(10,TIMESLICE_GRANULARITY) in there so that the
time slice won't go below 1ms for large proc servers?  I'm not sure if it
was you, or someone else but they did some testing to see how the
timeslice length affected the cache warmth, and the major improvements
stopped after 7ms, so 10 might be a good default mimimum.

Mike
