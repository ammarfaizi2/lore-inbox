Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCSWz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCSWz2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWCSWz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:55:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751173AbWCSWz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:55:27 -0500
Date: Sun, 19 Mar 2006 14:55:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: viro@ftp.linux.org.uk, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <20060319143513.05f8ac94.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603191453160.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
 <20060319194004.GZ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org> <20060319124701.41e16e7b.akpm@osdl.org>
 <Pine.LNX.4.64.0603191412270.3826@g5.osdl.org> <20060319143513.05f8ac94.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Andrew Morton wrote:
> 
> Also, optimise any_online_cpu() out of existence on CONFIG_SMP=n.
> 
> This function seems inefficient.  Can't we simply AND the two masks, then use
> find_first_bit()?

Then you'd need to generate a temporary cpumask thing. Not a big deal as 
long as it fits in an "unsigned long", but since the online-cpu thing is 
likely dense in any relevant cpu-mask, I actually think "any_online_cpu()" 
as it stands now is likely to be simpler/more efficient than generating a 
temporary mask.

		Linus
