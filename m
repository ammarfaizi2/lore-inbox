Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUJNLaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUJNLaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 07:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUJNLaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 07:30:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5799 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261474AbUJNL3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 07:29:49 -0400
Date: Thu, 14 Oct 2004 06:29:38 -0500
From: Robin Holt <holt@sgi.com>
To: Itsuro Oda <oda@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@osdl.org
Subject: Re: Yet another crash dump tool
Message-ID: <20041014112938.GE19122@lnx-holt.americas.sgi.com>
References: <20041014074718.26E6.ODA@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041014074718.26E6.ODA@valinux.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2004 at 08:05:41AM +0900, Itsuro Oda wrote:
> Hello,
> 
> We released a crash dump tool called "mini kernel dump".
> 
> Please see the following URL to get the motivation and the
> overview of the mini kernel dump.
> http://mkdump.sourceforge.net/
> 
> http://sourceforge.net/projects/mkdump/ 

I am not sure why this is such a huge improvement.  The one
concern I have is you blindly are copying all of memory to the
dump device.  Can you dump device span multiple volumes?  If I
have a system using 1TB of physical memory, but 98% of that
is allocated as huge TLB pages for users, do I _REALLY_ need to
dump them all?

lkcd, and I would hope others, only dump kernel pages unless
configured to do otherwise.  More importantly lkcd can
eliminate page cache and buffer cache pages.  Those types of
pages are seldom relevant to figuring out what actually went
wrong.

Realistically, if the basic structures telling you whether pages
are used by the kernel or not are so messed up you can not use
them for dumping, they have probably been allocated to multiple
users and will be riddled with inconsistent information.

Robin Holt
