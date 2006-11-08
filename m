Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753025AbWKHEX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025AbWKHEX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 23:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbWKHEX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 23:23:58 -0500
Received: from mga05.intel.com ([192.55.52.89]:12712 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1752978AbWKHEX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 23:23:57 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,399,1157353200"; 
   d="scan'208"; a="13040377:sNHT20246544"
Date: Tue, 7 Nov 2006 20:01:34 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, ak@suse.de,
       shaohua.li@intel.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       ashok.raj@intel.com
Subject: Re: [patch 2/4] introduce the mechanism of disabling cpu hotplug control
Message-ID: <20061107200133.A5933@unix-os.sc.intel.com>
References: <20061107173306.C3262@unix-os.sc.intel.com> <20061107173624.A5401@unix-os.sc.intel.com> <20061107174024.B5401@unix-os.sc.intel.com> <20061107195430.37f8deb0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061107195430.37f8deb0.akpm@osdl.org>; from akpm@osdl.org on Tue, Nov 07, 2006 at 07:54:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2006 at 07:54:30PM -0800, Andrew Morton wrote:
> On Tue, 7 Nov 2006 17:40:25 -0800
> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
> 
> > Add 'cpu_hotplug_no_control' and when set, the hotplug control file("online")
> > will not be added under /sys/devices/system/cpu/cpuX/
> > 
> > Next patch doing PCI quirks will use this.
> > 
> 
> I don't understand what this (ugly) patch has to do with the overall
> bugfix.  We're fixing the APCI initialisation - what does that have to do
> with presenting cpu-hotplug files in sysfs?

This patch is adding a mechanism which will not export the cpu hotplug control
file.  And the quirk will use this from preventing the users doing cpu hotplug.
On these platforms, we need to have atleast 2 cpus online to workaround the
errata.

In future we can use this mechanism to disable cpu hotplug during bootup.

> But does this variable _have_ to be a negative like this?  The code would
> be simpler if it had the opposite sense and was called, say,
> cpu_hotplug_enable_control_file.

I wanted to add something like disable_cpu_hotplug.. but suspend code
seems to be already using.. Will clean this up.

> Are these patches considered 2.6.19 material?  They look a bit big, ugly
> and scary for that.

Though no one reported failures so far, it would be good to get included
in 2.6.19. If it is too late and sounds scary, we can consider in -stable
after spending sometime in -mm..

thanks,
suresh
