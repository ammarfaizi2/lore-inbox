Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130013AbRCPGEW>; Fri, 16 Mar 2001 01:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130029AbRCPGEM>; Fri, 16 Mar 2001 01:04:12 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:18358 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130013AbRCPGEC>;
	Fri, 16 Mar 2001 01:04:02 -0500
Date: Fri, 16 Mar 2001 01:03:20 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: David <david@blue-labs.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] report
In-Reply-To: <667310000.984721919@tiny>
Message-ID: <Pine.GSO.4.21.0103160056060.10709-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Mar 2001, Chris Mason wrote:

> > I suspect that the right fix is to drop the ->s_lock bogosity along with
> > sys_sync() call in panic()...
> 
> Ok, I was more talking about the ugliness that is reiserfs_panic (how many
> times do we need a commented out for(;;)?).  For panic() calling sys_sync,
> I think there non-filesystem related panics where we do want to sync.

panic doesn't sync if called from interrupt (thanks $DEITY).
It is pointless to sync during boot.
sync from driver panic is not better than one from fs.

What does it leave? I hadn't checked each panic(), but it seems that
if we ever want syncing upon panic() it's safer to do sys_sync() by
hands before calling panic(). If it is actually ever needed, that is.

