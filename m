Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTGGUvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 16:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264476AbTGGUvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 16:51:47 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264450AbTGGUvp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 16:51:45 -0400
Date: Mon, 7 Jul 2003 14:00:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, devfs@oss.sgi.com
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined
 patch
Message-Id: <20030707140010.4268159f.akpm@osdl.org>
In-Reply-To: <200307072306.15995.arvidjaar@mail.ru>
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru>
	<20030706120315.261732bb.akpm@osdl.org>
	<20030706175405.518f680d.akpm@osdl.org>
	<200307072306.15995.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Borzenkov <arvidjaar@mail.ru> wrote:
>
> I finally hit a painfully trivial way to reproduce another long standing devfs 
> problem - deadlock between devfs_lookup and devfs_d_revalidate_wait.

uh.

> The current fix is to move re-acquire of i_sem after all 
> devfs_d_revalidate_wait waiters have been waked up.

Directory modifications appear to be under write_lock(&dir->u.dir.lock); so
that obvious problem is covered.  Your patch might introduce a race around
_devfs_get_vfs_inode() - two CPUs running that against the same inode at
the same time?

> Andrew, I slightly polished original stack corruption version to look more 
> consistent with the rest of devfs;

I think it's Lindent time.


