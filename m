Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262673AbVCWBN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbVCWBN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 20:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVCWBN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 20:13:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5038 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262673AbVCWBNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 20:13:22 -0500
Date: Tue, 22 Mar 2005 20:13:15 -0500
From: Dave Jones <davej@redhat.com>
To: Lee Revell <rlrevell@joe-job.com>, akpm@osdl.org
Cc: Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050323011313.GL15879@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Lee Revell <rlrevell@joe-job.com>, akpm@osdl.org,
	Diego Calleja <diegocg@gmail.com>, linux-kernel@vger.kernel.org
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com> <1111539217.4691.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111539217.4691.57.camel@mindpipe>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2005 at 07:53:37PM -0500, Lee Revell wrote:

 > The solution is fairly well known.  Rather than treating the zillions of
 > disk seeks during the boot process as random unconnected events, you
 > analyze the I/O done during the boot process, then lay out those disk
 > blocks optimally based on this information so on the next boot you just
 > do one big streaming read.  The patent side has been discussed and there
 > seems to be plenty of prior art.
 > 
 > Someone needs to just do it.  All the required information is right
 > there.

Some of the folks on our desktop team have been doing a bunch of experiments
at getting boot times down, including laying out the blocks in a more
optimal manner, allowing /sbin/readahead to slurp the data off the disk
in one big chunk, and run almost entirely from cache. The results are
quite impressive, though the absense of any kind of tool to reorganise
the layout means that once a few packages are installed/removed, the layout is
no longer optimal.

This old mail: http://marc.free.net.ph/message/20040304.030616.59761bf3.html
references a 'move block' ioctl, which is probably the hardest part of the problem,
though I didn't find the code referenced in that mail. Andrew ?

With something like this, and some additional bookkeeping to keep track of
which files we open in the first few minutes of uptime, we could periodically
reorganise the layout back to an optimal state.

		Dave

