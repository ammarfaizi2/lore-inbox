Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbTIDRZF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbTIDRZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:25:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:36789 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265315AbTIDRY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:24:59 -0400
Date: Thu, 4 Sep 2003 10:24:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
In-Reply-To: <3F5772B2.402@pobox.com>
Message-ID: <Pine.LNX.4.44.0309041017060.6676-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 4 Sep 2003, Jeff Garzik wrote:
> 
> Would still be nice to have a sysdata or struct device pointer in struct 
> resource, then.  I'm not a fan of wacky 
> bus-info-encoded-in-another-number schemes.

But it _isn't_ "bus info".

It's a unique number. It has no bus information embedded in it. It's a 
number that tells ioremap() what area to remap.

It's a "hardware dependent iomem address". What the address _means_ is 
entirely up to the architecture, and depends on how devices are acccessed, 
and what is most convenient to make them accessible (with the first level 
of that access translation being done "statically" by ioremap(), and the 
second level of the access translation being done by "read[bwl]()" and 
friends).

You could make "ioremap()" be a no-op and do all translation dynamically. 
Of you could make "ioremap()" be complex, and do no dynamic translation 
(x86). Or you can have a combination of the two.

The numbers don't have "meaning" per se. The inputs to "ioremap()" are 
"ranges of something". They are the exact same "somethings" as lives in 
"iomem_resource" "resources of something".

			Linus

