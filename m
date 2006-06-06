Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWFFQqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWFFQqy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWFFQqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 12:46:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14997 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750896AbWFFQqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 12:46:53 -0400
Date: Tue, 6 Jun 2006 12:51:27 -0400
From: Don Zickus <dzickus@redhat.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Shaohua Li <shaohua.li@intel.com>, Miles Lane <miles.lane@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in	arch/i386/kernel/nmi.c:174
Message-ID: <20060606165127.GP2839@redhat.com>
References: <4480C102.3060400@goop.org> <4483DF32.4090608@goop.org> <20060605004823.566b266c.akpm@osdl.org> <a44ae5cd0606050135w66c2abeu698394b4268e4790@mail.gmail.com> <1149576246.32046.166.camel@sli10-desk.sh.intel.com> <4485AC1F.9050001@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4485AC1F.9050001@goop.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2006 at 09:23:59AM -0700, Jeremy Fitzhardinge wrote:
> Shaohua Li wrote:
> >Does below patch help? The nmi suspend/resume doesn't look good to me.
> >Only CPU0 uses the suspend/resume code path. Other CPUs run the CPU
> >hotplug code path.
> >  
> Unfortunately this just oopses immediately on the first suspend.  The 
> stack trace is unclear (and I'm just going from memory at the moment), 
> but it looked like it got an invalid op.  I'll try to get a clearer idea 
> of the crash later today.
> 
>    J

No this makes sense.  The code right now just blindly tries to disable the
watchdog without checking to see that it is already disabled.  The oops
you are seeing is a result of that.  I'll have a patch to fix all that a
little later.

Cheers,
Don

