Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268006AbUHPWxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268006AbUHPWxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268008AbUHPWxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:53:05 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:36999 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S268006AbUHPWwx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:52:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Mon, 16 Aug 2004 18:52:50 -0400
User-Agent: KMail/1.6.82
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408150009.45034.gene.heskett@verizon.net> <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040815084856.GD12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408161852.50310.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.55.227] at Mon, 16 Aug 2004 17:52:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 August 2004 04:48, viro@parcelfarce.linux.theplanet.co.uk 
wrote:
>On Sun, Aug 15, 2004 at 12:09:44AM -0400, Gene Heskett wrote:
>> The only thing I've noted in the slabinfo reports is the
>> ext3_cache was well into 6 digits in kilobytes.  Now its only
>> 15,000 of its normal units (whatever they are) after the reboot.
>
>What did dcache numbers look like at that time?
>
>Anyway, we could try the patch below and see what shows in
> /proc/fs/ext3 with it [NOTE: patch is completely untested].  It
> should show major:minor:inumber:mode
>for all currently allocated ext3 inodes.  It won't be 100% accurate
> (we can miss some entries/get some twice if cache shrinks or grows
> at the time), but if the leak is so massive, we ought to see a
> *lot* of duplicates in there.  Seeing what kind of inodes really
> leaks could narrow the things down.

Well, I am seing some dups, but they are so volatile that no two runs 
will report the same allocations as dups, and its never more than 2
using /proc/fs/ext3 | sort | uniq -c | sort -nr |grep -v ' 1 '

Consecutive runs will show anywhere from 3 to 10 or 12 dups, but never 
is an address repeated between runs.

How is this to be interpreted?

FWIW, I'm now up 25 hours, with PREEMPT off.  No Oops's yet.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
