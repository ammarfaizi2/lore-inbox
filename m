Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSHDNH4>; Sun, 4 Aug 2002 09:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317862AbSHDNHz>; Sun, 4 Aug 2002 09:07:55 -0400
Received: from ns.suse.de ([213.95.15.193]:29959 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317861AbSHDNHz> convert rfc822-to-8bit;
	Sun, 4 Aug 2002 09:07:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [PATCH] Caches that shrink automatically
Date: Sun, 4 Aug 2002 15:11:27 +0200
X-Mailer: KMail [version 1.4]
Cc: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
References: <200208041308.51638.agruen@suse.de> <3D4D1070.1020802@namesys.com>
In-Reply-To: <3D4D1070.1020802@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208041511.27990.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 August 2002 13:30, Hans Reiser wrote:
> How do you ensure that caches have their (internal) aging hands pushed
> at a speed that is proportional to their memory usage, or is your design
> susceptible to all the usual complaints the unified memory manager crowd
> has about separate caches?

That's a policy/optimization issue; it's not even desirable to shrink the 
caches with priorities proportional to their size---they would all tend to 
become equally large.

The patch shrinks all the caches equally often, with the same priorities. The 
caches can then decide themselves how they will react, depending on their 
cache size and entry size, replacement strategy, taking care of page entry 
clustering or not, etc.

The icache, dcache, and dqcache are shrunk using the same strategy (except the 
priority is a constant for some of the caches, which could be coded in the 
shrink function as well). This scheme has worked out pretty well so far, 
right?

For Extended Attributes we are currently using a very simple cache with LRU 
entry replacement, and small entries. The cache doesn't grow very big, 
either.

Regards,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany

