Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263490AbUDBBS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 20:18:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUDBBS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 20:18:58 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:7059
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263490AbUDBBSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 20:18:05 -0500
Date: Fri, 2 Apr 2004 03:18:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402011804.GL18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401170705.Y22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 05:07:05PM -0800, Chris Wright wrote:
> * Andrea Arcangeli (andrea@suse.de) wrote:
> > Oracle needs this sysctl, I designed it and Ken Chen implemented it. I
> > guess google also won't dislike it.
> > 
> > This is a lot simpler than the mlock rlimit and this is people really
> > need (not the rlimit). The rlimit thing can still be applied on top of
> > this. This should be more efficient too (besides its simplicity).
> > 
> > can you apply to mainline?
> 
> This patch seems like the wrong hack to work around missing mlock rlimit
> functionality.  Wouldn't it be better to fix the core problem, and leave
> this patch out of mainline?  I agree with Rik, such a fix (mlock/rlimit)
> will make all the gpg users feel warm and fuzzy ;-)

please elaborate how can you account for shmget(SHM_HUGETLB) with the
rlimit. The rlimit is just about the _address_space_ mlocked, there's no
way to account for something _outside_ the address space with the rlimit,
period. If you attempt doing that, _that_ will be THE true hack(tm) ;).
