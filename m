Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262784AbUKXSnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUKXSnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 13:43:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUKXSkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 13:40:45 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:60321 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262784AbUKXScq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 13:32:46 -0500
To: avi@argo.co.il
CC: alan@lxorguk.ukuu.org.uk, torvalds@osdl.org, hbryan@us.ibm.com,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <41A47B67.6070108@argo.co.il> (message from Avi Kivity on Wed, 24
	Nov 2004 14:15:35 +0200)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>	 <E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>	 <Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org> <1100798975.6018.26.camel@localhost.localdomain> <41A47B67.6070108@argo.co.il>
Message-Id: <E1CWwqF-0007Ng-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Nov 2004 14:05:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://lkml.org/lkml/2004/7/26/68
> 
> discusses a userspace filesystem (implemented as a userspace nfs server 
> mounted on a loopback nfs mount), the problem, a solution (exactly your 
> suggestion), and a more generic solution.

Thanks for the pointer, very interesting read.

However, I don't like the idea that the userspace filesystem must
cooperate with the kernel in this regard.  With this you lose one of
the advantages of doing filesystem in userspace: namely that you can
be sure, that anything you do cannot bring the system down.

And I firmly believe that this can be done without having to special
case filesystem serving processes.

There are already "strange" filesystems in the kernel which cannot
really get rid of dirty data.  I'm thinking of tmpfs and ramfs.
Neither of them are prone to deadlock, though both of them are "worse
off" than a userspace filesystem, in the sense that they have not even
the remotest chance of getting rid of the dirty data.

Of course, implementing this is probably not trivial.  But I don't see
it as a theoretical problem as Linus does. 

Is there something which I'm missing here?

Thanks,
Miklos
