Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbULFFBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbULFFBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 00:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbULFFBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 00:01:03 -0500
Received: from lakermmtao10.cox.net ([68.230.240.29]:34276 "EHLO
	lakermmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261463AbULFFAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 00:00:55 -0500
In-Reply-To: <41B3C54B.1080803@kolivas.org>
References: <20041204104921.GC10449@suse.de> <20041204163948.GA20486@optonline.net> <20041205185844.GF6430@suse.de> <20041206002954.GA28205@optonline.net> <41B3BD0F.6010008@kolivas.org> <20041206022338.GA5472@optonline.net> <41B3C54B.1080803@kolivas.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <CED75073-4743-11D9-9115-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Jeff Sipek <jeffpc@optonline.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] Time sliced CFQ #2
Date: Mon, 6 Dec 2004 00:00:54 -0500
To: Con Kolivas <kernel@kolivas.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 05, 2004, at 21:34, Con Kolivas wrote:
> I think when nice is changed, ioprio needs to be changed with it as a 
> sane
> default action. I suspect that most of the time people will not use the
> separate ioprio call, but using 'nice' is a regular linuxy thing to 
> do. Ideally
> we make ioprio part of the 'nice' utility and we specify both at the 
> same time.
> Something like: "nice -n 5 -i 20 blah"

What about this:

nice = x;		/* -20 to 20 */
ioprio = y;		/* -40 to 40 */
effective_ioprio = clamp(x+y);	/* -20 to 20 */

This would allow tuning processes for unusual contrasts with the ioprio 
call.
On the other hand, it would allow us to just brute force "adjust" a 
process with
the nice command in the usual way without any changes to the "nice" 
source.

I also thought of a different effective ioprio calculation that scales
instead of clamping:

nice = x;		/* -20 to 20 */
ioprio = y;		/* -20 to 20 */
effective_ioprio = ((ioprio<0)?(20+nice):(20-nice))  *  abs(ioprio)/20;
			/* -20 to 20 */

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


