Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVHOWD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVHOWD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbVHOWD3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:03:29 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:442 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S965001AbVHOWD2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:03:28 -0400
Date: Tue, 16 Aug 2005 00:11:09 +0200
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@gmail.com>, akpm@osdl.org
Subject: Re: rc6 keeps hanging and blanking displays - bisection complete
Message-ID: <20050815221109.GA21279@aitel.hist.no>
References: <Pine.LNX.4.58.0508012201010.3341@g5.osdl.org> <20050805104025.GA14688@aitel.hist.no> <21d7e99705080503515e3045d5@mail.gmail.com> <42F89F79.1060103@aitel.hist.no> <42FC7372.7040607@aitel.hist.no> <Pine.LNX.4.58.0508120937140.3295@g5.osdl.org> <43008C9C.60806@aitel.hist.no> <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508150843380.3553@g5.osdl.org>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 08:50:12AM -0700, Linus Torvalds wrote:
> 
> 
> On Mon, 15 Aug 2005, Helge Hafting wrote:
> >
> > Ok, I have downlaoded git and started the first compile.
> > Git will tell when the correct point is found (assuming I
> > do the "git bisect bad/good" right), by itself?
> 
> Yes. You should see 
> 
> 	Bisecting: xxx revisions left to test after this
> 
> and the "xxx" should hopefully decrease by half during each round. And t 
> the end of it, you should get
> 
> 	<sha1> is first bad commit
> 
> followed by the actual patch that caused the problem.
> 
This was interesting.  At first, lots of kernels just kept working,
I almost suspected I was doing something wrong. Then the second last kernel
recompiled a lot of DRM stuff - and the crash came back!
The kernel after that worked again, and so the final message was:

561fb765b97f287211a2c73a844c5edb12f44f1d is first bad commit
diff-tree 561fb765b97f287211a2c73a844c5edb12f44f1d (from 
6ade43fbbcc3c12f0ddba112351d14d6c82ae476)
Author: Anton Blanchard <anton@samba.org>
Date:   Mon Aug 1 21:11:46 2005 -0700

    [PATCH] ppc64: topology API fix
    
    Dont include asm-generic/topology.h unconditionally, we end up overriding
    all the ppc64 specific functions when NUMA is on.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Acked-by: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 a760521110f862aecbee74cffa674993b6dca4a3 
66b9cb2db119ab029ca7b8f71bd06507fca63921 M      include

I'm a little surprised, as a ppc64 fix theoretically shouldn't matter for 
x86_64? But perhaps they share something?

I hope this is of help,
Helge Hafting
