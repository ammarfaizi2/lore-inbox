Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262415AbULCROn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbULCROn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbULCROm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:14:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:16016 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262415AbULCRLf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:11:35 -0500
Date: Fri, 3 Dec 2004 09:11:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: P@draigBrady.com
Cc: ganesh.venkatesan@intel.com, xhejtman@mail.muni.cz, zaphodb@zaphods.net,
       marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-Id: <20041203091101.6479a0f0.akpm@osdl.org>
In-Reply-To: <41B046BA.1030703@draigBrady.com>
References: <20041109203348.GD8414@logos.cnet>
	<20041110212818.GC25410@mail.muni.cz>
	<20041110181148.GA12867@logos.cnet>
	<20041111214435.GB29112@mail.muni.cz>
	<4194A7F9.5080503@cyberone.com.au>
	<20041113144743.GL20754@zaphods.net>
	<20041116093311.GD11482@logos.cnet>
	<20041116170527.GA3525@mail.muni.cz>
	<20041121014350.GJ4999@zaphods.net>
	<20041121024226.GK4999@zaphods.net>
	<20041202195422.GA20771@mail.muni.cz>
	<20041202122546.59ff814f.akpm@osdl.org>
	<41B046BA.1030703@draigBrady.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com wrote:
>
> Andrew Morton wrote:
> > Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
> > 
> >>I found out that 2.6.6-bk4 kernel is OK. 
> > 
> > 
> > That kernel didn't have the TSO thing.  Pretty much all of these reports
> > have been against e1000_alloc_rx_buffers() since the TSO changes went in.
> 
> This possibly related patch went into 2.6 and it bugged me
> as Ganesh didn't address the reservations mentioned in the thread:
> http://oss.sgi.com/projects/netdev/archive/2004-07/msg00704.html
> 

The use of vmalloc() can cause consumption or fragmentation of the virtual
address space which is set aside for all vmalloc()s, but it will not cause
the particular problem which we're seeing here: exhaustion of the
interrupt-time page reserves.
