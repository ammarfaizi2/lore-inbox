Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUHHEmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUHHEmU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 00:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUHHEmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 00:42:20 -0400
Received: from out006pub.verizon.net ([206.46.170.106]:41422 "EHLO
	out006.verizon.net") by vger.kernel.org with ESMTP id S265086AbUHHEmS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 00:42:18 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Sun, 8 Aug 2004 00:42:15 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <20040806031815.GL12308@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408052022060.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408052022060.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408080042.16093.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out006.verizon.net from [151.205.63.10] at Sat, 7 Aug 2004 23:42:17 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 August 2004 23:24, Linus Torvalds wrote:
>On Fri, 6 Aug 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
>> It doesn't even take a dput().  Look: we do list_del(), then
>> notice that sucker still has positive refcount and leave it alone.
>>  Now think what happens on the next pass.  That's right, we hit
>> that dentry *again*. And see that list_empty() is false.  And do
>> list_del() one more time.
>
>Well, the sad part is that doing another list_del() won't even
> necessarily go *boom*. Most of the time it might even leave the
> list as-is, but often enough it should give list corruption.
>
>> However, what used to be e.g. next dentry might very well be freed
>> by now.  *BOOM*.
>
>Absolutely. It does look like a rather nasty bug.
>
>It doesn't explain what Gene sees, though, unless you can explain
> how we'd get an anon dentry without knfsd/xfs. Oh well.
>
>I'll commit the obvious one-liner fix, since it might explain _some_
>problems people have seen.
>
>		Linus

I just had to reboot, after about an 8 hour uptime with the 'one 
liner' only on top of 2.6.8-rc3.  Out of memory basicly.  tvtime and 
mozilla were casualties of what must be the Oom killer.  Nothing in 
the logs.  I had seti@home, X, kde3.3-beta2, and its kmail, plus top, 
tail, tvtime and mozilla.  Moz died first, or at least thats what I 
noticed first.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
