Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWDCRmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWDCRmS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 13:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWDCRmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 13:42:18 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24248 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964809AbWDCRmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 13:42:17 -0400
Date: Mon, 3 Apr 2006 10:42:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       ak@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
In-Reply-To: <20060403141027.GB25663@localdomain>
Message-ID: <Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
 <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
 <20060402221513.96f05bdc.pj@sgi.com> <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
 <20060403141027.GB25663@localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 3 Apr 2006, Nathan Lynch wrote:

> In this case, disabling preempt around the for_each_online_cpu loop
> would prevent any cpu from going down in the meantime.  But since this
> function doesn't look like it's a hot path, and we're potentially
> traversing lots of zones and cpus, lock_cpu_hotplug might be preferable.
> 
> As Paul noted, the fix as it stands isn't adequate.

There are many other for_each_*_cpu loops in the kernel that do not have 
any of the instrumentation you suggest. I suggest you come up with a 
general solution and then go through all of them and fix this. Please be 
aware that many of these loops are performance critical.
