Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271174AbUJVLIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271174AbUJVLIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271182AbUJVLIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:08:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:5863 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271174AbUJVLIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:08:22 -0400
Date: Fri, 22 Oct 2004 04:06:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Seth Arnold <sarnold@immunix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setterm -msg off broken in 2.6.9
Message-Id: <20041022040621.30f8c1bf.akpm@osdl.org>
In-Reply-To: <20041019063344.GC4415@immunix.com>
References: <20041019063344.GC4415@immunix.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth Arnold <sarnold@immunix.com> wrote:
>
> Hello, I'm using 2.6.9 on my ibook g3 700mhz, debian unstable.
> 
> I use setterm -msg off to turn off kernel log buffer to console from
> time to time. It now reports an error:
> $ setterm -msg off
> klogctl error: Unknown error 4294967295
> 
> kernel log messages are still printed to the console.
> 

I assume that's because:

2643  syslog(0x6, 0, 0)                 = -1 EPERM (Operation not permitted)

but cap_syslog() has disallowed command 6 for a long time.

It seems reasonable to be able to kill console messages if the user is
using the console, but from my reading current 2.4 kernels will fail this
if you're not root as well.

With what kernel were you able to run `setterm -msg' without being root?
