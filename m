Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbUKRT4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbUKRT4J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUKRTyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 14:54:24 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:41876 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S262951AbUKRTvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 14:51:39 -0500
To: hbryan@us.ibm.com
CC: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       pavel@ucw.cz, torvalds@osdl.org
In-reply-to: <OFFF27FA67.0439D04D-ON88256F50.006793AA-88256F50.00699D3A@us.ibm.com>
	(message from Bryan Henderson on Thu, 18 Nov 2004 11:12:41 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OFFF27FA67.0439D04D-ON88256F50.006793AA-88256F50.00699D3A@us.ibm.com>
Message-Id: <E1CUsJX-0004Q6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 18 Nov 2004 20:51:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The "allocation" is a fetch or store instruction by the FUSE process, 
> which generates a page fault.  To satisfy that, the kernel has to allocate 
> some real memory.  A fetch or store instruction doesn't fail when there's 
> no real memory available.  It just waits for the kernel to make some 
> available.  The kernel does that by picking some less deserving page and 
> evicting it.  That eviction may require a pageout.  If the guy who's doing 
> the fetch or store is the guy who's supposed to do that pageout, you have 
> a deadlock.

OK.  I still maintaintain, that this is an impossible situation, but
maybe I'm wrong. 

> Furthermore, it's not right for the write() to fail or for any process to 
> be killed by the OOM Killer.  The system has the resources to complete the 
> job.  It just hasn't scheduled them correctly and thus backed itself into 
> a corner.

Yes, but a kernel based filesystem would be in the same situation.
It's not a problem unique to userspace filesystems.  And I think the
kernel is careful enough not to get into the corner.  So there's no
problem.

Miklos
