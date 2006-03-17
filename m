Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWCQRsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWCQRsM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030234AbWCQRsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:48:12 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:43971 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030233AbWCQRsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:48:10 -0500
Message-ID: <441AF596.F6E66BC9@tv-sign.ru>
Date: Fri, 17 Mar 2006 20:44:54 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Janak Desai <janak@us.ibm.com>,
       Al Viro <viro@ftp.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
       Michael Kerrisk <mtk-manpages@gmx.net>, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] unshare: Use rcu_assign_pointer when setting sighand
References: <m1y7za9vy3.fsf@ebiederm.dsl.xmission.com> <m1pskm9tz9.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> @@ -1573,7 +1573,7 @@ asmlinkage long sys_unshare(unsigned lon
> 
>                 if (new_sigh) {
>                         sigh = current->sighand;
> -                       current->sighand = new_sigh;
> +                       rcu_assign_pointer(current->sighand, new_sigh);
>                         new_sigh = sigh;
>                 }

Isn't it better to just replace this code with
'BUG_ON(new_sigh != NULL)' ?

It is never executed, but totally broken, afaics.
task_lock() has nothing to do with ->sighand changing.

Oleg.
