Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933272AbWKNAka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933272AbWKNAka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 19:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933273AbWKNAka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 19:40:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:41153 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S933272AbWKNAk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 19:40:29 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: akpm@osdl.org
Subject: Re: + fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch added to -mm tree
Date: Tue, 14 Nov 2006 01:38:18 +0100
User-Agent: KMail/1.9.5
Cc: suzuki@linux.vnet.ibm.com, davem@davemloft.net, suzuki@in.ibm.com,
       linux-kernel@vger.kernel.org
References: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net>
In-Reply-To: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611140138.19111.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 00:58, akpm@osdl.org wrote:

> Subject: Fix compat space msg size limit for msgsnd/msgrcv
> From: suzuki <suzuki@linux.vnet.ibm.com>
> 
> Currently we allocate 64k space on the user stack and use it the msgbuf for
> sys_{msgrcv,msgsnd} for compat and the results are later copied in user [by
> copy_in_user].
> 
> This patch introduces helper routines for sys_{msgrcv,msgsnd} which would
> accept the pointer to msgbuf along with the msgp->mtext.  This avoids the
> need to allocate the msgsize on the userspace (thus removing the size
> limit) and the overhead of an extra copy_in_user().
> 
> Signed-off-by: Suzuki K P <suzuki@in.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

This patch is definitely a big step in the right direction here, but why 
not go all the way and pass msgp->mtype to do_msgsnd/do_msgrcv as kernel
data instead of a user space pointer? This way you can get rid of the
compat_alloc_userspace entirely and save avoid doing an extra 
put_user/get_user pair in the compat_ function.

	Arnd <><
