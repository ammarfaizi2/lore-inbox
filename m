Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWGOL3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWGOL3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 07:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWGOL3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 07:29:17 -0400
Received: from [212.76.87.2] ([212.76.87.2]:46599 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932506AbWGOL3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 07:29:16 -0400
From: Al Boldi <a1426z@gawab.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Sat, 15 Jul 2006 14:29:32 +0300
User-Agent: KMail/1.5
Cc: Frank van Maarseveen <frankvm@frankvm.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
References: <200607112257.22069.a1426z@gawab.com> <200607132351.04721.a1426z@gawab.com> <1152824071.3024.89.camel@laptopd505.fenrus.org>
In-Reply-To: <1152824071.3024.89.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607151429.32298.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> > BTW, why does randomize_stack_top() mod against (8192*1024) instead of
> > (8192) like arch_align_stack()?
>
>  because it wants to randomize for 8Mb, unlike arch_align_stack which
> wants to randomize the last 8Kb within this 8Mb ;)

Randomizing twice?

Anyway, I tried different combinations of turning off randomization in both 
functions and got mixed results, so it looks like there is some interaction 
here.

Trying different compiler versions and switches also show different results.

Calling these slowdowns blips is really an understatement, as there are cases 
which lock into 800% hits. i.e: processes that, when repeatedly called, lock 
into a continuous 8x slowdown on i686P4.

There is even a case where a mere rename or running through an extra shell 
causes a slowdown.  And that's with randomization turned off.

2.4.31 doesn't show these slowdowns.

What is 2.6 doing?


Thanks!

--
Al

