Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbUKSL2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbUKSL2Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUKSL2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:28:15 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:16342 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261349AbUKSL2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:28:02 -0500
To: akpm@osdl.org
CC: torvalds@osdl.org, hbryan@us.ibm.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@ucw.cz
In-reply-to: <20041118130601.6ee8bd97.akpm@osdl.org> (message from Andrew
	Morton on Thu, 18 Nov 2004 13:06:01 -0800)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <OF28252066.81A6726A-ON88256F50.005D917A-88256F50.005EA7D9@us.ibm.com>
	<E1CUq57-00043P-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411180959450.2222@ppc970.osdl.org>
	<E1CUquZ-0004Az-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411181027070.2222@ppc970.osdl.org>
	<E1CUrS0-0004Hi-00@dorka.pomaz.szeredi.hu> <20041118130601.6ee8bd97.akpm@osdl.org>
Message-Id: <E1CV6vf-0006q1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 19 Nov 2004 12:27:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Grab http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz and
> learn to drive run-bash-shared-mappings.sh.

Thanks Andrew, this indeed caused a deadlock.  Strangely the deadlock
happens much more easily if 'usemem' is not run in parallel with
'bash-shared-mapping'.

> > gets a medal
> 
> My emedals.com account awaits your contribution ;)

The medal is yours!

Apologies to everyone whom I disbelieved, and thanks for enlightening me.

The solution I'm thinking is along the lines of accounting the number
of writable pages assigned to FUSE filesystems.  Limiting this should
solve the deadlock problem.  This would only impact performance for
shared writable mappings, which are rare anyway.

Thanks,
Miklos
