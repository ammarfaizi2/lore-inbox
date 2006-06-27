Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWF0GFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWF0GFi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 02:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWF0GFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 02:05:38 -0400
Received: from ns.suse.de ([195.135.220.2]:50409 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932104AbWF0GFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 02:05:37 -0400
Date: Mon, 26 Jun 2006 23:02:14 -0700
From: Greg KH <greg@kroah.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Van De Ven, Adriaan" <adriaan.van.de.ven@intel.com>,
       Rajesh Shah <rajesh.shah@intel.com>,
       Tigran Aivazian <tigran@veritas.com>
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
Message-ID: <20060627060214.GA27469@kroah.com>
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 10:51:33AM +0800, Shaohua Li wrote:
> This is the rewrite of microcode update driver. Changes:
> 1. trim the code
> 2. using request_firmware to pull ucode from userspace, so we don't need
> the application 'microcode_ctl' to assist. We name each ucode file
> according to CPU's info as intel-ucode/family-model-stepping. In this
> way we could split ucode file as small one. This has a lot of advantages
> such as selectively update and validate microcode for specific models,
> better manage microcode file, easily write tools for administerators and
> so on.
> 3. add sysfs support. Currently each CPU has two microcode related
> attributes. One is 'version' which shows current ucode version of CPU.
> Tools can use the attribute do validation or show CPU ucode status. The
> other is 'reload' which allows manually reloading ucode. 
> 4. add suspend/resume and CPU hotplug support. 

Why not break this up into 4 patches so we can better review them?

Remember, one patch per change please :)

> With the changes, we should put all intel-ucode/xx-xx-xx microcode files
> into the firmware dir (I had a tool to split previous big data file into
> small one and later we will release new style data file). The init
> script should be changed to just loading the driver without unloading
> for hotplug and suspend/resume (for back compatibility I keep old
> interface, so old init script also works).
> 
> Previous post is at
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114852925121064&w=2
> Changes against previous patch:
> 1. use sys_create_group to add attributes
> 2. add a fake platform_device for reqeust_firmware as Greg disliked the
> request_firmware_kobj interface previous patch introduced
> 3. add a new attribute 'pf' to help tools check if CPU has latest ucode

What does "pf" stand for?

thanks,

greg k-h
