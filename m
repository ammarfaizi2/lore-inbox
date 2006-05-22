Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWEVSie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWEVSie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 14:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbWEVSie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 14:38:34 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:47761 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751006AbWEVSid
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 14:38:33 -0400
Date: Tue, 23 May 2006 00:04:00 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Andrew Morton <akpm@osdl.org>, Martin Peschke <mp3@de.ibm.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: netlink vs. debugfs (was Re: [Patch 0/6] statistics infrastructure)
Message-ID: <20060522183359.GA26551@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <1148054876.2974.10.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060519092411.6b859b51.akpm@osdl.org> <4471FE52.8090107@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4471FE52.8090107@am.sony.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2006 at 11:09:22AM -0700, Tim Bird wrote:
> Andrew Morton wrote:
> > Martin Peschke <mp3@de.ibm.com> wrote:
> >> My patch series is a proposal for a generic implementation of statistics.
> > 
> > This uses debugfs for the user interface, but the
> > per-task-delay-accounting-*.patch series from Balbir creates an extensible
> > netlink-based system for passing instrumentation results back to userspace.
> > 
> > Can this code be converted to use those netlink interfaces, or is Balbir's
> > approach unsuitable, or hasn't it even been considered, or what?
> 
> Can someone give me the 20-second elevator pitch on why
> netlink is preferred over debugfs?  I've heard of a
> number of debugfs/procfs users requested to switch over.
> 
> Thanks,
>  -- Tim
> 
> =============================
> Tim Bird
> Architecture Group Chair, CE Linux Forum
> Senior Staff Engineer, Sony Electronics
> =============================

Hi, Tim,

I am no debugfs expert, I hope I can do justice to the comparison.

Debugfs						Netlink/Genetlink

1. Filesystem based - requires creating		Several types of data can
   files for each type of data passed		be multiplexed over one netlink
   down						socket.
2. Hard to determine record format/data		Contains metadata including
						type of data and length
						with each record
3. Notifications are hard			Notifications are very easy
   I think they can be done using inotify	good library support for
						notifications. Data can
						either be broadcast or
						selectively mulitcast
4. Requires several open/read/write/close	A single socket can be
   operations					opened, data from kernel
						space can be multiplexed
						over it.

I don't think I did any justice to the advantages of debugfs. The only
one I can think of is that it uses relayfs. Relayfs is efficient in the
sense that it uses per-cpu buffers.

Anybody else want to take a shot in comparing the two?

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
