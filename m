Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTDMIyl (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 04:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263403AbTDMIyl (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 04:54:41 -0400
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:27036 "EHLO
	ubb.apia.dhs.org") by vger.kernel.org with ESMTP id S263402AbTDMIyk (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 04:54:40 -0400
From: "Tony 'Nicoya' Mantler" <nicoya@apia.dhs.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Quick question about hyper-threading
References: <20030413031007$5a6f@gated-at.bofh.it> <20030413041007$6d72@gated-at.bofh.it>
Organization: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
User-Agent: MT-NewsWatcher/3.1 (PPC)
Date: Sun, 13 Apr 2003 04:06:09 -0500
Message-ID: <nicoya-87F6BA.04060913042003@news.sc.shawcable.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030413041007$6d72@gated-at.bofh.it>, Robert Love <rml@tech9.net> 
wrote:

: On Sat, 2003-04-12 at 23:13, Timothy Miller wrote:
[...]
: > Does the HT-aware scheduler attempt to take this into account by scheduling
: > two related threads to run simultaneously on the same CPU as often as
: > possible (unless you're in a multi-processor system and another CPU would
: > otherwise be idle)?
: 
: 
: No, the current scheduler (HT or stock 2.5) does not do this.
: 
: Your theories are correct.  It would be interesting to try this and see.
: 
: It is nontrivial to do the ->mm checks in the scheduler though -
: certainly they cannot be done easily (if at all) in constant-time (i.e.,
: it won't be O(1)).
[...]

Perhaps the same effect could be obtained by preferentially scheduling processes 
to execute on the "node" (a node being a single cpu in an SMP system, or an HT 
virtual CPU pair, or a NUMA node) that they were last running on.

I think the ideal semantics would probably be something along the lines of:

 - a newly fork()ed thread executes on the same node as the creating thread
 - calling exec() sets a "feel free to shuffle me elsewhere" flag
 - threads are otherwise only shuffled to other nodes when a certain load ratio 
is exceeded (current-node:idle-node)

Unfortunatley the whole idea would seem to fall apart in the case of a 
fast-spawning thread pool type load. Perhaps there's a way to handle that 
automatically, or perhaps it would best be left as a scheduler tunable, I don't 
know.

I seem to recall SGI found great benefit in writing the scheduler in IRIX to 
work somewhat like this, though the loads on most SGI machines tend to be slow 
spawning, long running and big memory - the textbook case for reduced node 
shuffling. Linux would tend to have a much greater variety of load profiles, 
some of which would be less pleasantly affected.


Cheers - Tony 'Nicoya' Mantler :)

-- 
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/
