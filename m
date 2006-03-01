Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbWCAGVA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbWCAGVA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 01:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWCAGVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 01:21:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18857 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932488AbWCAGVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 01:21:00 -0500
Date: Tue, 28 Feb 2006 22:19:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Max Kellermann <max@duempel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc[1-5]: soft lockups on Athlon64 X2
Message-Id: <20060228221948.3d76f80b.akpm@osdl.org>
In-Reply-To: <20060227122705.GA27141@roonstrasse.net>
References: <20060227122705.GA27141@roonstrasse.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann <max@duempel.org> wrote:
>
> the kernel 2.6.16-rc5 is receiving soft lockups when being run in SMP
>  mode.  When booting with "nosmp" (same kernel), everything is fine.
>  Hardware: Asus A8N-SLI (nForce4), Athlon64 X2.  I also tested rc1,
>  rc3, rc4, same error - 2.6.15.4 is ok.
> 
>  The soft lockups always occur when I try to mount a dm-crypted XFS
>  partition (another dm-crypted reiserfs partition on the same disk has
>  been mounted previously - both AES).

Strange.  I did remove a cond_resched() from invalidate_mapping_pages() so
that it could be run under spinlock but I cannot believe that you had so
many pages cached that the invalidate took more than ten seconds.

Does the machine recover and otherwise work OK?

Does it appear to you that the mount _really_ took over ten seconds system
CPU time??
