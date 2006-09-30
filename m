Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWI3V5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWI3V5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWI3V5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:57:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:41705 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751379AbWI3V5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:57:13 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Date: Sat, 30 Sep 2006 23:57:06 +0200
User-Agent: KMail/1.9.3
Cc: Ingo Molnar <mingo@elte.hu>, Eric Rannaud <eric.rannaud@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Jan Beulich <jbeulich@novell.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com> <20060930204900.GA576@elte.hu> <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609301406340.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609302357.06215.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> It could - and _should_ dammit! - do some basic sanity tests like "is the 
> thing even in the same stack page"? But nooo... It seems _designed_ to be 
> fragile and broken.

That wouldn't work with interrupt stacks.

The old unwinder code had a state machine to deal with them,
but it was distingustingly complicated (there are nasty corner cases 
where you can be in multiple interrupt stacks nested). I'm not
sure we would have really wanted to retain that.

What it does is to do __get_user for the stack values and it has the 
unwind tables in the executable as sanity check, so in some sense it is 
more reliable than the old code.

BTW again let me repeat this particular issue wasn't in the unwinder
itself, but just in the fallback-to-old code which didn't do enough
sanity checks. So you can say it's not the new unwinder that
crashed, but the old one here. I'll add more.

-Andi
