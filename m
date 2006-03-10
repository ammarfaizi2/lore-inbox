Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWCJCuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWCJCuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 21:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbWCJCuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 21:50:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23776 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750733AbWCJCuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 21:50:04 -0500
Date: Thu, 9 Mar 2006 18:47:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Markus Gutschke <markus@google.com>
Cc: linux-kernel@vger.kernel.org, dkegel@google.com
Subject: Re: [PATCH 1/1] x86: Make _syscallX() macros compile in PIC mode on
 i386
Message-Id: <20060309184759.591e3551.akpm@osdl.org>
In-Reply-To: <4410BB32.1020905@google.com>
References: <4410BB32.1020905@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Gutschke <markus@google.com> wrote:
>
> Gcc reserves %ebx when compiling position-independent-code on i386. This 
>  means, the _syscallX() macros in include/asm-i386/unistd.h will not 
>  compile. This patch is against 2.6.15.6 and adds a new set of macros 
>  which will be used in PIC mode. These macros take special care to 
>  preserve %ebx.

But we don't compile the kernel with -fpic...  We might want to, for kdump
convenience at some stage, perhaps.

If we do, it'd be better to simply replace those _syscallX functions with
versions which work in either mode, rather than having two versions.

The syscallX() macros are almost obsolete - it's preferred that code simply
include syscalls.h and call sys_foo() directly.  But there are a few
hard-to-convert places, iirc.

