Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbTH2Pvz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTH2Pvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:51:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:22757 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261335AbTH2Pvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:51:54 -0400
Date: Fri, 29 Aug 2003 08:35:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm3
Message-Id: <20030829083540.58c9dd47.akpm@osdl.org>
In-Reply-To: <3F4F22D3.9080104@freemail.hu>
References: <3F4F22D3.9080104@freemail.hu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Boszormenyi Zoltan <zboszor@freemail.hu> wrote:
>
> I tried to "make modules_install" on the compiled tree.
> It says:
> 
> # make modules_install
> Install a current version of module-init-tools
> See http://www.codemonkey.org.uk/post-halloween-2.5.txt
> make: *** [_modinst_] Error 1
> 
> But I have installed it! It's called modutils-2.4.25-8
> (was -5 previously) from RH rawhide, it works on older
> (2.6.0-test4-mm1) kernels.
> This modutils is united with module-init-tools-0.9.12,
> it reports version 2.4.25 but detects newer kernels and uses
> the new module interface.

Tricky.

It's wrong of the Red Hat package to misidentify itself in this manner.

It would sort-of make sense for `depmod -V' to autodetect the kernel
version and print either "modutils" or "module-init-utils".  But that's not
accurate either: a `make modules_install' would fail when performed under a
2.4 kernel.

So yes, I think that your patch to RH modutils+module-init-tools is the best
approach: after all, it tells the truth.

Meanwhile, I'll alter Valdis's patch so that it warns, but does not fail
the make.

