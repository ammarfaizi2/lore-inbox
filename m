Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263282AbTEOBIC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263286AbTEOBIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:08:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39435 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263282AbTEOBIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:08:00 -0400
Date: Wed, 14 May 2003 18:20:23 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christopher Hoover <ch@murgatroid.com>
cc: "'Ulrich Drepper'" <drepper@redhat.com>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
In-Reply-To: <002201c31a7d$0f3f32a0$175e040f@bergamot>
Message-ID: <Pine.LNX.4.44.0305141811310.28093-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 May 2003, Christopher Hoover wrote:
> 
> This a specious argument.  There are many ways one can configure a
> kernel that will make it fail to boot or run user space properly.

Not very many, and some of them have been removed.

For example, CONFIG_FILTER no longer exists. Why? Because it was too easy 
to create a kernel on which dhcp no longer worked, and the advantage of 
making it a config option was minimal.

Yes, CONFIG_NET and CONFIG_SYSVIPC are still there. And everybody turns
them on, and they really are only useful for very embedded platforms. But
at least turning them off saves huge amounts of memory for those
platforms, something that isn't true of futexes.

Apart from those options? Not many I can see. CONFIG_PACKET perhaps,
although even that tends to break only very specialized applications.

The rule should _not_ be "what can we make optional". The rule should be 
"this must be made optional because there is a big advantage doing it that 
way, and it's specialized".

Futexes may be specialized today, but that's only because you have to run 
a modern glibc to see them. But once you do that, they are not specialized 
at all.

Btw, the fact that futexes don't work without CONFIG_MMU is a bug not in
futexes, but it the MMU-less code. The no-mmu version of "follow_page" is
just wrong and badly implemented, and there's nothing to say that futexes
aren't useful without a MMU. 

			Linus

