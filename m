Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUD1LqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUD1LqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 07:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264752AbUD1LqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 07:46:16 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:62476 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264750AbUD1LqJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 07:46:09 -0400
Message-ID: <408F99D5.1010900@aitel.hist.no>
Date: Wed, 28 Apr 2004 13:47:33 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, pmarques@grupopie.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       malda@slashdot.org, c-d.hailfinger.kernel.2004@gmx.net,
       Linus Torvalds <torvalds@osdl.org>, jon787@tesla.resnet.mtu.edu
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca> <1083107550.30985.122.camel@bach> <47B669B0-98A7-11D8-85DF-000A95BCAC26@linuxant.com> <1083117450.2152.222.camel@bach> <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com>
In-Reply-To: <1EF114FF-98C4-11D8-85DF-000A95BCAC26@linuxant.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> 
> Dear Rusty,
> 
> We generally prefer to focus on making stuff work for users,
> rather than waste time arguing about controversial GPL politics.

There is no need to _argue_ about the GPL if you don't want to.
Just obey the terms.  If you don't, then you're arguing.

To me, the argument above looks like "we concentrate on making
things work for our customers, not on obeying the laws."  
An argument frequently used by people you probably don't want to be 
compared with. You probably didn't intend it that way, but that
what it looks like for those serious about the GPL.

> That's why after the practical workaround was done we moved on
> to deal with more acute technical issues at the time and failed
> to properly discuss/follow up on the matter with you. Please accept my
> sincere personal apology for this.
> 
> I would like however to point out that part of the reason why people
> sometimes resort to such kludges is that some kernel maintainers have
> been rather reluctant to accommodate proprietary drivers which
Do not be surprised that people don't want to support your driver for free.
Everything has a price. Business usually wants to be paid in money,
kernel coders tend to want payment in the form of GPL'ed code.

Not wanting to pay in code _is_ ok, but then you get to deal with any
trouble happening to any kernel running your module, because nobody
else volunteers.

> unfortunately are a necessary real-world evil (Linus told me just a few
> days ago that he didn't care and to "go away" after we requested a clean
> solution to handle larger kernel stacks for "foreign" NDIS drivers in a way
> that could perhaps coexist with the new 4K stacks used by default in
> recent 2.6.6/fedora kernels).

Well, sometimes design decisions simply doesn't go your way.  There may
indeed be no way to make Linus change his mind, so of course he tells you
to go away.  The same would happen if you tried to have microsoft make a
design change _they_ don't want.  You are lucky in the linux case though,
kernel developers may not support your NDIS driver but you _can_ supply
your own kernel patch (or a complete kernel) with big stacks.
Right now the 4k stack is relatively new, so the patch for 8k is simple.
In the future, there will probably be bigger pages and then your
problem goes away.  In the meantime you're allowed to maintain your
own patch for whatever you can't get into mainline.
> 
> Anyway, in an effort to reasonably resolve the \0 issue, to (hopefully) 
> mutual
> satisfaction I propose that we update our drivers to explicitly set the 
> tainted
> bit manually after they are loaded - perhaps via sysctl() or by running
> "echo 1 > /proc/sys/kernel/tainted" via {modules,modprobe}.conf,
> or simply changing the '\0' to ' ' in one of the modules' MODULE_LICENSE()
> macro, causing the kernel to be tainted upon load and the confusing 
> messages
> to appear once instead of 5-6 times in a row. The latter approach seems
> simple and straightforward. Would it be acceptable to you as a 
> compromise until
> your patch and hopefully something equivalent for 2.4 propagate to users?
> 
I believe you have to remove the \0 to operate legally (or release the 
full source under the GPL for real.)   

Your customer's problem is fixable though.  Either by also changing the logging level
so the message doesn't go out on the console, or by patching the line 
with that printk() out of your customer's kernel.
You can do this as a part of your install program.  If it gets too hard, consider
supplying the customer with your own precompiled kernel.

Helge Hafting

