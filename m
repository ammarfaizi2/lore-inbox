Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUIWPo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUIWPo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 11:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUIWPo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 11:44:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4795 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266324AbUIWPoS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 11:44:18 -0400
Date: Thu, 23 Sep 2004 11:11:57 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: jun.nakajima@intel.com, akpm@osdl.org, arjanv@redhat.com, ak@suse.de
Subject: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Message-ID: <20040923141157.GA12367@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Forgot to CC linux-kernel, just in case someone else
can have useful information on this matter.

Andi says any additional overhead will be in the noise
compared to cacheline saving benefit.

***********

Jun,

We need some assistance here - you can probably help us.

Within the Linux kernel we can benefit from changing some fields 
of commonly accessed data structures to 16 bit instead of 32 bits,
given that the values for these fields never reach 2 ^ 16. 

Arjan warned me, however, that the prefix (in this case "data16") will 
cause an additional extra cycle in instruction decoding, per message above. 

Can you confirm that please? We can't seem to be able to find 
it in Intel's documentation.

By shrinking two fields of "per_cpu_pages" structure we can fit it 
in one 32-byte cacheline (<= Pentium III and probably several other 
embedded/whatnot architectures will benefit from such a change).

And we just shrank two fields of "struct pagevec" in a similar way 
in Andrew's -mm tree.

I'm adding linux-kernel just in case someone else can have
useful comments.

Thanks.

----- Forwarded message from Arjan van de Ven <arjanv@redhat.com> -----

From: Arjan van de Ven <arjanv@redhat.com>
Date: Tue, 14 Sep 2004 13:13:29 +0200
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: akpm@osdl.org, "Martin J. Bligh" <mbligh@aracnet.com>,
	linux-mm@kvack.org
In-Reply-To: <20040914093407.GA23935@logos.cnet>
Subject: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline
Original-Recipient: rfc822;linux-mm@kvack.org
X-Loop: owner-majordomo@kvack.org
X-MIMETrack: Itemize by SMTP Server on USMail/Cyclades(Release 6.5.1|January 21, 2004) at
 09/14/2004 03:13:02

On Tue, Sep 14, 2004 at 06:34:07AM -0300, Marcelo Tosatti wrote:
> How come short access can cost 1 extra cycle? Because you need two "read bytes" ?

on an x86, a word (2byte) access will cause a prefix byte to the
instruction, that particular prefix byte will take an extra cycle during execution
of the instruction and potentially reduces the parallal decodability of
instructions....



----- End forwarded message -----

----- End forwarded message -----
