Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314394AbSENIG0>; Tue, 14 May 2002 04:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSENIG0>; Tue, 14 May 2002 04:06:26 -0400
Received: from mons.uio.no ([129.240.130.14]:20940 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S314394AbSENIGZ>;
	Tue, 14 May 2002 04:06:25 -0400
To: Andrea Arcangeli <andrea@suse.de>
Cc: Mario Vanoni <vanonim@dial.eunet.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NFS problem after 2.4.19-pre3, not solved
In-Reply-To: <3CDC4962.4B9393D7@dial.eunet.ch>
	<15582.65383.578660.222454@charged.uio.no>
	<20020513184050.D22902@dualathlon.random>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 14 May 2002 10:06:17 +0200
Message-ID: <shswuu7f91i.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrea Arcangeli <andrea@suse.de> writes:


     > the thing that makes the difference is the backout-cto patch
     > according those numbers and I doubt it is influencing the page
     > replacement in any way (is kernel-side memory pressure going to
     > increase significantly with cto?).

No. The only possibility I can see is if the extra checks are causing
extra cache invalidations. I don't why that should be the case, but
then again I'm not able to reproduce those numbers...

     > 2.4.19-pre3 vanilla first time after boot 5m15s, then 1m56s
     > 1m57s 1m56s 1m56s 1m57s

     > 2.4.19-pre4 vanilla 5m20s, then 4m00s 4m01s 4m00s 4m01s 4m01a

     > 2.4.19-pre4-nfs-backout-cto, from pr8aa2, 2 Hunks 5m13a, then
     > 1m57s 1m58s 1m57s 1m58s 1m59s

     > nfs-backout-cto is appended. Now if the previous kernel was
     > buggy and it was not invalidating "invalid" cache then cto is
     > right, otherwise it sounds like the cto patch is invalidating
     > more cache than necessary.

Check the patch: it doesn't invalidate the cache when the mtime stays
the same. A tcpdump would show whether this is the case or not.

I would be interested to see if this is something that is related to
nfs-server only. (I.e. whether or not Mario can see the same problem
with knfsd.)


Cheers,
  Trond
