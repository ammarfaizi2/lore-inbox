Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262279AbSJJVyu>; Thu, 10 Oct 2002 17:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262379AbSJJVyt>; Thu, 10 Oct 2002 17:54:49 -0400
Received: from ns.suse.de ([213.95.15.193]:44551 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262279AbSJJVys>;
	Thu, 10 Oct 2002 17:54:48 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Steven French" <sfrench@us.ibm.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, jra@samba.org
Subject: Re: [BK PATCH] CIFS filesystem for Linux 2.5
References: <OFFB04937F.1EAC8996-ON87256C4E.006DA4CF@boulder.ibm.com.suse.lists.linux.kernel> <17092.1034284232@passion.cambridge.redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Oct 2002 00:00:32 +0200
In-Reply-To: David Woodhouse's message of "10 Oct 2002 23:17:56 +0200"
Message-ID: <p73it0aosxr.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> writes:

> sfrench@us.ibm.com said:
> >  fs/cifs/md4.c                      |  209 +++
> >  fs/cifs/md5.c                      |  363 +++++
> >  fs/cifs/md5.h                      |   38 
> 
> Unless these are somehow CIFS-specific, they should live in linux/lib/

This would have the disadvantage that they would need to be always compiled into the
kernel, even though it may not need it. And we already have code bloat problems,
no need to make it worse.

Making them modular also isn't good. Each module takes a 4k page at least, so you
would waste a lot of memory because they're smaller than 4k.

As long as they are not used by anything else it's probably best to keep it 
where they are.


-Andi
