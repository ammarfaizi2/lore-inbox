Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVDQXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVDQXxm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 19:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDQXxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 19:53:41 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:15748 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261570AbVDQXxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 19:53:22 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
To: Eric Van Hensbergen <ericvh@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Reply-To: 7eggert@gmx.de
Date: Mon, 18 Apr 2005 01:52:41 +0200
References: <3Ki1W-2pt-1@gated-at.bofh.it> <3S8oM-So-13@gated-at.bofh.it> <3S8oN-So-15@gated-at.bofh.it> <3S8oN-So-17@gated-at.bofh.it> <3S8oN-So-19@gated-at.bofh.it> <3S8oN-So-21@gated-at.bofh.it> <3S8oN-So-23@gated-at.bofh.it> <3S8oN-So-25@gated-at.bofh.it> <3S8oN-So-27@gated-at.bofh.it> <3S8oM-So-7@gated-at.bofh.it> <3UmnD-6Fy-7@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DNJZD-0006vK-11@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen <ericvh@gmail.com> wrote:
> On 4/11/05, Miklos Szeredi <miklos@szeredi.hu> wrote:

>> 
>>   1) Only allow mount over a directory for which the user has write
>>      access (and is not sticky)
>> 
>>   2) Use nosuid,nodev mount options
[...]

> Do these solve all the security concerns with unprivileged mounts, or
> are there other barriers/concerns?  Should there be ulimit (or rlimit)
> style restrictions on how many mounts/binds a user is allowed to have
> to prevent users from abusing mount privs?

Definitively. Mountpoints use kernel space, the users could DoS the machine.
The per-Machine-limit isn't fine-grained enough, since the users may DoS
each other.

You'll have to avoid users capturing system daemons in D state or in
slowed-down artificial directory-forests, too. I think namespaces will
do most the trick.

> I was thinking about this a while back and thought having a user-mount
> permissions file might be the right way to address lots of these
> issues.  Essentially it would contain information about what
> users/groups were allowed to mount what sources to what destinations
> and with what mandatory options.

Users being able to mount random fs containing suid or device nodes
are root whenever they want to. If you want to mount with dev or suid,
use sudo and restrict the mount to a limited set of images/devices/whatever.
-- 
Anger, fear, aggression. The Dark Side of the Force are they.
Once you start down the Dark Path, forever will it dominate your destiny.
        -- Jedi Master Yoda

