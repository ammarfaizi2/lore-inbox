Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbUKQMNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUKQMNJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 07:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbUKQMNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 07:13:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2517 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262292AbUKQMKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 07:10:42 -0500
Date: Wed, 17 Nov 2004 07:09:15 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Chris Ross <chris@tebibyte.org>, Andrew Morton <akpm@osdl.org>,
       andrea@novell.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, mmokrejs@ribosome.natur.cuni.cz,
       tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
In-Reply-To: <20041117070935.GF19107@logos.cnet>
Message-ID: <Pine.LNX.4.61.0411170706510.20252@chimarrao.boston.redhat.com>
References: <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet>
 <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet>
 <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org>
 <20041117012346.5bfdf7bc.akpm@osdl.org> <20041117060648.GA19107@logos.cnet>
 <20041117060852.GB19107@logos.cnet> <419B2CFC.7040006@tebibyte.org>
 <20041117070935.GF19107@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Marcelo Tosatti wrote:

> So even when reaping referenced pages on zero priority scanning
> the OOM killer might be triggered in extreme cases. And as the
> number of tasks increases the chances things go wrong increase.

Ignoring the referenced bit should also make the system
"immune" from the "fake" references that the swap token
holding task will show.

However, since it also ignores real referenced bits, it
might mess up VM balancing a bit, which is what Andrew
was worried about.

> Please test Andrew's patch, its hopefully good enough for most
> scenarios. Extreme cases are probably still be problematic.

Actually, because Andrew's patch makes the real referenced
bit stand, but ignores the "fake" reference that the swap
token gives, I suspect it'll make this swap token corner
case a lot "softer" than my patch.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
