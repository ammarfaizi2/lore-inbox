Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWDZQpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWDZQpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWDZQpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 12:45:39 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:50623 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750744AbWDZQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 12:45:38 -0400
Date: Wed, 26 Apr 2006 11:46:07 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060426154607.GA8628@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604212034.53486.blaisorblade@yahoo.it> <20060425162941.GB22807@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604261747.54660.blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 05:47:54PM +0200, Blaisorblade wrote:
> If we can do without MASK_STRICT_VERIFY, that works fully, and
> anyway it's simpler - however, say, when running strace -e read,tee
> (sys_tee will soon be added, it seems) this call would fail, while it
> would be desirable to have it work as strace -e read. 
> 
> MASK_STRICT_VERIFY isn't necessarily the best solution, but if
> userspace must search the maximum allowed syscall by multiple
> attempts, we've still a bad API.
> 
> Probably, a better option (_instead_ of MASK_STRICT_VERIFY) would be
> to return somewhere an "extended error code" saying which is the
> last allowed syscall or (better) which is the first syscall which
> failed. I.e. if there is strace -e read,splice,tee and nor splice nor
> tee are supported, then this value would be __NR_splice and strace (or
> any app) could then decide what to do.

Why not just zero out the bits that the kernel knows about?  Then, if
we return -EINVAL, the process just looks at the remaining bits that
are set to see what system calls the kernel didn't know about.

				Jeff
