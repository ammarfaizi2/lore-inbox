Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751609AbWGQBVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbWGQBVg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 21:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbWGQBVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 21:21:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:19915 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751283AbWGQBVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 21:21:35 -0400
Message-ID: <44BAE619.9010307@namesys.com>
Date: Sun, 16 Jul 2006 18:21:29 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com>
In-Reply-To: <44BABB14.6070906@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

> Hans Reiser wrote:
>
>
> Hans, we're all in agreement that we'd prefer drivers not use names with
> slashes in them,

there is nothing wrong with using names that have slashes.  The thing
that is wrong is somehow needing to translate them into names with "!"'s. 

> and it would be nice to correct drivers currently using
> them. The problem is that when you change the name of a device, that's a
> userspace visible change. 

So don't.  Why would user space care how you parse it and whether the
driver or reiserfs does it?

> Scripts that currently expect, say,
> /proc/partitions to contain cciss/<number> will break between kernel
> versions. Sysfs wants to use the device name as a pathname component,
> and as such translates the / to a !, the same as this patch proposes.
>
> Reiserfs gets involved because it expects that name to be usable as a
> file system pathname component when it is not intended to be one without
>  translating slashes into another character. The difference is that
> block device names are allowed to have slashes in them, while normal
> file system names are not. 

We should distinguish here between names and name components. 

> The fact is that device driver names, when in
> /dev can use separate components, like /dev/cciss/0, but when used in
> the manner reiserfs wants them to be used, they can't. Also, I'm not
> talking about name spaces like struct namespace, I mean that the group
> of names that block device drivers use have different constraints than
> the group of names that are allowable as file names.
>
> The fact is that this change is required for users deploying devices
> that use slashes in their names to see the proc data for a reiserfs file
> system. You can point the finger all you want at the block drivers in
> the mean time, but it's still a reiserfs problem.

I still do not grok why you need to change / to !.

Something is wrong.  Reiserfs is being asked to do something that
somebody else should be doing.

Hans
