Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWEXOxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWEXOxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWEXOxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 10:53:36 -0400
Received: from mga06.intel.com ([134.134.136.21]:46216 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932123AbWEXOxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 10:53:36 -0400
X-IronPort-AV: i="4.05,167,1146466800"; 
   d="scan'208"; a="40724790:sNHT97369202"
Date: Wed, 24 May 2006 07:51:28 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       y-goto@jp.fujitsu.com, ktokunag@redhat.com, akpm@osdl.org
Subject: Re: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-ID: <20060524075128.A32074@unix-os.sc.intel.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com> <20060523075202.A24516@unix-os.sc.intel.com> <20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060524091816.5a3960b9.kamezawa.hiroyu@jp.fujitsu.com>; from kamezawa.hiroyu@jp.fujitsu.com on Wed, May 24, 2006 at 09:18:15AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 09:18:15AM +0900, KAMEZAWA Hiroyuki wrote:
> On Tue, 23 May 2006 07:52:03 -0700
> Ashok Raj <ashok.raj@intel.com> wrote:
> 
> > On Tue, May 23, 2006 at 07:56:36PM +0900, KAMEZAWA Hiroyuki wrote:
> > > I found acpi container, which describes node, could evaluate cpu before
> > > memory. This means cpu-hot-add occurs before memory hot add.
> > > 
> > 
> > Is it possible to process memory before cpu in container hot-add code?
> > 
> 
> Maybe No. I know ACPI people doesn't want to add special handling for cpu/memory
> in a container. It complicates the code very much.

Iam not attached to the API change, so disassociating the node from cpu is ok.
It just feels a bit weird to say node is not online. 

Probably ACPI doesnt give a precise way to put the dependencies (in a certain
order), there are EDL/EJD, but they have limitations and not directly imply
a dependency like this. But container code having to deal with this dependency
for add/remove is probably ok. 

i hope container would eventually perform onlining the pieces from user space
scripts via udev like mechanisms.

I remember folks from SGI posting patches to cpu only nodes in the past. 
Same way there are probably IO only nodes. Are you sure we cover these cases 
as well.
> 
> > > In most part, cpu-hot-add doesn't depend on node hot add.
> > > But register_cpu, which creates symbolic link from node to cpu, requires
> > 
> > Dont you need all per-cpu allocated on that node? Or is it from node0 or 
> > something for all hotpluggable cpus?
> > 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
