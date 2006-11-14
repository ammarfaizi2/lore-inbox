Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966469AbWKNXYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966469AbWKNXYs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966470AbWKNXYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:24:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:1265 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S966469AbWKNXYr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:24:47 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: suzuki <suzuki@linux.vnet.ibm.com>
Subject: Re: + fix-compat-space-msg-size-limit-for-msgsnd-msgrcv.patch added to -mm tree
Date: Wed, 15 Nov 2006 00:24:24 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <200611132358.kADNwF0V012270@shell0.pdx.osdl.net> <200611141049.36145.arnd@arndb.de> <455A3392.6040501@linux.vnet.ibm.com>
In-Reply-To: <455A3392.6040501@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200611150024.25647.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 November 2006 22:22, suzuki wrote:
> Does the following change look fine ?
> 
> do_msgsnd() - Accepting the mtype and user space ptr to the mtext. i.e.,
> 
> long do_msgsnd(int msqid, long mtype, void __user *mtext,
>                 size_t msgsz, int msgflg);
> and,
> 
> do_msgrcv() - accepting the kernel space data ptr to pmtype and user 
> space ptr to mtext. The caller has to copy the *pmtype back to the user 
> space.
> 
> i.e.,
> 
> long do_msgrcv(int msqid, long *pmtype, void __user *mtext,
>                         size_t msgsz, long msgtyp, int msgflg);

Yes, that looks fine.

> Can we use the kernel space "struct msgbuf" instead of the mtype being 
> passed explicitly.

That works as well, although it may be a little confusing to have
the extra mtext byte of that structure included there, so I'd prefer
the first solution.

	Arnd <><
