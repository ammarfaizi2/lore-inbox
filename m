Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTEAE6S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 00:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbTEAE6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 00:58:18 -0400
Received: from air-2.osdl.org ([65.172.181.6]:30433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262363AbTEAE6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 00:58:15 -0400
Message-ID: <33490.4.64.196.31.1051765837.squirrel@www.osdl.org>
Date: Wed, 30 Apr 2003 22:10:37 -0700 (PDT)
Subject: Re: Loading a module multtiple times
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rusty@rustcorp.com.au>
In-Reply-To: <20030501050235.045232C051@lists.samba.org>
References: Your
        message
        of
        "Wed,
        30
        Apr
        2003
        14:05:57
        MST."
        <20030501050235.045232C051@lists.samba.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In message <20030430140557.12e13f1a.rddunlap@osdl.org> you write:
>>
>> Hi Rusty-
>>
>> I was looking into a bug in /proc/net/dev truncated output.
>> /proc/net/dev lists {if (!buggy)} all loaded network interfaces.
>>
>> To get a large number of network interfaces, Christian (below)
>> told me to copy driver/net/dummy.o to several different file names and
>> then insmod them.  It seems to have worked for him, and it works that way
>> in 2.4.recent, but it's not working for me.  See error
>> messages below.
>>
>> Which way is expected behavior?
>> What should be the expected behavior?
>> or am I just seeing bugs (failures) that noone else sees?
>
> No, it's a 2.5 thing: modules know their own name.  This is because (1) the
> names are used to set new-style boot parameters, (2) needing to insert two
> modules is usually wrong, since how would that work if the module was
> built-in?
>
> It also opens us up to the possibility of a list of built-in modules, if we
> wanted to.
>
> However, the -o option to modprobe replaces the module name (by
> hacking the elf object, yes), because programmers are basically lazy, and
> multiple modules are useful for testing.
>
> So, you want:
> 	for i in `seq 1 100`; do modprobe -o dummy$i dummy; done
>
> This works on 2.4 as well.  Note that insmod doesn't support -o, being a
> trivial program by design.

Argh, I looked thru insmod.c but not modprobe.c for a solution.

>> It seems like not supporting this is likely to cause some problems.
>
> Yes.  Removing any feature causes problems 8(.  But adding every
> feature is usually worse.
>
> Hope this clarifies?

Yes, thanks much.

~Randy



