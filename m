Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751670AbVJTAwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbVJTAwX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 20:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751671AbVJTAwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 20:52:22 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:8337 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751669AbVJTAwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 20:52:22 -0400
Date: Thu, 20 Oct 2005 09:51:02 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc: Linus Torvalds <torvalds@osdl.org>,
       Alex Williamson <alex.williamson@hp.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       mulix@mulix.org, jdmason@us.ibm.com
In-Reply-To: <20051019225218.GA4684@localhost.localdomain>
References: <Pine.LNX.4.64.0510191343590.3369@g5.osdl.org> <20051019225218.GA4684@localhost.localdomain>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051020094011.9A42.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks a lot for your explanation!

> On Wed, Oct 19, 2005 at 01:45:21PM -0700, Linus Torvalds wrote:
> > ... 
> > Can you re-post the final version as such, with explanations for the 
> > commit messages and the sign-off, and people who have issues with it 
> > _please_ speak up asap?
> 
> The final version which works for everyone is from Yasunori Goto. 
> 
> His patch introduces a limit parameter to the core bootmem allocator;  This
> new parameter indicates that physical memory allocated by the bootmem allocator
> should be within the requested limit.  The patch also introduces
> alloc_bootmem_low_pages_limit(), alloc_bootmem_node_limit,
> alloc_bootmem_low_pages_node_limit apis, but alloc_bootmem_low_pages_limit()
> is the only api used for swiotlb.  IMO, instead of introducing xxx_limit apis,
> the existing alloc_bootmem_low_pages() api could instead be changed and made 
> to pass right limit to the core allocator.  But then that would make the 
> patch more intrusive for 2.6.14, as other  arches use alloc_bootmem_low_pages().

Yes. I worried a bit that I should replace all of the function or not.
But, its impact is too risky for 2.6.14. So, I wrote the patch to avoid
big impact as much as possible.

> (So maybe that can be done post 2.6.14 if Yasunori-san is OK with that)

Sure! 

-- 
Yasunori Goto 

