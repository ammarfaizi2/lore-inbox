Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTE2Jde (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTE2Jde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:33:34 -0400
Received: from ns.suse.de ([213.95.15.193]:7696 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262034AbTE2Jdc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:33:32 -0400
Date: Thu, 29 May 2003 11:46:48 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, pavel@suse.cz, akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-ID: <20030529094648.GB15333@wotan.suse.de>
References: <20030528144839.47efdc4f.akpm@digeo.com.suse.lists.linux.kernel> <20030528215551.GB255@elf.ucw.cz.suse.lists.linux.kernel> <p73wuga6rin.fsf@oldwotan.suse.de> <20030529.023203.41634240.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529.023203.41634240.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 02:32:03AM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: 29 May 2003 11:17:36 +0200
> 
>    This part won't work on sparc64 because it has separate address spaces
>    for user/kernel.
> 
> Yes, in fact I happen to be working in this area hold on...
> 
> I'm redoing Andi's x86_64 ioctl32 bug fixes more cleanly
> for sparc64 by instead using alloc_user_space().
> 
> Sorry Andi, I just couldn't bring myself to allow those bogus
> artificial limits you added just to fix these bugs... :-)

I also didn't like them too much and where they looked like they could
hurt I resorted to the verify_area trick instead (which didn't work 
for you...) 

I believe the remaining limits are harmless, but of course it's cleaner
to not have them.

If you use the function that extensively it would be better to allow
it to nest (e.g. add a field for the current offset in  task struct). 
Otherwise someone will get it wrong sooner or later.
(like the sock/tw_bucket ;) 

> This work also pointed out many bugs in this area which should
> be fixed by my stuff. (CDROMREAD* ioctls don't take struct cdrom_read
> they take struct cdrom_msf which is compatible, struct
> cdrom_generic_command32 was missing some members, etc. etc.)
> 
> This is a 2.4.x patch but should be easy to push over to the 2.5.x
> ioctl stuff using the appropriate compat types.

Ok thanks. I will port it to my 2.4 code.

Did you test them all?
 
-Andi
