Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750863AbWH2GTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863AbWH2GTd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 02:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWH2GTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 02:19:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7302 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750863AbWH2GTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 02:19:32 -0400
Date: Mon, 28 Aug 2006 23:19:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: nathanl@austin.ibm.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       ntl@pobox.com, y-goto@jp.fujitsu.com, Anton Blanchard <anton@samba.org>,
       Dave Hansen <haveblue@us.ibm.com>, kamezawa.hiroyu@jp.fujitsu.com
Subject: Re: [PATCH] cpuset: hotunplug cpus and mems in all cpusets
Message-Id: <20060828231917.6f4bb9af.akpm@osdl.org>
In-Reply-To: <20060829060824.6621.28300.sendpatchset@jackhammer.engr.sgi.com>
References: <20060829060824.6621.28300.sendpatchset@jackhammer.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2006 23:08:24 -0700
Paul Jackson <pj@sgi.com> wrote:

> The cpuset code handling hot unplug of CPUs or Memory Nodes
> was incorrect - it could remove a CPU or Node from the top
> cpuset, while leaving it still in some child cpusets.
> 
> One basic rule of cpusets is that each cpusets cpus and mems
> are subsets of its parents.  The cpuset hot unplug code
> violated this rule.
> 
> So the cpuset hotunplug handler must walk down the tree,
> removing any removed CPU or Node from all cpusets.
> 
> However, it is not allowed to make a cpusets cpus or mems
> become empty.  They can only transition from empty to non-empty,
> not back.
> 
> So if the last CPU or Node would be removed from a cpuset by
> the above walk, we scan back up the cpuset hierarchy, finding
> the nearest ancestor that still has something online, and copy
> its CPU or Memory placement.

Did you consider failing the hotremove request instead?
