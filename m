Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUEAPJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUEAPJf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 11:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbUEAPJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 11:09:35 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:28110 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262006AbUEAPJc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 11:09:32 -0400
Date: Sat, 1 May 2004 10:08:57 -0500
From: "Jose R. Santos" <jrsantos@austin.ibm.com>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, anton@samba.org,
       dheger@us.ibm.com, slpratt@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance changes.
Message-ID: <20040501150857.GA17778@austin.ibm.com>
References: <20040430195504.GE14271@rx8.ibm.com> <8765bg4af9.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8765bg4af9.fsf@goat.bogus.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de> [2004-05-01 14:08:26 +0200]:
> Judging from the graphs (!), I don't see a real difference for
> dcache. There's just one outlier (depth 11) for the old hash function,
> which seems to be translated to multiple depth 9 entries. The
> histograms seem to confirm, that there's at most a minimal difference,
> if they'd be equally scaled.
> 
> Maybe this is due to qstr hashes, which were used by both approaches
> as input?

SpecSFS is not really the best benchmark to show the efficiency of the
dentry hash function.  I need to come up with a better defense for the
this hash functions.  While I did not do the study for this hash
function, mathematically speaking this hash algorithm should always
create a equal or better hash.  SFS just shows equal (well, slightly
better), so Ill work on getting some more data to back up the "better"
claim.

> The inode hash seems to be distributed more evenly with the new hash
> function. Although the inode histogram suggests, that most buckets are
> in the 0-2 depth range, with the old hash function leading slightly in
> the zero depth range.

Thats a good thing.  With the new hash function, we get 25% more bucket
usage and most of the bucket are only 1 object deep.  This buckets take
up memory so we better use them.   The old hash functions was no very
efficient in spreading the hashes across all the buckets, with the new
hash function we have 4.5 times more buckets with only 1 object deep so
it scales better as we increase the number of buckets as well.

It also provides a 3% improvement on the overall SFS number with half
the number of buckets use which I believe its a great improvement from 
just a hash algorithm change.

-JRS
