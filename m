Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbWJCI56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbWJCI56 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 04:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWJCI56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 04:57:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33213 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932547AbWJCI55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 04:57:57 -0400
Subject: Re: [PATCH] namespaces: utsname: implement utsname namespaces
From: David Woodhouse <dwmw2@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Serge Hallyn <serue@us.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>, Andrey Savochkin <saw@sw.ru>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200610021601.k92G10p6003499@hera.kernel.org>
References: <200610021601.k92G10p6003499@hera.kernel.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 09:57:50 +0100
Message-Id: <1159865871.3438.60.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-6.fc6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 16:01 +0000, Linux Kernel Mailing List wrote:
> commit 4865ecf1315b450ab3317a745a6678c04d311e40
> tree 6cf5d3028f8642eba2a8094eb413db080cc9219c
> parent 96b644bdec977b97a45133e5b4466ba47a7a5e65
> author Serge E. Hallyn <serue@us.ibm.com> 1159780694 -0700
> committer Linus Torvalds <torvalds@g5.osdl.org> 1159801041 -0700
> 
> [PATCH] namespaces: utsname: implement utsname namespaces
> 
> This patch defines the uts namespace and some manipulators.
> Adds the uts namespace to task_struct, and initializes a
> system-wide init namespace.
> 
> It leaves a #define for system_utsname so sysctl will compile.
> This define will be removed in a separate patch.

> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -1,6 +1,11 @@
>  #ifndef _LINUX_UTSNAME_H
>  #define _LINUX_UTSNAME_H
>  
> +#include <linux/sched.h>
> +#include <linux/kref.h>
> +#include <linux/nsproxy.h>
> +#include <asm/atomic.h>
> +
>  #define __OLD_UTS_LEN 8

This patch was not tested with 'make headers_check':

usr/include/linux/utsname.h requires linux/kref.h, which does not exist in exported headers
usr/include/linux/utsname.h requires linux/nsproxy.h, which does not exist in exported headers
usr/include/linux/utsname.h requires asm/atomic.h, which does not exist in exported headers

Please protect stuff with #ifdef __KERNEL__ as appropriate, and remember
to run 'make headers_check' before submitting patches.

-- 
dwmw2

