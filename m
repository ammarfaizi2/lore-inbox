Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261913AbVEWQzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbVEWQzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 12:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbVEWQzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 12:55:50 -0400
Received: from fmr23.intel.com ([143.183.121.15]:31650 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261913AbVEWQzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 12:55:40 -0400
Date: Mon, 23 May 2005 09:54:51 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, zwane@arm.linux.org.uk,
       discuss@x86-64.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [patch 0/4] CPU hot-plug support for x86_64
Message-ID: <20050523095450.A8193@unix-os.sc.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com> <20050523164046.GB39821@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050523164046.GB39821@muc.de>; from ak@muc.de on Mon, May 23, 2005 at 06:40:46PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2005 at 06:40:46PM +0200, Andi Kleen wrote:
> On Fri, May 20, 2005 at 03:16:22PM -0700, Ashok Raj wrote:
> > Andi: You had mentioned that you would not prefer to replace the broadcast IPI
> >       with the mask version for performance. Currently this seems to be the
> > 	  most optimal way without putting a sledge hammer on the cpu_up process.
> 
> I already put a sledgehammer to __cpu_up with that last

Yours was a good sledge hammer :-) the way it should have been done
but carried legacy boot from i386 that wasnt pretty. The one iam referring
to is pretty darn slow, and think it wont be liked my many to slow down the
system just to add a new cpu.

> patch. Some more hammering surely wouldnt be a big issue. Unlike i386
> we actually still have a chance to test all relevant platforms, so I 
> dont think it is a big issue.
> 
> What changes did you plan?

The only other workable alternate would be to use the stop_machine() 
like thing which we use to automically update cpu_online_map. This means we 
execute a high priority thread on all cpus, bringing the system to knees before
just adding a new cpu. On very large systems this will definitly be 
visible.

Just curious, what performance impact did you allude to that would be lost
if we dont use the shortcut IPI version?

> 
> P.S.: An alternative would be to define a new genapic subarch that
> you only enable when you detect cpuhotplug support at boot.
> 

There is nothing currently there to find out if something is hotplug
capable in a generic way at platform level, other than adding cmdline options 
etc.  

Also FYI: ACPI folks are experimenting using CPU hotplug to suspend/resume
support. So hotplug support may be required not just on platforms that support
it but also for other related uses.

Cheers,
Ashok Raj
- Open Source Technology Center
