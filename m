Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265784AbUHAO4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUHAO4F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 10:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUHAO4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 10:56:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:52904 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265784AbUHAOzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 10:55:48 -0400
From: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Organization: Deban GNU/Linux Homesite
In-Reply-To: <20040801102231.GB6295@dualathlon.random>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.5-20040615 ("Gighay") (UNIX) (Linux/2.6.5 (i686))
Message-Id: <E1BrHkZ-0004hd-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sun, 01 Aug 2004 16:55:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040801102231.GB6295@dualathlon.random> you wrote:
> /proc/sys/kernel/security_sequence [1] or anything like that that we
> could increase every time we fix a kernel bug (note, it's not mandatory
> to increase it every time, and we could increase it even weeks after the
> bug has been fixed after somebody ask for it, and it would still work
> fine)

Hmm.. yes, kind of patchlevel/build number.

I feel that you miss a solution for different branches, backporting and
partial fixes. Since that way it can only work for the official branches of
the kernel, it would be enough to check the minor number.

Personally I think it is better to keep that in the utsname.release. If you
realy want to have an integer, then add it for easy parsing and allow it to
have multiple parallel issuers:

For example like:

2.6.9_XXX(linux26.3501,MM.123)

where this has applied fix 3501 in the 2.6 branch and 123 according to
vendor MM, so you do not need to understand vendors XXX schema. However I am
not sure if you are willing to accept the fact, that backporters will then
raise the level to a value you will only expect for more recent versions,
i.e.:

2.6.9(linux26.3501)
-> security bug1 is discoverd and fixed
2.6.10pre1(linux26.3502)
-> security bug2 is discoverd and fixed
-> features are added
2.6.10(linux26.3503)

Now  somebody  decides to backport the bug1 fix:

2.6.9-2(linux26.3502)

and the bug2 fix:

2.6.9-3(linux26.3503) <- is level 3503 but does not have all 2.6.10 features?!

And it gets even more hairy: if only the bug2 fix is
backported, how can an application state that it needs that (without
impliciteley also reling on bug1 to be fixed)

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
