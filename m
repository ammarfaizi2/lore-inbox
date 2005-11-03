Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbVKCGk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVKCGk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 01:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKCGk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 01:40:29 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:43713 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751135AbVKCGk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 01:40:28 -0500
Message-ID: <4369B051.7050303@colorfullife.com>
Date: Thu, 03 Nov 2005 07:38:09 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Dipankar Sarma <dipankar@in.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: bad page state under possibly oom situation
References: <20051102143502.GE6137@in.ibm.com> <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.61.0511021614110.10299@goblin.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:

>(I don't know that it makes any difference, but was this particular report
>from 2.6.9-rc2 or from 2.6.14 or from something else?  In both 2.6.9 and
>2.6.14, flags 0x90 mean PG_slab|PG_dirty.)
>
>  
>
A very odd combination:
- free_pages_check() ensures that neither PG_slab nor PG_dirty are set
- prep_new_page() complains that both PG_slab and PG_dirty are set
- AFAICS slab doesn't set PG_dirty, and noone except slab set PG_slab.

I don't understand how two wrong bits can end up in page->flags.
Dipankar, could you modify bad_page() and hexdump +-128 bytes? Perhaps 
someone overwrites random memory. Or change the value of PG_slab to 20 
and check if page->flags remains 0x90.

--
    Manfred
