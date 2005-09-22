Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbVIVNdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbVIVNdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVIVNdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:33:21 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:63148 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030340AbVIVNdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:33:20 -0400
Date: Thu, 22 Sep 2005 15:34:02 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@muc.de>
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
Message-ID: <20050922133402.GA19011@elte.hu>
References: <200509220749.j8M7nINV001001@zach-dev.vmware.com> <20050922131714.GA97170@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922131714.GA97170@muc.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@muc.de> wrote:

> >  	 * This grunge runs the startup process for
> >  	 * the targeted processor.
> >  	 */
> > +	cpu_gdt_descr[cpu].address = __get_free_page(GFP_KERNEL|__GFP_ZERO);
> 
> I can see why don't check it for NULL, but it's a ugly reason and 
> would be better fixed. It at least needs a comment.

it's so early in the bootup that any failure here would probably be 
fatal anyway. But yeah, a comment would be nice.

> -Andi (who would still prefer just going back to the array in head.S - 
> would work as well and waste less memory)

that doesnt really solve the problem for e.g. Xen, which needs a 
separate page for each GDT. (xenolinux is a separate arch right now, but 
it will/should be merged back into its base architectures) So why not 
solve all the problems at once?

	Ingo
