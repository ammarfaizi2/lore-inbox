Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWDDW0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDDW0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 18:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWDDW0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 18:26:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750797AbWDDW0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 18:26:03 -0400
Date: Tue, 4 Apr 2006 15:24:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, "Stone Wang" <pwstone@gmail.com>
Subject: Re: 2.6.17-rc1-mm1: mlockall() regression on x86_64
Message-Id: <20060404152454.6e7541ad.akpm@osdl.org>
In-Reply-To: <200604042253.06378.rjw@sisk.pl>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<200604042253.06378.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Tuesday 04 April 2006 10:45, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17-rc1/2.6.17-rc1-mm1/
> 
> With this kernel mlockall(MCL_CURRENT | MCL_FUTURE) returns -EFAULT if called
> by root (unconditionally, it seems) on x86_64.
> 
> On my box the output of:
> 
> #include <sys/mman.h>
> #include <stdio.h>
> #include <string.h>
> #include <errno.h>
> 
> int main()
> {
> 	int ret;
> 
> 	ret = mlockall(MCL_CURRENT | MCL_FUTURE);
> 	if (ret < 0)
> 		printf("%s\n", strerror(errno));
> 
> 	return 0;
> }
> 
> is "Bad address", if run by root.
> 

Yes, me too.  It works OK on x86_32.

It's due to mm-posix-memory-lock.patch.  I'd guess that
make_pages_present() is returning -EFAULT for some reason.

