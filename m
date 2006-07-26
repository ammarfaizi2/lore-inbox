Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWGZUvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWGZUvV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWGZUvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:51:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:28573 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751139AbWGZUvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:51:20 -0400
Date: Wed, 26 Jul 2006 13:42:33 -0700
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060726204233.GA23488@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com> <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153942954.3381.50.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 09:42:34PM +0200, Arjan van de Ven wrote:
> As a quick hack I made non-lock_cpu_hotplug()'ing versions of the 3 key
> workqueue functions (patch below). It works, it's correct, it's just so
> ugly that I'm almost too ashamed to post it. I haven't found a better
> solution yet though... time to take a step back I suppose.

My worry is that such special cases might be needed in more places as we
discover further or as code evolves. Fundamentally looks like the locked and 
unlocked paths of the kernel cannot be separated so well because of interaction 
between subsystems. /me thinks rwsem seems to be a sane thing to go after.

-- 
Regards,
vatsa
