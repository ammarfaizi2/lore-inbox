Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030528AbVLWN7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030528AbVLWN7b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 08:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbVLWN7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 08:59:31 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:60802 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030528AbVLWN7a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 08:59:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=rOti+YSLy5O+Uvo+JMwTWnLJyZXIK5/A0JTd1DBd/lkfVHLJ1CT3kVZeb5QAKFo5ta7VJvEnHXa5DG1Nwy4RPjn2HJbGb8YPH6WvpmysYgPvmwjb/E6nMUu3NgFW35OWE+iXgMj8Cjl/eXJr7bd7w5Q1aJJQV6SO1sIvfwggx1U=
Date: Fri, 23 Dec 2005 14:59:10 +0100
From: Diego Calleja <diegocg@gmail.com>
To: 7eggert@gmx.de
Cc: harvested.in.lkml@7eggert.dyndns.org, vonbrand@inf.utfsm.cl,
       kernel-stuff@comcast.net, Dumitru.Ciobarcianu@iNES.RO,
       helge.hafting@aitel.hist.no, ak@suse.de, bunk@stusta.de,
       mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051223145910.26ddcf17.diegocg@gmail.com>
In-Reply-To: <E1Epjug-0001iA-In@be1.lrz>
References: <5lQOU-492-31@gated-at.bofh.it>
	<5lQOU-492-29@gated-at.bofh.it>
	<E1Epjug-0001iA-In@be1.lrz>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Fri, 23 Dec 2005 11:12:38 +0100,
Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> escribió:

> +               printk(KERN_WARNING, "Can't allocate new task structure"
> +#ifndef CONFIG_4KSTACKS
> +               ". Maybe you could benefit from 4K stacks.\n"
> +#endif
> +               "\

A sarcastic patch, nice. So, lets try to get something useful
from this flamewar...sight.


The 4k patch is being proposed for -mm. Personally I'm _shocked_ that so
many people is trying to avoid _testing_ (-mm is for testing, isn't it)
this feature so hard. Which is surprising, since merging it into -mm
may prove that they're right (people will report bugs caused by 4k
stacks, etc). Maybe 8k groupies are not willing to be proved that
they're right, or they're afraid of being proven that they're
wrong? </sarcasm>

Now, seriously:
I think that most of the 8k groupies don't like 4k not because it
doesn't works in the common case, but because it could cause hangs
that are not easy to reproduce (ie: they are paranoid). The combination
of code paths is too big and complex. I can understand that.

What I don't know is why you think that 8k will be "safe". As far
as I know, there're have been stacks overflows with 8KB stacks in
the past (ie, "hangs that are not easy to reproduce") before the 4k
stack patch was proposed, and the _one_ reason why now it's very
safe to run with 8k stacks is because the 4k stack patch has forced
people to do stack diets, not because 8k is the best option.

We have *NO* *WAY* of proving that it's safe to run either 4k or
8k stacks. Face it. And since such bugs can exist no matter what
stack size you use, the best option (IMO) is to choose the option that
will allow us to hit those bugs _faster_, ie: 4k stacks. From a
engineering point of view, I can't understand why hiding the problem
is better than choosing the path that will allow to hit and fix those
bugs faster. It remembers me of "security through obscurity". What 
we will do when we have too may overflows with 8K? 16K stacks? Oh,
let me guess: "we'll fix it"?. Well, and why can't we fix 4k stacks???

Now, the code is easy to maintain and some people depends on
8k stacks, as akpm pointed out in http://lkml.org/lkml/2005/12/15/336
This patch (http://lkml.org/lkml/2005/12/16/89) stolen from^W^Winspired
by Adrian Bunk defaults to 4k, makes the 8k people happy and it should
make akpm happy too.

Can someone tell me a reason why all this stupid flamewar can't be
solved with that patch?
