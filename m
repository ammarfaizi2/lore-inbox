Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWGZV3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWGZV3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGZV3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 17:29:46 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:47319 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751175AbWGZV3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 17:29:45 -0400
Date: Wed, 26 Jul 2006 14:21:02 -0700
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060726212102.GA23787@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com> <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org> <20060726204233.GA23488@in.ibm.com> <1153947786.3381.58.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1153947786.3381.58.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 11:03:06PM +0200, Arjan van de Ven wrote:
> rwsems unfortunately help you zilch; an rwsem is just a mutex with a
> performance tweak, but from the deadlock perspective it's really a
> mutex.

ah ..didnt realize that. 

> I'm really starting to feel that the hotplug lock would have been better
> of being a refcount (with a waitqueue for zero) than a lock. While
> "refcount+waitqueue" sort of IS a lock, the semantics make more sense
> imo...

I think that will work, although you now need to deal with a global or per-cpu 
refcount now. Later is more cache-friendly, but dont think we have ready 
refcounting APIs for that?

-- 
Regards,
vatsa
