Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbWEODD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbWEODD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 23:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWEODD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 23:03:58 -0400
Received: from mga06.intel.com ([134.134.136.21]:43676 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751321AbWEODD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 23:03:58 -0400
TrustInternalSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.05,127,1146466800"; 
   d="scan'208"; a="36168376:sNHT298689146"
Date: Sun, 14 May 2006 20:03:01 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] i386/x86-64 Add nmi watchdog support for new Intel CPUs
Message-ID: <20060514200301.A16957@unix-os.sc.intel.com>
References: <20060514185023.A16695@unix-os.sc.intel.com> <20060514191101.45982cc0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060514191101.45982cc0.akpm@osdl.org>; from akpm@osdl.org on Sun, May 14, 2006 at 07:11:01PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2006 at 07:11:01PM -0700, Andrew Morton wrote:
> Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
> >
> > --- linux-2.6.17-rc4/arch/i386/kernel/nmi.c	2006-05-11 17:23:13.000000000 -0700
> >  +++ linux-2.6.17-rc4-nmi/arch/i386/kernel/nmi.c	2006-05-12 17:47:48.000000000 -0700
> >   
> > ...
> >
> >  +static void disable_intel_arch_watchdog(void)
> 
> Should this code be moved to arch/i386/kernel/cpu/intel.c?

I am not sure. The other watchdog setup functions p3, p4, k7 are all
in nmi.c file and thats the reason I kept the new function in the same file too.
Also, as this is specific to watchdog event, it won't be called by anyone else.

If you are thinking of putting these disable and enable functions in same place so
that we can share it across i386/x86_64, we can put it in intel_cacheinfo or create
a new file for this. There is one line difference between i386 and x86_64 enable
functions due to a macro getting used in i386 version. So, we will have to workaround 
that to make this code shared.

Thanks,
Venki
