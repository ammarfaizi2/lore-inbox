Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWF3XXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWF3XXm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 19:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWF3XXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 19:23:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19365 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932233AbWF3XXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 19:23:41 -0400
Date: Fri, 30 Jun 2006 16:26:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.17-mm4
Message-Id: <20060630162625.2fe3b6cc.akpm@osdl.org>
In-Reply-To: <44A57970.7020501@roarinelk.homelinux.net>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	<44A57970.7020501@roarinelk.homelinux.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
>
> Hello,
> 
> With the attached .config, the kernel reliably panics when someone
> issues a 'sync' (or the kernel decides to write back its buffers):
> 
> reiser4 panicked cowardly: reiser4[sync(8465)]: commit_current_atom (fs/reiser4/txnmgr.c:1062)[zam-597]:
> Kernel panic - not syncing: reiser4[sync(8465)]: commit_current_atom (fs/reiser4/txnmgr.c:1062)[zam-597]:
> 
> (this is all that is printed)
> 
> This happens only with Reiser4 and libata ata_piix driver; it does not
> happen with Reiser4 and 'old' IDE piix driver. Other fs are also not
> affected. I have no idea how to track this, I hope someone else does :)
> 
> Hardware is a pentium-m laptop with ICH4 pata.
> 

Interesting, thanks.

My guess would be that there's a difference in the way in which the two
drivers handle write barriers, and the new driver has confused the reiser4
code.

Are you able to identify any earlier -mm kernel which ran OK with reiser4
and ata_piix?

