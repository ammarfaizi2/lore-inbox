Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932793AbWCRPeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbWCRPeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 10:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932843AbWCRPeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 10:34:25 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:64152 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932793AbWCRPeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 10:34:24 -0500
Message-ID: <441C2856.30102@us.ibm.com>
Date: Sat, 18 Mar 2006 10:33:42 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Andrew Morton <akpm@osdl.org>, Oleg Nesterov <oleg@tv-sign.ru>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk,
       hch@lst.de, mtk-manpages@gmx.net, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Error if passed unsupported flags
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com>	<m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>	<441AF596.F6E66BC9@tv-sign.ru> <20060317125607.78a5dbe4.akpm@osdl.org> <m13bhf3i1z.fsf_-_@ebiederm.dsl.xmission.com>
In-Reply-To: <m13bhf3i1z.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks Eric. I had just started to do this based on Andrew's request.

-Janak

Eric W. Biederman wrote:

>This patch does a bare bones trivial patch to ensure we always
>get -EINVAL on the unsupported cases for sys_unshare.  If this
>goes in before 2.6.16 it allows us to forward compatible with
>future applications using sys_unshare.
>
>Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
>
>---
>
> kernel/fork.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)
>
>46868b4b6ebeb9042dded68a6f6301ffe06820c9
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 46060cb..411b10d 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -1535,6 +1535,12 @@ asmlinkage long sys_unshare(unsigned lon
> 	struct sem_undo_list *new_ulist = NULL;
> 
> 	check_unshare_flags(&unshare_flags);
>+       
>+	/* Return -EINVAL for all unsupported flags */
>+	err = -EINVAL;
>+	if (unshare_flags & ~(CLONE_THREAD|CLONE_FS|CLONE_NEWNS|CLONE_SIGHAND|
>+				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM))
>+		goto bad_unshare_out;
> 
> 	if ((err = unshare_thread(unshare_flags)))
> 		goto bad_unshare_out;
>  
>

