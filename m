Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUJVSm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUJVSm2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 14:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267725AbUJVRfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:35:02 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:26015 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S266216AbUJVRMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:12:38 -0400
Date: Fri, 22 Oct 2004 19:13:38 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041022171338.GK14325@dualathlon.random>
References: <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au> <20041022011057.GC14325@dualathlon.random> <20041021182651.082e7f68.akpm@osdl.org> <417879FB.5030604@yahoo.com.au> <20041021202656.08788551.akpm@osdl.org> <41787FFF.9060502@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41787FFF.9060502@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 01:35:27PM +1000, Nick Piggin wrote:
> Andrea do you have any pointers?

here we go, the same that deadlocked 2.4.14pre5aa1 will deadlock 2.6
just now (but not latest mainline 2.4 and of course not any recent
2.4-aa)

http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&selm=linux.kernel.3BE07730.60905%40google.com
http://groups.google.com/groups?q=google+VM+deadlock&hl=en&lr=&ie=UTF-8&selm=linux.kernel.20011118092434.A1331%40athlon.random&rnum=1

2.6 has a sysctl that should fix it too but it's disabled by default
(which makes it useless to 99% of userbase) and it's pretty hard to be
able to attempt to tun it to a desired value.

When you get an oom killer triggering too early, or an complete oom
deadlock, I never know if this is the lowmem_reserve missing, or the oom
killer going nuts, and I've a dozen of reports of oom triggering
spurious and some oom deadlock pending. So this is certainly the first
thing I must fix.
