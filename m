Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbTIQTJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbTIQTJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:09:16 -0400
Received: from ns.suse.de ([195.135.220.2]:21927 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262784AbTIQTI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:08:59 -0400
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: 2.4.23-pre4 compile failure in hw_random.c and aic7xxx on amd64
References: <1063823338.7731.9.camel@heat.suse.lists.linux.kernel>
	<1063823762.8912.3.camel@heat.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 17 Sep 2003 21:08:55 +0200
In-Reply-To: <1063823762.8912.3.camel@heat.suse.lists.linux.kernel>
Message-ID: <p73pthz2px4.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeffrey W. Baker" <jwbaker@acm.org> writes:

> On Wed, 2003-09-17 at 11:28, Jeffrey W. Baker wrote:
> > hw_random.c: In function `via_init':
> > hw_random.c:433: error: `MSR_VIA_RNG' undeclared (first use in this function)
> > hw_random.c:433: error: (Each undeclared identifier is reported only once
> > hw_random.c:433: error: for each function it appears in.)
> > hw_random.c: In function `via_cleanup':
> > hw_random.c:459: error: `MSR_VIA_RNG' undeclared (first use in this function)
> > 
> > The strange bit is that I didn't even have Intel/AMD/VIA hardware rng
> > configured, only AMD 768/8??? rng support.  So it seems like some sort
> > of bug in oldconfig.  After removing CONFIG_HW_RANDOM I can build again.
> > 
> > I also still have compile failures in drivers/scsi/aic7xxx due to
> > Werror.
> 
> Follow-up:
> 
> fs/fs.o(.text+0x23ed7): In function `interrupts_open':
> : undefined reference to `show_interrupts'
> 
> This appears to be defined on ppc64 and i386, but not x86_64.  Possibly
> #ifndef CONFIG_X86 confusion because x86_64 sets CONFIG_X86_64 and
> CONFIG_X86.  Not sure how to fix.

2.4 has gotten to the old habit again of breaking other architectures
faster than they can be fixed ;-/ It's already fixed in the x86-64.org CVS. 

I have a bigger patchkit that I plan to merge to Marcelo soon, but 
didn't have time to clean it up for him yet.

For a very raw patch (still some uglities etc.) you can 
use ftp://ftp.x86-64.org/pub/linux/v2.4/x86_64-2.4.23pre4-0.bz2
Also note that ext3 seems to be broken currently (at least since 2.4.22) 

-andi
