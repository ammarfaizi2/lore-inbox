Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271140AbTHHADY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271141AbTHHADY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:03:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:25033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271140AbTHHADX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:03:23 -0400
Date: Thu, 7 Aug 2003 17:05:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm5 working on ppc
Message-Id: <20030807170518.05155923.akpm@osdl.org>
In-Reply-To: <16178.56121.743989.77396@cargo.ozlabs.ibm.com>
References: <16178.56121.743989.77396@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> This patch gets 2.6.0-test2-mm5 to boot on my G3 powerbook.  The first
> problem was that we had dev_t in struct stat, thus userland became
> unhappy when dev_t changed size.

OK.

> The second problem was that sys_mknod got changed to take an unsigned
> int rather than a dev_t, but we were still calling it with a dev_t
> argument in init/do_mounts.h and init/initramfs.c.  That might sorta
> work on x86 but it doesn't on ppc.  My solution to that is to export
> and use do_mknod instead.

Well yes.  The reason for this problem is that people keep on putting
function prototypes into .c files.

I might add that the major sinners are maintainers of non-ia32
architectures.

>  Of course the do_mknod prototype should
> really go in a header somewhere but I was too lazy to do that.

I'll find somewhere to tuck it.  Thanks for working all that out.

