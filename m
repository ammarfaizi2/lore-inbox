Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbULBXak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbULBXak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbULBXak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:30:40 -0500
Received: from ozlabs.org ([203.10.76.45]:54245 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261802AbULBXae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:30:34 -0500
Date: Fri, 3 Dec 2004 10:28:03 +1100
From: Anton Blanchard <anton@samba.org>
To: john stultz <johnstul@us.ibm.com>
Cc: David Vrabel <dvrabel@arcom.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mann@vmware.com
Subject: Re: Jiffy based timers/timeouts can expire too soon.
Message-ID: <20041202232803.GA6387@krispykreme.ozlabs.ibm.com>
References: <41AF3D50.4090707@arcom.com> <1102013246.13294.19.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102013246.13294.19.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Well, hopefully the lost tick detection code won't over compensate, so
> it shouldn't be an issue. However, as Tim Mann pointed out it, due to
> interrupt delay and queuing, it is seen on virtualized systems.

We saw this on ppc64 on earlier 2.6 kernels. There were some bugs with
the VM where interrupts would get disabled for a long time (we saw 20+
second periods). A SCSI timeout would occur on another CPU and at that
time irqs would get reenabled and 20 seconds of time would get replayed.

A bunch of timers would go off early and the SCSI adapter would explode.

Anton
