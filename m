Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281314AbRKEU2k>; Mon, 5 Nov 2001 15:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281316AbRKEU2c>; Mon, 5 Nov 2001 15:28:32 -0500
Received: from mo.optusnet.com.au ([203.10.68.101]:8650 "EHLO
	mo.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S281315AbRKEU2V>; Mon, 5 Nov 2001 15:28:21 -0500
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Andrew Morton <akpm@zip.com.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Mike Fedyk <mfedyk@matchmail.com>, lkml <linux-kernel@vger.kernel.org>,
        ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <20011104193232.A16679@mikef-linux.matchmail.com> <200111050554.fA55swt273156@saturn.cs.uml.edu> <3BE647F4.AD576FF2@zip.com.au> <20011105131636.C3957@lynx.no>
From: m@mo.optusnet.com.au
Date: 06 Nov 2001 07:28:02 +1100
In-Reply-To: Andreas Dilger's message of "Mon, 5 Nov 2001 13:16:37 -0700"
Message-ID: <m1wv15ufn1.fsf@mo.optusnet.com.au>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@turbolabs.com> writes:
> On Nov 05, 2001  00:04 -0800, Andrew Morton wrote:
[..]
> > With the ialloc.c change, plus the other changes I mentioned
> > the time to create all these directories and files and then run
> > /bin/sync fell from 1:53 to 0:28.  Fourfold.
> 
> In the end, though, while the old heuristic has a good theory, it _may_
> be that in practise, you are _always_ seeking to get data from different
> groups, rather than _theoretically_ seeking because of fragmented files.
> I don't know what the answer is - probably depends on finding "valid"
> benchmarks (cough).

Another heuristic to try make be to only use a different blockgroup
for when the mkdir()s are seperate in time. i.e. rather than
doing 
	if ( 0 && .. 
use something like
	if ((last_time + 100) < jiffes && ... 
		last_time = jiffies;
which would in theory use the old behaviour for sparodic mkdirs
and the new behaviour for things like 'untar' et al.

M.
