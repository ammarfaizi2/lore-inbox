Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUIJPNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUIJPNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 11:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUIJPNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:13:42 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:50851 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267413AbUIJPNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:13:40 -0400
Message-ID: <4141C49E.3070509@nortelnetworks.com>
Date: Fri, 10 Sep 2004 09:13:34 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: having problems with remap_page_range() and virt_to_phys()
References: <Pine.LNX.4.44.0409101501530.16728-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0409101501530.16728-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 9 Sep 2004, Chris Friesen wrote:

> You will need to SetPageReserved(pg) for remap_page_range to map it.
> And no, remembering your earlier pleas, the MM system doesn't clean
> up for you, you'll need to ClearPageReserved and free the page when
> it's all done with (if ever).

Right.  I actually did call SetPageReserved(pg), I just forgot to include it in 
the code snippet--my test machine is on the other side of the country and I 
managed to hose it nicely last night.

> virt_to_phys applies to the kernel virtual address (what you name "virt"
> above), it won't work on a user virtual address, that's something else.

Aha.  That may be part of my problem, at least on the verification side.

> But there are plenty
> of examples of using remap_page_range in the kernel source tree, maybe
> not all of them quite correct, but I'd have thought you could work out
> what you need from those examples.

So did I...the code finishes without errors, but the assembly language part 
doesn't work properly.  (And it does work with another method of getting memory, 
but that method breaks as soon as you go highmem...)

Chris
