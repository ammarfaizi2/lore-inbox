Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264858AbUFOAUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264858AbUFOAUr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 20:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUFOAUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 20:20:47 -0400
Received: from colin2.muc.de ([193.149.48.15]:29710 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264858AbUFOAUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 20:20:45 -0400
Date: 15 Jun 2004 02:20:44 +0200
Date: Tue, 15 Jun 2004 02:20:44 +0200
From: Andi Kleen <ak@muc.de>
To: Paul Jackson <pj@sgi.com>
Cc: Andi Kleen <ak@muc.de>, anton@samba.org, linux-kernel@vger.kernel.org,
       lse-tech@projects.sourceforge.net
Subject: Re: NUMA API observations
Message-ID: <20040615002044.GF90963@colin2.muc.de>
References: <20040614153638.GB25389@krispykreme> <20040614161749.GA62265@colin2.muc.de> <20040614142128.4da12a8d.pj@sgi.com> <20040614234430.GB90963@colin2.muc.de> <20040614170605.130d9a67.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040614170605.130d9a67.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 05:06:05PM -0700, Paul Jackson wrote:
> > I really dislike this error code [EINVAL] btw ...
> 
> Then use others ??
> 
> The way I learned Unix, decades ago, the tradition was to use a variety
> of errno values, even if they were a slightly strange fit, in order to
> provide more detailed error feedback.  Look for example at the rename(2)
> or acct(2) system calls.

I tried to use creative errnos in the past (we have some
interesting unused ones from SYSV that can be abused like EADV
or EDOTDOT or ELIBBAD or EILSEQ), but Linus tends to reject
patches that use them. It wouldn't help here anyways, since
libnuma has to work with existing kernels. And changing the errno
now would probably break all user space workaround code people 
have developed for this misfeature.

Best would be probably to fix the kernel to check that the 
passed buffer is big enough for the highest running CPU,
And it should error out when there are bits set above
the cpumask limit (see the code in mm/mempolicy.c that
checks all this for node masks). I will cook up a patch for 
this later.

-Andi 

