Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVFPC7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVFPC7d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 22:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261709AbVFPC7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 22:59:33 -0400
Received: from fmr20.intel.com ([134.134.136.19]:38605 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261710AbVFPC7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 22:59:09 -0400
Date: Thu, 16 Jun 2005 10:54:14 +0800
From: "Wang, Zhenyu" <zhenyu.z.wang@intel.com>
To: Russ Anderson <rja@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RCF] Linux memory error handling
Message-ID: <20050616025414.GA14764@zhen-devel.sh.intel.com>
Mail-Followup-To: Russ Anderson <rja@sgi.com>, linux-kernel@vger.kernel.org
References: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005.06.15 09:30:13 +0000, Russ Anderson wrote:
> 		[RCF] Linux memory error handling.
> 
> Summary: One of the most common hardware failures in a computer 
> 	is a memory failure.   There has been efforts in various
> 	architectures to support recover from memory errors.  This
> 	is an attempt to define a common support infrastructure
> 	in Linux to support memory error handling.
> 
> Background:  There has been considerable work on recovering from
> 	Machine Check Aborts (MCAs) in arch/ia64.  One result is
> 	that many memory errors encountered by user applications
> 	not longer cause a kernel panic.  The application is 
> 	terminated, but linux and other applications keep running.
> 	Additional improvements are becoming dependent on mainline
> 	linux support.  That requires involvement of lkml, not
> 	just linux-ia64.

Good RFC! Actually on x86 arch, 'bluesmoke' - http://bluesmoke.sf.net - is out 
there for some simple mem ECC error handling already. It's inspired by the old linux-ecc 
project. Current capability is limited to detect, report, configuable for polling and UE
panic. 

Bluesmoke contains a driver core which is used to host infos for each mem 
controller, like dimm info, and currently only polling method is taken for registered 
controller. Others are all the specific chipset drivers, which is mostly platform depend, 
e.g e7520, 82875P, etc. Those platforms have also been tested, bluesmoke's webpage
contains some test method if you really want to try. 

nmi handling is still under work, Dave and Corey's patch is on sourceforge page, and

    http://lkml.org/lkml/2004/8/19/140
    http://lkml.org/lkml/2005/3/21/11

Those nmi callbacks have not been added to chipset driver yet, but some initial 
testing failed, still don't know why...

thanks
-zhen
