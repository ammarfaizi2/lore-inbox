Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUDAWaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbUDAWaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:30:09 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:29834
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263240AbUDAW36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:29:58 -0500
Date: Fri, 2 Apr 2004 00:29:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040401222957.GZ18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <Pine.LNX.4.44.0404011443250.5589-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404011443250.5589-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 02:44:50PM -0500, Rik van Riel wrote:
> On Thu, 1 Apr 2004, Andrea Arcangeli wrote:
> 
> > This is a lot simpler than the mlock rlimit and this is people really
> > need (not the rlimit). The rlimit thing can still be applied on top of
> > this. This should be more efficient too (besides its simplicity).
> 
> What use is this patch ?
> 
> One of the main reasons for the mlock rlimit is so that
> security conscious people can let normal users' gpg
> mlock a few pages.
> 
> This patch isn't usable for that at all, since switching
> the sysctl on would just open up the system to an easy
> deadlock by any user.  Definately not something any
> security conscious admin would want to enable ...

there's no way the rlimit patch can cover shmget(SHM_HUGETLB) and
shmctl(SHM_LOCK). That's the use of this patch.

Plus it obsoletes the need of setting rlimit for apps like databases.

the rlimit patch remains useful for the multiuser system you're talking
about (assuming you also limit the number of tasks per-user
accordingly).
