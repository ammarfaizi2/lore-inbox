Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278672AbRJSV4g>; Fri, 19 Oct 2001 17:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278673AbRJSV4Z>; Fri, 19 Oct 2001 17:56:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9094 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S278672AbRJSV4L>;
	Fri, 19 Oct 2001 17:56:11 -0400
Date: Fri, 19 Oct 2001 14:56:39 -0700 (PDT)
Message-Id: <20011019.145639.59667516.davem@redhat.com>
To: bcrl@redhat.com
Cc: ak@muc.de, sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011019173055.G9206@redhat.com>
In-Reply-To: <k23d4fwkv6.fsf@zero.aec.at>
	<20011019.135924.112609345.davem@redhat.com>
	<20011019173055.G9206@redhat.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Fri, 19 Oct 2001 17:30:55 -0400

   On Fri, Oct 19, 2001 at 01:59:24PM -0700, David S. Miller wrote:
   > And, for a 640MB ram machine, a 4MB hash table is perfectly
   > reasonable.
   
   That isn't wholly true.  A 4MB hash table can never fit in the cache of 
   an Athlon, and for one that's being used as a workstation with 1GB of 
   ram and maybe 60 connections active on average, that's a huge waste of 
   ram, and a guarantee that there will be lots of cache misses which just 
   aren't required.  Keep the cache footprint as low as possible -- it 
   results in a system that performs better.
   
It doesn't need to "fit in the cache" to perform optimally, that's
a load of crap Ben.

I actually tested this, and in fact on a cpu that has a meager 512K
cache at the time, and it did turn out to be more important to keep
the hash chains short than to keep it fitting in the cache.

So please don't give me any crap about "fitting in the cache" unless
you can show me hard numbers that show that it does in fact perform
worse.

Let me clue you in.  If the hash chains get long, you (instead of
cache missing on the table itself) are missing the cache several
times over walking the long hash chains.

Franks a lot,
David S. Miller
davem@redhat.com
