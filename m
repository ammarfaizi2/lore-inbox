Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSGUWZI>; Sun, 21 Jul 2002 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSGUWZI>; Sun, 21 Jul 2002 18:25:08 -0400
Received: from slarti.muc.de ([193.149.48.10]:2316 "HELO slarti.muc.de")
	by vger.kernel.org with SMTP id <S315119AbSGUWZH> convert rfc822-to-8bit;
	Sun, 21 Jul 2002 18:25:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Stephan Maciej <stephan@maciej.muc.de>
To: linux-kernel@vger.kernel.org
Subject: Re: memory leak?
Date: Mon, 22 Jul 2002 00:27:31 +0200
X-Mailer: KMail [version 1.4]
References: <yw1xn0sluqom.fsf@gladiusit.e.kth.se> <20020722100840.2599c2f3.arodland@noln.com> <1027261239.785.8.camel@tux>
In-Reply-To: <1027261239.785.8.camel@tux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207220027.31728.stephan@maciej.muc.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 16:20, Martin Josefsson wrote:
> free don't know about slabcaches. take a look in /proc/slabinfo and see
> what's using that memory. it's not a leak, the memory will be free'd
> when the machine is under enough memory pressure.

What happens when updatedb(1) runs? It does a `find /' and thus loads a lot of 
fs related data into memory, which makes the kernel caches grow. But how 
aggressive do these caches grow? Does this lead to any swapout because the 
kernel likes it better to have some dentries and inodes in memory than 
probably not-recently-used user pages?

If so, this would mean that a low-priority job like updatedb(1) makes pages 
being swapped out that definitely have a higher priority. For updatedb and 
similar things (largish ls -lR's) it would make sense to 
load-and-quickly-forget all the inode and dentry cache stuff. Another 
optimisation syscall, like madvise?

Stephan

-- 
"That's interesting.  Can it be disabled?" -- someone on LKML, after being 
told about the PIV hyperthreading features

