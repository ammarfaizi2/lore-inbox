Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbVIUU14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbVIUU14 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVIUU1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:27:55 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:7677 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S1751413AbVIUU1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:27:55 -0400
Message-ID: <4331C23B.4010104@nortel.com>
Date: Wed, 21 Sep 2005 14:27:39 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sonny Rao <sonny@burdell.org>
CC: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: dentry_cache using up all my zone normal memory -- also seen
 on 2.6.14-rc2
References: <433189B5.3030308@nortel.com> <43318FFA.4010706@nortel.com> <4331B89B.3080107@nortel.com> <20050921200758.GA25362@kevlar.burdell.org>
In-Reply-To: <20050921200758.GA25362@kevlar.burdell.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2005 20:27:47.0858 (UTC) FILETIME=[EE3DCF20:01C5BEEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao wrote:

> If I'm reading this correctly, you seem to have about 1.2 million
> files open and about 3.9 million dentrys objects in lowmem with almost
> no fragmentation..  for those files which are open there certainly
> will be a dentry attached to the inode (how big is inode cache?), but
> the shrinker should be trying to reclaim memory from the other 2.7
> million objects I would think.

I don't know what the code is actually doing.  This is testcase 
"rename14" from the LTP suite.  It runs fine on ppc, ppc64, dual-xeon, 
and Xscale.

The inode cache is small...under 300 objects.

> Based on the lack of fragmentation I would guess that either the shrinker isn't
> running or those dentrys are otherwise pinned somehow (parent
> directorys of the open files?)  What does the directory structure look
> like?

No idea.

> Just for kicks (again), have you tried ratcheting up the
> /proc/sys/vm/vfs_cache_pressure tunable by a few orders of magnitude ?

Nope.  I'm currently rebooting with an instrumentation patch for dentry, 
may try this too.

Chris
