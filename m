Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262803AbUCJUTD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 15:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUCJUTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 15:19:03 -0500
Received: from news.cistron.nl ([62.216.30.38]:1261 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262823AbUCJUSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 15:18:53 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: /dev/root: which approach ? [PATCH]
Date: Wed, 10 Mar 2004 20:18:52 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c2nt7c$r32$1@news.cistron.nl>
References: <20040310162003.GA25688@cistron.nl> <20040310120145.248ae62d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1078949932 27746 62.216.29.200 (10 Mar 2004 20:18:52 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040310120145.248ae62d.akpm@osdl.org>,
Andrew Morton  <akpm@osdl.org> wrote:
>Miquel van Smoorenburg <miquels@cistron.nl> wrote:
>>
>> Currently if you boot from a blockdevice with a dynamically
>> allocated major number (such as LVM or partitionable raid),
>> there is no way to check the root filesystem. The root
>> fs is still read-only, so you cannot create a device node
>> anywhere to point fsck at.
>> 
>> This was discussed on the linux-raid mailinglist, and I proposed
>> (as proof of concept) a simple check in bdget() to see if the
>> device is being opened is the /dev/root node and if so redirect
>> it to the current root device. This is a 8-line patch, the only
>> disadvantage I can think of is that for an open file, inode->i_rdev
>> is then different from blockdevice->bd_dev.
>
>The /dev/root alias resolution looks nice to me, which probably means that
>it has a fatal flaw.
>
>Is it not possible to create a device node on ramfs or ramdisk and point
>fsck at that?

Yes, I thought of that too. But that wouldn't be trivial for
existing installations, unless you're the maintainer of the
distributions init package. Oh wait .. ;)

Anyway, it seemed to me to be very useful, and since /proc/mounts
already refers to /dev/root it seemed to fit in naturally hence
the proposed patches. If the definitive answer is "do it in
userspace" then that's OK too.

Mike.

