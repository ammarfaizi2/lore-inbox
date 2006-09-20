Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751852AbWITQoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751852AbWITQoM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWITQoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:44:11 -0400
Received: from mx1.suse.de ([195.135.220.2]:3026 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751852AbWITQoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:44:10 -0400
Date: Wed, 20 Sep 2006 18:44:04 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: Rohit Seth <rohitseth@google.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org,
       pj@sgi.com, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
Message-ID: <20060920164404.GA22913@wotan.suse.de>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2006 at 09:25:03AM -0700, Christoph Lameter wrote:
> On Tue, 19 Sep 2006, Rohit Seth wrote:
> 
> > For example, a user can run a batch job like backup inside containers.
> > This job if run unconstrained could step over most of the memory present
> > in system thus impacting other workloads running on the system at that
> > time.  But when the same job is run inside containers then the backup
> > job is run within container limits.
> 
> I just saw this for the first time since linux-mm was not cced. We have 
> discussed a similar mechanism on linux-mm.
> 
> We already have such a functionality in the kernel its called a cpuset. A 
> container could be created simply by creating a fake node that then 
> allows constraining applications to this node. We already track the 
> types of pages per node. The statistics you want are already existing. 
> See /proc/zoneinfo and /sys/devices/system/node/node*/*.
> 
> > We use the term container to indicate a structure against which we track
> > and charge utilization of system resources like memory, tasks etc for a
> > workload. Containers will allow system admins to customize the
> > underlying platform for different applications based on their
> > performance and HW resource utilization needs.  Containers contain
> > enough infrastructure to allow optimal resource utilization without
> > bogging down rest of the kernel.  A system admin should be able to
> > create, manage and free containers easily.
> 
> Right thats what cpusets do and it has been working fine for years. Maybe 
> Paul can help you if you find anything missing in the existing means to 
> control resources.

What I like about Rohit's patches is the page tracking stuff which 
seems quite simple but capable.

I suspect cpusets don't quite provide enough features for non-exclusive 
use of memory (eg. page tracking for directed reclaim).
