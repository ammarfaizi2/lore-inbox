Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbULHCHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbULHCHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 21:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbULHCHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 21:07:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:56800 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262002AbULHCAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 21:00:50 -0500
Date: Tue, 7 Dec 2004 18:00:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: nickpiggin@yahoo.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041207180033.6699425b.akpm@osdl.org>
In-Reply-To: <20041208013732.GF16322@dualathlon.random>
References: <20041202130457.GC10458@suse.de>
	<20041202134801.GE10458@suse.de>
	<20041202114836.6b2e8d3f.akpm@osdl.org>
	<20041202195232.GA26695@suse.de>
	<20041208003736.GD16322@dualathlon.random>
	<1102467253.8095.10.camel@npiggin-nld.site>
	<20041208013732.GF16322@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> The desktop is ok with "as" simply because it's
>  normally optimal to stop writes completely

AS doesn't "stop writes completely".  With the current settings it
apportions about 1/3 of the disk's bandwidth to writes.

This thing Jens has found is for direct-io writes only.  It's a bug.

The other problem with AS is that it basically doesn't work at all with a
TCQ depth greater than four or so, and lots of people blindly look at
untuned SCSI benchmark results without realising that.  If a distro is
always selecting CFQ then they've probably gone and deoptimised all their
IDE users.  

AS needs another iteration of development to fix these things.  Right now
it's probably the case that we need CFQ or deadline for servers and AS for
desktops.   That's awkward.
