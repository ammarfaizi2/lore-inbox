Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130867AbRCFC0V>; Mon, 5 Mar 2001 21:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRCFC0M>; Mon, 5 Mar 2001 21:26:12 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:4875 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130867AbRCFC0F>; Mon, 5 Mar 2001 21:26:05 -0500
Date: Mon, 5 Mar 2001 18:25:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Hansen <jeremy@xxedgexx.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <Pine.LNX.4.33L2.0103052108590.32449-100000@srv2.ecropolis.com>
Message-ID: <Pine.LNX.4.10.10103051819530.8391-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 5 Mar 2001, Jeremy Hansen wrote:
> 
> Right now I'm running 2.4.2-ac11 on both machines and getting the same
> results:
> 
> SCSI:
> 
> [root@orville /root]# time /root/xlog file.out fsync
> 
> real    0m21.266s
> user    0m0.000s
> sys     0m0.310s
> 
> IDE:
> 
> [root@kahlbi /root]# time /root/xlog file.out fsync
> 
> real    0m8.928s
> user    0m0.000s
> sys     0m6.700s
> 
> This behavior has been noticed by others, so I'm hoping I'm not just crazy
> or that my test is somehow flawed.
> 
> We're using MySQL with Berkeley DB for transaction log support.  It was
> really confusing when a simple ide workstation was out performing our
> Ultra160 raid array.

Well, it's entirely possible that the mid-level SCSI layer is doing
something horribly stupid.

On the other hand, it's also entirely possible that IDE is just a lot
better than what the SCSI-bigots tend to claim. It's not all that
surprising, considering that the PC industry has pushed untold billions of
dollars into improving IDE, with SCSI as nary a consideration. The above
may just simply be the Truth, with a capital T.

(And "bonnie" is not a very good benchmark. It's not exactly mirroring any
real life access patterns. I would not be surprised if the SCSI driver
performance has been tuned by bonnie alone, and maybe it just sucks at
everything else)

Maybe we should ask whether somebody like lnz is interested in seeing what
SCSI does wrong here?

		Linus

