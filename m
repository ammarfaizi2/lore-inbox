Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWEWOyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWEWOyE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWEWOyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:54:04 -0400
Received: from mga05.intel.com ([192.55.52.89]:27441 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932227AbWEWOyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:54:03 -0400
X-IronPort-AV: i="4.05,161,1146466800"; 
   d="scan'208"; a="41269852:sNHT245312599"
Date: Tue, 23 May 2006 07:52:03 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: LKML <linux-kernel@vger.kernel.org>, y-goto@jp.fujitsu.com,
       ktokunag@redhat.com, ashok.raj@intel.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] node hotplug : register_cpu() changes [0/3]
Message-ID: <20060523075202.A24516@unix-os.sc.intel.com>
References: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060523195636.693e00d6.kamezawa.hiroyu@jp.fujitsu.com>; from kamezawa.hiroyu@jp.fujitsu.com on Tue, May 23, 2006 at 07:56:36PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2006 at 07:56:36PM +0900, KAMEZAWA Hiroyuki wrote:
> I found acpi container, which describes node, could evaluate cpu before
> memory. This means cpu-hot-add occurs before memory hot add.
> 

Is it possible to process memory before cpu in container hot-add code?

> In most part, cpu-hot-add doesn't depend on node hot add.
> But register_cpu, which creates symbolic link from node to cpu, requires

Dont you need all per-cpu allocated on that node? Or is it from node0 or 
something for all hotpluggable cpus?

If node is online first, then all allocations come from that node, thought you
*want* to ensure node/mem is online before cpu is up to get that benefit.

> that node should be onlined before register_cpu().
> When a node is onlined, its pgdat should be there.
