Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278682AbRJSWE1>; Fri, 19 Oct 2001 18:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278675AbRJSWER>; Fri, 19 Oct 2001 18:04:17 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:36886 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S278682AbRJSWEB>; Fri, 19 Oct 2001 18:04:01 -0400
Date: Fri, 19 Oct 2001 18:04:34 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@muc.de, sim@netnation.com, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
Message-ID: <20011019180433.H9206@redhat.com>
In-Reply-To: <k23d4fwkv6.fsf@zero.aec.at> <20011019.135924.112609345.davem@redhat.com> <20011019173055.G9206@redhat.com> <20011019.145639.59667516.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011019.145639.59667516.davem@redhat.com>; from davem@redhat.com on Fri, Oct 19, 2001 at 02:56:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 02:56:39PM -0700, David S. Miller wrote:
> It doesn't need to "fit in the cache" to perform optimally, that's
> a load of crap Ben.
> 
> I actually tested this, and in fact on a cpu that has a meager 512K
> cache at the time, and it did turn out to be more important to keep
> the hash chains short than to keep it fitting in the cache.
> 
> So please don't give me any crap about "fitting in the cache" unless
> you can show me hard numbers that show that it does in fact perform
> worse.

Okay, let's take a look at the case where I have 64 connections open: if 
I'm using a 64 entry hash table with one 4 byte pointer per entry and 
perfect hashing, then it has a cache footprint of 256 bytes.  Max.  Now, 
the same hash table blown up to 4MB is going to have a cache footprint 
of 64 bytes (1 cache line) per entry, for a total of a 4KB cache footprint.
Which is better?

> Let me clue you in.  If the hash chains get long, you (instead of
> cache missing on the table itself) are missing the cache several
> times over walking the long hash chains.

Don't AssUMe that I don't realise this.  What I'm saying is that a 4MB hash 
table for a system with a puny number of connections is bloat.  Needless 
bloat.  4MB is enough memory for a copy of gcc.  Or enough to run 4 shells.  
If the hash table was grown dynamically, I wouldn't have this complaint.

		-ben
