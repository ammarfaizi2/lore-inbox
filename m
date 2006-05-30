Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWE3T46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWE3T46 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 15:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWE3T46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 15:56:58 -0400
Received: from mga06.intel.com ([134.134.136.21]:13904 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932455AbWE3T45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 15:56:57 -0400
X-IronPort-AV: i="4.05,190,1146466800"; 
   d="scan'208"; a="43397761:sNHT78223593"
Date: Tue, 30 May 2006 12:53:58 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Dave Jones <davej@redhat.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Ingo Molnar <mingo@elte.hu>, nanhai.zou@intel.com, ashok.raj@intel.com
Subject: Re: [patch 00/61] ANNOUNCE: lock validator -V1
Message-ID: <20060530125357.A21581@unix-os.sc.intel.com>
References: <20060529212109.GA2058@elte.hu> <6bffcb0e0605291528qe24a0a3r3841c37c5323de6a@mail.gmail.com> <20060529224107.GA6037@elte.hu> <20060529230908.GC333@redhat.com> <1148967947.3636.4.camel@laptopd505.fenrus.org> <20060530141006.GG14721@redhat.com> <1148998762.3636.65.camel@laptopd505.fenrus.org> <20060530145852.GA6566@redhat.com> <20060530171118.GA30909@dominikbrodowski.de> <20060530193947.GG17218@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060530193947.GG17218@redhat.com>; from davej@redhat.com on Tue, May 30, 2006 at 03:39:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 03:39:47PM -0400, Dave Jones wrote:

> So, that last part pretty highlights that we knew about this problem, and meant to
> come back and fix it later. Surprise surprise, no one came back and fixed it.
> 

There was another iteration after his, and currently we keep track of
the owner in lock_cpu_hotplug()->__lock_cpu_hotplug(). So if we are in 
same thread context we dont acquire locks.

    if (lock_cpu_hotplug_owner != current) {
        if (interruptible)
            ret = down_interruptible(&cpucontrol);
        else
            down(&cpucontrol);
    }


the lock and unlock kept track of the depth as well, so we know when to release

We didnt hear any better suggestions (from cpufreq folks), so we left it in 
that state (atlease the same thread doenst try to take the lock twice) 
that resulted in deadlocks earlier.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
