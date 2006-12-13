Return-Path: <linux-kernel-owner+w=401wt.eu-S965089AbWLMTRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWLMTRp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWLMTRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:17:45 -0500
Received: from sbcs.cs.sunysb.edu ([130.245.1.15]:59184 "EHLO
	sbcs.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965071AbWLMTRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:17:44 -0500
Date: Wed, 13 Dec 2006 14:17:24 -0500 (EST)
From: Nikolai Joukov <kolya@cs.sunysb.edu>
X-X-Sender: kolya@compserv1
To: Phillip Susi <psusi@cfl.rr.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
In-Reply-To: <45804E3C.9020105@cfl.rr.com>
Message-ID: <Pine.GSO.4.53.0612131404510.5969@compserv1>
References: <Pine.GSO.4.53.0612122217360.22195@compserv1> <45804E3C.9020105@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nikolai Joukov wrote:
> > replication.  In case of RAID4 and RAID5-like configurations, RAIF performed
> > about two times *better* than software RAID and even better than an Adaptec
> > 2120S RAID5 controller.  This is because RAIF is located above file system
> > caches and can cache parity as normal data when needed.  We have more
> > performance details in a technical report, if anyone is interested.
>
> This doesn't make sense to me.  You do not want to cache the parity
> data.  It only needs to be used to validate the data blocks when the
> stripe is read, and after that, you only want to cache the data, and
> throw out the parity.  Caching the parity as well will pollute the cache
> and thus, should lower performance due to more important data being
> thrown out.

This happens automatically: unused parity pages are treated as unused
pages and get reused to cache something else.  Also, the parity
never gets cached if you do not write the data (or recover the data).
However, if you use the same parity page over and over you do not need to
fetch it from the disk again.

By the way, unlike most other stackable file systems, RAIF does not cache
the data (or parity) multiple times: it only caches the data at its own
level and not at the level of the lower file systems.

Nikolai.
-------------
Nikolai Joukov, Ph.D.
Filesystems and Storage Laboratory
Stony Brook University
