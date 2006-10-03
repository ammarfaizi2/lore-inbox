Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965312AbWJCJDN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbWJCJDN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 05:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWJCJDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 05:03:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27023 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932563AbWJCJDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 05:03:12 -0400
Subject: Re: [PATCH] IPC namespace core
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@openvz.org>,
       Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200610021601.k92G13mT003934@hera.kernel.org>
References: <200610021601.k92G13mT003934@hera.kernel.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 10:02:54 +0100
Message-Id: <1159866174.3438.66.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 16:01 +0000, Linux Kernel Mailing List wrote:
> commit 25b21cb2f6d69b0475b134e0a3e8e269137270fa
> tree cd9c3966408c0ca5903249437c35ff35961de544
> parent c0b2fc316599d6cd875b6b8cafa67f03b9512b4d
> author Kirill Korotaev <dev@openvz.org> 1159780699 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> 1159801042 -0700
> 
> [PATCH] IPC namespace core
> 
> This patch set allows to unshare IPCs and have a private set of IPC objects
> (sem, shm, msg) inside namespace.  Basically, it is another building block of
> containers functionality.
> 
> This patch implements core IPC namespace changes:
> - ipc_namespace structure
> - new config option CONFIG_IPC_NS
> - adds CLONE_NEWIPC flag
> - unshare support
> 
> [clg@fr.ibm.com: small fix for unshare of ipc namespace]
> [akpm@osdl.org: build fix]
> Signed-off-by: Pavel Emelianov <xemul@openvz.org>
> Signed-off-by: Kirill Korotaev <dev@openvz.org>
> Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

> --- a/include/linux/ipc.h
> +++ b/include/linux/ipc.h
> @@ -2,6 +2,7 @@ #ifndef _LINUX_IPC_H
>  #define _LINUX_IPC_H
>  
>  #include <linux/types.h>
> +#include <linux/kref.h>
>  
>  #define IPC_PRIVATE ((__kernel_key_t) 0)  
>  

You need to move the #include down the file by about 50 lines so it
lands inside the existing #ifdef __KERNEL__.

All those signed-off-bys and _none_ of you managed to notice that
<linux/kref.h> doesn't exist in the headers we export to userspace,
despite the fact that just running 'make headers_check' would have
shouted at you about it?

Bad hacker. No biscuit.

-- 
dwmw2

