Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWCSUC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWCSUC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWCSUC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:02:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbWCSUCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:02:03 -0500
Date: Sun, 19 Mar 2006 12:01:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <20060319194004.GZ27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
 <20060319194004.GZ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Al Viro wrote:
>
> In the version of gcc you've tested.  With options and phase of moon
> being what they had been.  IOW, you are awfully optimistic - it's not
> just using gcc extension, it's using undocumented (in the best case)
> behaviour outside the intended use of that extension.

I admit that it's ugly, but it's not undocumented. It flows directly from 
"statements as expression". Once you do that, you have to do flow control 
with them.

The end result may be _surprising_, the same way Duff's device is 
surprising (and for the same reason). But a C compiler that doesn't 
support Duff's device is not a C compiler. And this is really no 
different: it may not bestandard C: but it _is_ standard and documented 
GNU C.

And btw, this is _not_ new behaviour for the kernel. We have used 
non-local control behaviour in statement expressions before, just do a

	git grep '({.*return' 

to see at least ten cases of that (in fact, check out NFA_PUT(), which 
does a goto for the failure case in networking). That grep misses all the 
multi-line cases, so I assume there are more of them.

So this definitely works, and is not new. 

			Linus
