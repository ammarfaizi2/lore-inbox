Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbVIGOwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbVIGOwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVIGOwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:52:22 -0400
Received: from colo.lackof.org ([198.49.126.79]:53706 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932148AbVIGOwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:52:21 -0400
Date: Wed, 7 Sep 2005 08:58:18 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Brian King <brking@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com, matthew@wil.cx,
       benh@kernel.crashing.org, ak@muc.de, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
Message-ID: <20050907145818.GA25409@colo.lackof.org>
References: <42B83B8D.9030901@us.ibm.com> <430B3CB4.1050105@us.ibm.com> <20050901160356.2a584975.akpm@osdl.org> <4318E6B3.7010901@us.ibm.com> <20050902224314.GB8463@colo.lackof.org> <17176.56354.363726.363290@cargo.ozlabs.ibm.com> <20050903000854.GC8463@colo.lackof.org> <431A33D0.1040807@us.ibm.com> <20050903193958.GB30579@colo.lackof.org> <17182.32625.930500.874251@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17182.32625.930500.874251@cargo.ozlabs.ibm.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 03:49:37PM +1000, Paul Mackerras wrote:
> Maybe, but it seems like a bad idea to me.  It's longer, it's less
> obvious what's happening,

I would argue it more obvious. People looking at the code
are immediately going to realize it was a deliberate choice to
not use a spinlock.

> and it precludes the sorts of optimization
> that we do on ppc64 where a cpu that is waiting for a lock can tell
> give its time slice to the cpu that is holding the lock (on systems
> where the hypervisor time-slices multiple virtual cpus on one physical
> cpu).

relax_cpu() doesn't do that?


> What's wrong with just doing spin_lock/spin_unlock?

it's not wrong - just misleading IMHO. There is no
"critical section" in that particular chunk of code.

If relax_cpu doesn't allow time-slice donation, then I guess
spinlock/unlock with only a comment inside it explain why
would be ok too.

thanks,
grant
