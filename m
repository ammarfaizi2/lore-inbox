Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVDIFne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVDIFne (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 01:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVDIFnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 01:43:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:23172 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261290AbVDIFnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 01:43:31 -0400
Date: Fri, 8 Apr 2005 22:45:18 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Martin Pool <mbp@sourcefrog.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050409022701.GA14085@opteron.random>
Message-ID: <Pine.LNX.4.58.0504082240460.28951@ppc970.osdl.org>
References: <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org> <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz> <1112852302.29544.75.camel@hope>
 <Pine.LNX.4.58.0504071626290.28951@ppc970.osdl.org> <1112939769.29544.161.camel@hope>
 <Pine.LNX.4.58.0504072334310.28951@ppc970.osdl.org> <20050408083839.GC3957@opteron.random>
 <Pine.LNX.4.58.0504081647510.28951@ppc970.osdl.org> <20050409022701.GA14085@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Apr 2005, Andrea Arcangeli wrote:
> 
> I'm not entirely convinced wget is going to be an efficient way to
> synchronize and fetch your tree

I don't think it's efficient per se, but I think it's important that 
people can just "pass the files along". Ie it's a huge benefit if any 
everyday mirror script (whether rsync, wget, homebrew or whatever) will 
just automatically do the right thing. 

> Perhaps that's why you were compressing the stuff too? It sounds better
> not to compress the stuff on-disk

I much prefer to waste some CPU time to save disk cache. Especially since 
the compression is "free" if you do it early on (ie it's done only once, 
since the files are stable). Also, if the difference is a 1.5GB kernel 
repository or a 3GB kernel repository, I know which one I'll pick ;)

Also, I don't want people editing repostitory files by hand. Sure, the 
sha1 catches it, but still... I'd rather force the low-level ops to use 
the proper helper routines. Which is why it's a raw zlib compressed blob, 
not a gzipped file.

		Linus
