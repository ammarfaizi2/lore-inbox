Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUHANGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUHANGf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265931AbUHANGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:06:35 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25282 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265930AbUHANGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:06:33 -0400
Date: Sun, 1 Aug 2004 06:05:29 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-Id: <20040801060529.4bc51b98.pj@sgi.com>
In-Reply-To: <20040801124053.GS2334@holomorphy.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
	<20040731232126.1901760b.pj@sgi.com>
	<Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
	<20040801124053.GS2334@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William wrote:
> Maybe the few callers that are sensitive to the precise return value
> should use min_t(int, NR_CPUS, ...) instead of all callers taking the
> branch on behalf of those few.

Either way - we need consistency.  Either find_next_bit(.., size, ...)
returns exactly size if no more bits, or all its callers tolerate any
return >= size.

I probably prefer the former, because I expect slightly tighter kernel
code now (see my previous post on text size), and fewer bugs in the
future (more clients of find_next_bit will be coded than new
implementations of it), if we go this way.  William's comments suggest
to me he prefers the later.

Either (or both) seems better than what we have.

William - can you read the find_next_bit() implementations in some other
arch's well enough to understand if they are anal about returning
exactly 'size', or content to return something >= size, when they run
out of bits?  That code was a bit denser than I could deal with easily.

If a strong majority of the arch's find_next_bit() are anal, or on the
other hand, are not, then I'd suggest we follow their lead.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
