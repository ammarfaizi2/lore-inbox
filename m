Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266451AbUFQKyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266451AbUFQKyU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 06:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUFQKyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 06:54:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:55454 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266451AbUFQKyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 06:54:20 -0400
Date: Thu, 17 Jun 2004 03:53:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: Patch: 2.6.7/fs/dnotify.c - make dn_lock a regular spinlock
Message-Id: <20040617035313.6e1d6d93.akpm@osdl.org>
In-Reply-To: <20040617163826.A4558@freya>
References: <20040617163826.A4558@freya>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> wrote:
>
> 	In the near future, I expect to try to eliminate dn_lock by
>  using parent_inode->i_sem instead, as the kmem_cache_t in dnotify.c
>  does not need to be protected by a separate lock.

inode->i_lock would be better.  Take care to keep it an "innermost" VFS
lock though.  Move kmem_cache_free() outside the lock altoghter.
