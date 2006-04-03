Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDCOK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDCOK6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 10:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbWDCOK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 10:10:57 -0400
Received: from rune.pobox.com ([208.210.124.79]:31382 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751233AbWDCOK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 10:10:56 -0400
Date: Mon, 3 Apr 2006 09:10:28 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       ak@suse.com, linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-ID: <20060403141027.GB25663@localdomain>
References: <20060402213216.2e61b74e.akpm@osdl.org> <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com> <20060402221513.96f05bdc.pj@sgi.com> <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Sun, 2 Apr 2006, Paul Jackson wrote:
> 
> > -		for (cpu = 0; cpu < NR_CPUS; cpu++) {
> > +		for_each_online_cpu(cpu) {
> > 
> > Idle curiosity -- what keeps a cpu from going offline during
> > this scan, and leaving us with the same crash as before?
> 
> Nothing keeps a processor from going offline. We could take the hotplug 
> lock for every for_each_online_cpu() in the kernel.

In this case, disabling preempt around the for_each_online_cpu loop
would prevent any cpu from going down in the meantime.  But since this
function doesn't look like it's a hot path, and we're potentially
traversing lots of zones and cpus, lock_cpu_hotplug might be preferable.

As Paul noted, the fix as it stands isn't adequate.
