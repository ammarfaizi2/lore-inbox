Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753396AbWKCRSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbWKCRSw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753397AbWKCRSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:18:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:45529 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753396AbWKCRSv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:18:51 -0500
Date: Fri, 3 Nov 2006 12:17:57 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Amul Shah <amul.shah@unisys.com>, LKML <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: [RFC] [PATCH 2.6.19-rc4] kdump panics early in boot when  reserving MP Tables located in high memory
Message-ID: <20061103171757.GC9371@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1162506272.19677.33.camel@ustr-linux-shaha1.unisys.com> <200611030340.55952.ak@suse.de> <1162565722.19677.68.camel@ustr-linux-shaha1.unisys.com> <200611031751.04056.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611031751.04056.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 05:51:03PM +0100, Andi Kleen wrote:
> 
> [Finally dropping that annoying fastboot list from cc. Please never include any closed 
> mailing lists in l-k posts. Thanks]
> 
> >   That won't worked because in arch/86_64/kernel/e820.c, the exactmap
> > parsing clobbers end_pfn_map.
> 
> That's a bug imho. It shouldn't do that.
> 
> end_pfn_map should be always the highest address in e820 so that we 
> can access all firmware tables safely.
> 

Hi Andi,

end_pfn_map still contins the highest address in e820. The only difference
is that it is reset and recalculated based on new memory map passed
with the help of memmap= options. 

Actually with mempmap=exactmap, we are overriding the BIOS provided 
memory map with a User defined memory map so we reset the end_pfn_map
to zero and it will be calculated again based on new memory map passed
with the help of memmap= options.

So to access all the firmware tables safely, one has to make sure that
right memmap= options have been passed to the kernel.

That's why IMHO, the right way to fix this problem is not doing
some special condition checks in kernel, instead, passing the right
memmap= options. To do that kexec-tools has to know where the firmware
tables are and that's why location of MP tables should be exported to 
user space.

Thanks
Vivek
