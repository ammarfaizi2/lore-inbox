Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWFFVlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWFFVlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWFFVlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:41:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751157AbWFFVlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:41:24 -0400
Date: Tue, 6 Jun 2006 17:45:53 -0400
From: Don Zickus <dzickus@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Message-ID: <20060606214553.GB11696@redhat.com>
References: <4480C102.3060400@goop.org> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <20060606141755.GN2839@redhat.com> <200606061618.15415.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606061618.15415.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 04:18:15PM +0200, Andi Kleen wrote:
> 
> > Because he is using a i386 machine, the nmi watchdog is disabled by
> > default. 
> 
> I changed that - it's now on by default on i386 too.
> 
> -Andi

I am trying to create a patch for this problem and it just dawned on me,
how does one store the previous state in a suspend/resume path if the code
hotplugs all the cpus first?  CPU0 is easy because an explicit
suspend/resume path is called, but it seems to be called last after all
the other cpus have been removed.  How do I save the state?

Is there a recommened way of doing this?  Or can I assume that
__cpu_disable/enable is only called by the suspend/resume subsystem?

Thanks.

Cheers,
Don

