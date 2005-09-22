Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbVIVNiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbVIVNiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbVIVNiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:38:15 -0400
Received: from colin.muc.de ([193.149.48.1]:34569 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1030335AbVIVNiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:38:15 -0400
Date: 22 Sep 2005 15:38:09 +0200
Date: Thu, 22 Sep 2005 15:38:09 +0200
From: Andi Kleen <ak@muc.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Zachary Amsden <zach@vmware.com>, Linus Torvalds <torvalds@osdl.org>,
       Jeffrey Sheldon <jeffshel@vmware.com>, Ole Agesen <agesen@vmware.com>,
       Shai Fultheim <shai@scalex86.org>, Andrew Morton <akpm@odsl.org>,
       Jack Lo <jlo@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] Gdt page isolation
Message-ID: <20050922133809.GA99035@muc.de>
References: <200509220749.j8M7nINV001001@zach-dev.vmware.com> <20050922131714.GA97170@muc.de> <20050922133402.GA19011@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922133402.GA19011@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:34:02PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@muc.de> wrote:
> 
> > >  	 * This grunge runs the startup process for
> > >  	 * the targeted processor.
> > >  	 */
> > > +	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
> > 
> > I can see why don't check it for NULL, but it's a ugly reason and 
> > would be better fixed. It at least needs a comment.
> 
> it's so early in the bootup that any failure here would probably be 
> fatal anyway. But yeah, a comment would be nice.

Not true for AP boot, especially with CPU hotplug.
And CPU hotplug will be common because suspend/resume use it
and next years laptops will have dual core CPUs.
So it would be nicer to handle it. But getting out of that 
path is difficult.


> > -Andi (who would still prefer just going back to the array in head.S - 
> > would work as well and waste less memory)
> 
> that doesnt really solve the problem for e.g. Xen, which needs a 
> separate page for each GDT. (xenolinux is a separate arch right now, but 
> it will/should be merged back into its base architectures) So why not 
> solve all the problems at once?

Xen could use the same method vmware uses that handles having other
read only data in there too? Doesn't sound too bad.

-Andi
