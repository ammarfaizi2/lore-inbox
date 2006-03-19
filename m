Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWCSUcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWCSUcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 15:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbWCSUcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 15:32:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6824 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750896AbWCSUcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 15:32:03 -0500
Date: Sun, 19 Mar 2006 12:31:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Al Viro <viro@ftp.linux.org.uk>
cc: Andrew Morton <akpm@osdl.org>, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
 <20060319194004.GZ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Linus Torvalds wrote:
> 
> So this definitely works, and is not new. 

Btw, don't get me wrong - I think it would be preferable to use the 
"for_each/end_for_each" syntax, since that would make the macros simpler, 
and would possibly allow for somewhat simpler generated code.

But that would require each of the 300+ "for_each.*_cpu()" uses in the 
current kernel to be modified and checked. In the meantime, people who are 
interested can test out how much difference the trivial patch makes for 
them..

For me, it made a 4970 byte difference in code size. Noticeable? Maybe 
not (it's about 0.15% of my kernel text-size), but it _is_ better code, 
and next time somebody gets an oops near there, at least the crap code 
won't be hiding the cause ;)

		Linus
