Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWCMEkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWCMEkr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWCMEkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:40:47 -0500
Received: from ns2.suse.de ([195.135.220.15]:57295 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932115AbWCMEkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:40:47 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 13 Mar 2006 15:39:37 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17428.63369.446803.958721@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc6-mm1 (NFS tree ... busy inodes ... relatively harmless)
In-Reply-To: message from Andrew Morton on Sunday March 12
References: <20060312031036.3a382581.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday March 12, akpm@osdl.org wrote:
> 
> - The NFS tree is a bit sick - you may see the `busy inodes - self destruct
>   in five seconds" message when performing NFS unmounts.  It seems relatively
>   harmless.

I think the term is "mostly harmless" ... see the entry for "Earth" in
The Hitch-Hikers Guide To The Galaxy... :-)

I don't believe this is harmless at all, and I have an oops to prove
it - though it is with NFSv4 which is still EXPERIMENTAL.

I don't believe it is an NFS bug at all, but a VFS bug.  It happens
more with NFS because iput on nfs can be a lot slower due to the
required network activity, so the race is easier to hit.

See the 
      Fix shrink_dcache_parent() against shrink_dcache_memory() race
threads.

Of course there could be other bugs...

NeilBrown
