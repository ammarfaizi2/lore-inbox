Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbWF0R2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbWF0R2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWF0R2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:28:17 -0400
Received: from xenotime.net ([66.160.160.81]:52369 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932496AbWF0R2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:28:16 -0400
Date: Tue, 27 Jun 2006 10:30:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Shaohua Li <shaohua.li@intel.com>
Cc: greg@kroah.com, arjan@linux.intel.com, linux-kernel@vger.kernel.org,
       akpm@osdl.org, rajesh.shah@intel.com, tigran@veritas.com
Subject: Re: [PATCH]microcode update driver rewrite - takes 2
Message-Id: <20060627103055.13a90b27.rdunlap@xenotime.net>
In-Reply-To: <1151396109.21189.77.camel@sli10-desk.sh.intel.com>
References: <1151376693.21189.52.camel@sli10-desk.sh.intel.com>
	<20060627060214.GA27469@kroah.com>
	<1151396109.21189.77.camel@sli10-desk.sh.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 16:15:09 +0800 Shaohua Li wrote:

> On Mon, 2006-06-26 at 23:02 -0700, Greg KH wrote:
> > On Tue, Jun 27, 2006 at 10:51:33AM +0800, Shaohua Li wrote:
> > > This is the rewrite of microcode update driver. Changes:
> > > 1. trim the code
> > > 2. using request_firmware to pull ucode from userspace, so we don't need
> > > the application 'microcode_ctl' to assist. We name each ucode file
> > > according to CPU's info as intel-ucode/family-model-stepping. In this
> > > way we could split ucode file as small one. This has a lot of advantages
> > > such as selectively update and validate microcode for specific models,
> > > better manage microcode file, easily write tools for administerators and
> > > so on.
> > > 3. add sysfs support. Currently each CPU has two microcode related
> > > attributes. One is 'version' which shows current ucode version of CPU.
> > > Tools can use the attribute do validation or show CPU ucode status. The
> > > other is 'reload' which allows manually reloading ucode. 
> > > 4. add suspend/resume and CPU hotplug support. 
> > 
> > Why not break this up into 4 patches so we can better review them?
> > 
> > Remember, one patch per change please :)
> > 
> > > With the changes, we should put all intel-ucode/xx-xx-xx microcode files
> > > into the firmware dir (I had a tool to split previous big data file into
> > > small one and later we will release new style data file). The init
> > > script should be changed to just loading the driver without unloading
> > > for hotplug and suspend/resume (for back compatibility I keep old
> > > interface, so old init script also works).
> > > 
> > > Previous post is at
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=114852925121064&w=2
> > > Changes against previous patch:
> > > 1. use sys_create_group to add attributes
> > > 2. add a fake platform_device for reqeust_firmware as Greg disliked the
> > > request_firmware_kobj interface previous patch introduced
> > > 3. add a new attribute 'pf' to help tools check if CPU has latest ucode
> > 
> > What does "pf" stand for?
> [PATCH 3/3] suspend/resume & hotplug support for microcode driver

meta-comment: that line would have made a good Subject: line.

See "2: Subject:" from
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

---
~Randy
