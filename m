Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUK3V7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUK3V7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbUK3V7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:59:21 -0500
Received: from rev.193.226.233.139.euroweb.hu ([193.226.233.139]:63616 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261233AbUK3V7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:59:13 -0500
To: avi@argo.co.il
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <41ACE816.50104@argo.co.il> (message from Avi Kivity on Tue, 30
	Nov 2004 23:37:26 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il> <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu> <41ACBF87.4040206@argo.co.il> <E1CZDUf-0004jM-00@dorka.pomaz.szeredi.hu> <41ACD03C.9010300@argo.co.il> <E1CZFJP-0004uZ-00@dorka.pomaz.szeredi.hu> <41ACE816.50104@argo.co.il>
Message-Id: <E1CZG1J-0004zW-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 30 Nov 2004 22:58:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like we are in a deadlock here :)
> 
> However you choose to call it, it is unacceptable IMO.

That I can agree with.  I never said that this was a full solution,
only that this shows, that the deadlock is not inherent in userspace
filesystems.

> So the userspace filesystem would pass that amount to the kernel. It's 
> not pretty, but it is workable.

Not pretty is an understatement IMO.

> >And this is not unique to userspace filesystems, as Rik van Riel
> >pointed out earlier, network filesystems are also prone to deadlock:
> >
> >http://lkml.org/lkml/2004/11/27/81
> >
> >  
> >
> This looks like a bug to me. Maybe jiggling the thresholds would help.

Yes, and it's the jiggling I want to avoid.

> The situation with userspace filesystems is:
> 
>   some process allocates memory, blocking on kswapd as memory is full
>   kswapd calls userspace filesystem to free memory
>   userspace filesystem calls kernel, which allocates memory and blocks 
> on kswapd
>   eventually all processes in the system block on kswapd
> 
> I have observed (and fixed) this on a real system.

I have observed it too (not yet fixed, but working on it).  But
realize that my proposal would excempt userspace filesystem pages from
being blocked on by kswapd.  That's a fundamental difference.

Since you don't believe me, I'll have to make an implementation, so
you can experiment with it.  And if you'll still be able to cause a
deadlock, I'll subject myself to extreme repentance, and promise never
to touch an operating system ever again :)

> with ramfs, once it accounts for memory, there would be no deadlock and 
> no oom.

And once fuse acounts for memory there will be no deadlock and no oom.
See the symmetry?

Miklos
