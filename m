Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVDPEGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVDPEGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 00:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVDPEGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 00:06:48 -0400
Received: from fmr18.intel.com ([134.134.136.17]:60907 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262613AbVDPEGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 00:06:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16992.36594.442613.936961@sodium.jf.intel.com>
Date: Fri, 15 Apr 2005 21:05:06 -0700
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Inaky Perez-Gonzalez <inaky@linux.intel.com>, Bill Huey <bhuey@lnxw.com>,
       dwalker@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: FUSYN and RT
In-Reply-To: <1113618713.4294.126.camel@localhost.localdomain>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk>
	<1113352069.6388.39.camel@dhcp153.mvista.com>
	<1113407200.4294.25.camel@localhost.localdomain>
	<20050415225137.GA23222@nietzsche.lynx.com>
	<16992.20513.551920.826472@sodium.jf.intel.com>
	<1113614062.4294.102.camel@localhost.localdomain>
	<16992.26700.512551.833614@sodium.jf.intel.com>
	<1113615510.4294.113.camel@localhost.localdomain>
	<16992.28724.665847.46695@sodium.jf.intel.com>
	<1113618713.4294.126.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 2005-04-15 at 18:53 -0700, Inaky Perez-Gonzalez wrote:
>> >>>>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> I see--would the following fit your view?
>> 

> I think it's time that I take a look at the fusyn code. I don't have
> all the emails on this thread, could you point out to me where I can
> see the latest fusyn patch. Thanks.

http://developer.osdl.org/dev/robustmutexes/fusyn/20040510

There you have the a full patch against 2.6.10, against the previous
stable release (2.3.1) and the patch broken up in parts (the first one
001.msg has the index). 

You want 016.msg and 020.msg, the ones that implement fulocks (the
mutexes) and user space fulocks. 

013.msg has all the priority change engine (along with the queues);
__fuqueue_waiter_chprio() is the function.

In the same page site, up a couple of levels, three is info on how to
grab it from CVS. There is also the OLS 2004 stuff which explains
things in detail.

> It's getting late where I am, and I'm getting tired, so I'm a little
> slow right now.  Is what you are showing me here what is currently
> in fusyn or a proposal with the merging of Ingo's rt_mutex?  Reason
> why I'm asking, is what's the difference between the owner here and
> in fuqueue's spin_lock?

This is all without taking into account Ingo's work (you could say it
is kind of parallel/redundant/etc). In any case, to sum up w/ what
Sven said, the spinlock would be a raw_spinlock_t when that makes it
into the kernel. It just protects access to the fuqueue/fulock/ufulock
structures. 

>> This has an in kernel API so you can use it from modules or kernel
>> code.
>> ...

> This above structure would represent the user space wrapper
> structure that I meant with the fusyn structure containing the
> rt_mutex lock.  Right?

Yep

> Also in the above, is the fuqueue_ops the ops we mentioned earlier
> as the links into PI?

Yes and no.

Yes because the ops are there to be able to be able to do the kind of
things that user space mutexes need done differently (look for the
fu*_op_* functions--or fulock_ops and ufulock_ops).

However, in the case of the PI handling--that is just priority change
handling--the op is the same for both fulocks and user space fulocks.

But the priority change handling is different for queues, so you need
an op to distinguish.

> Sorry about being totally ignorant here, but it's the end of the day
> for me, and I'm starting to feel burnt out.

That's when you do 'shutdown -h now' and go for a beer :)

-- 

Inaky

