Return-Path: <linux-kernel-owner+w=401wt.eu-S933226AbWLaVMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933226AbWLaVMS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 16:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933229AbWLaVMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 16:12:18 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:36538 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226AbWLaVMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 16:12:17 -0500
Subject: Re: [BUG 2.6.20-rc2-mm1] init segfaults when
	CONFIG_PROFILE_LIKELY=y
From: Daniel Walker <dwalker@mvista.com>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Fengguang Wu <fengguang.wu@gmail.com>, Hua Zhong <hzhong@gmail.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       mingo@elte.hu, johnstul@us.ibm.com
In-Reply-To: <20061231124358.3b0837c2.rdunlap@xenotime.net>
References: <20061231150422.GA5285@mail.ustc.edu.cn>
	 <1167594309.14081.79.camel@imap.mvista.com>
	 <20061231124358.3b0837c2.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sun, 31 Dec 2006 13:11:26 -0800
Message-Id: <1167599486.14081.89.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-12-31 at 12:43 -0800, Randy Dunlap wrote:
> On Sun, 31 Dec 2006 11:45:09 -0800 Daniel Walker wrote:
> 
> > On Sun, 2006-12-31 at 23:04 +0800, Fengguang Wu wrote:
> > > Hi,
> > > 
> > > The following messages keeps popping up when CONFIG_PROFILE_LIKELY=y:
> > > 
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > init[1]: segfault at ffffffff8118c110 rip ffffffff8118c110 rsp 00007fff9a9d14d8 error 15
> > > 
> > 
> > 
> > Does this seem like an appropriate solution? This just reconstitutes
> > Ingo's patch by removing the unlikely calls that got added recently. 
> 
> How does this fix the problem?  (if it does)
> What is the real cause of the problem?

Well I tested it so I sure hope it fixes it (unless I've gone mad). I
guess we can wait for Fengguang to test it tho.

> > Maybe a comment into vsyscall.c that says to stay away from all macro's
> > and possible debug code that could be added might be helpful ?
> 
> Why?

I don't know very much about vsyscalls, but from what I've read they
actually reside in userspace. So with and "unlikely" added into that
code, and profiling on, you will end up calling do_check_likely() which
is in kernel space that's how the segfault happens. 

I imagine this goes for all debugging in kernel space, you can't add it
into a vsyscall. That's my reasoning behind adding a comment.

Daniel

