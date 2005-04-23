Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVDWCdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVDWCdE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 22:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDWCdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 22:33:04 -0400
Received: from fmr24.intel.com ([143.183.121.16]:43474 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261444AbVDWCdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 22:33:00 -0400
Date: Fri, 22 Apr 2005 19:32:50 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rohit Seth <rohit.seth@intel.com>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Increase number of e820 entries hard limit from 32 to 128
Message-ID: <20050422193250.A18512@unix-os.sc.intel.com>
References: <20050422181441.A18205@unix-os.sc.intel.com> <Pine.LNX.4.58.0504221851140.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0504221851140.2344@ppc970.osdl.org>; from torvalds@osdl.org on Fri, Apr 22, 2005 at 06:51:59PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2005 at 06:51:59PM -0700, Linus Torvalds wrote:
> On Fri, 22 Apr 2005, Venkatesh Pallipadi wrote:
> > The specifications that talk about E820 map doesn't have an upper limit
> > on the number of E820 entries. But, today's kernel has a hard limit of 32.
> > With increase in memory size, we are seeing the number of E820 entries
> > reaching close to 32. Patch below bumps the number upto 128. 
> 
> Hmm. Anything that changes setup.S tends to have bootloader dependencies. 
> I worry whether this one does too..
> 

The setup.S change in this patch should be OK. As it is adding to the 
existing zero-page and keeping it within one page. I tested it on systems 
with grub, adding some dummy E820 entries and it worked fine.

However, there is another place that needs to be changed. Boot loaders
also calls E820 while booting directly with vmlinux (instead of usual 
bzImage - which is handled by this patch) and that needs to change to 
incorporate more E820 entries. But, there we may need more changes, to 
the boot protocol version and the like. On a side note, looking at the 
grub source, it seems to have a limit of 50 entries today, which doesn't 
agree with current 32 entry limit in the kernel. Not sure why grub has 
this different limit though.

Thanks,
Venki 
