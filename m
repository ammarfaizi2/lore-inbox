Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265947AbUHANhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265947AbUHANhC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 09:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265959AbUHANhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 09:37:02 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32926 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265947AbUHANhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 09:37:00 -0400
Date: Sun, 1 Aug 2004 06:36:32 -0700
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org, akpm@osdl.org,
       colpatch@us.ibm.com
Subject: Re: [PATCH][2.6] first/next_cpu returns values > NR_CPUS
Message-Id: <20040801063632.66c49e61.pj@sgi.com>
In-Reply-To: <20040801131004.GT2334@holomorphy.com>
References: <Pine.LNX.4.58.0407311347270.4094@montezuma.fsmlabs.com>
	<20040731232126.1901760b.pj@sgi.com>
	<Pine.LNX.4.58.0408010316590.4095@montezuma.fsmlabs.com>
	<20040801124053.GS2334@holomorphy.com>
	<20040801060529.4bc51b98.pj@sgi.com>
	<20040801131004.GT2334@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A strong majority return BITS_PER_LONG-aligned results in this case.

You mean, in Zwane's example, we'd see a return from any_online_cpu() of
32 or 64, not 3 (his NR_CPUS), and not just on i386, but on a majority
of arch's.  That's what you're saying, right?

Ok ... that favors your preference, teaching the users of find_next_bit
to be more tolerant.

Darn.  Your min(nbits, ...) patch looks good, but more is needed.

And could you make it:

+	return min(nbits, find_next_bit(srcp->bits, nbits, n+1));

rather than:

+	return min(NR_CPUS, find_next_bit(srcp->bits, nbits, n+1));

for consistency of presentation?  All the cpu and node mask macros of
this form (#define wrapped static inline) use the inline's parameter
names in the body of the inline, not what the define passed as those
params, including another 'nbits' in this very line of code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
