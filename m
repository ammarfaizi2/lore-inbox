Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVIZU6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVIZU6R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVIZU6R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:58:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59098 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750756AbVIZU6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:58:16 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17208.24786.729632.221157@segfault.boston.redhat.com>
Date: Mon, 26 Sep 2005 16:57:54 -0400
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: autofs4 looks up wrong path element when ghosting is enabled
In-Reply-To: <Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
	<Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
	<17203.7543.949262.883138@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
	<17205.48192.180623.885538@segfault.boston.redhat.com>
	<Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:

raven> On Sat, 24 Sep 2005, Jeff Moyer wrote:
>> >> >> >> >> Ian, I'm not really sure how we can address this issue
>> without VFS >> >> changes.  Any ideas?
>> >> >> 
>> >> 
raven> I'm aware of this problem.  I'm not sure how to deal with it yet.
raven> The case above is probably not that difficult to solve but if the
raven> last component is a directory it's hard to work out it's a problem.
>> >> Ugh.  If you're thinking what I think you're thinking, that's an ugly
>> >> hack.
>> 
raven> Don't think so.
>>
raven> I've been seeing this for a while. I wasn't quite sure of the source
raven> but, for some reason your report has cleared that up.
>>
raven> The problem is not so much the success returned on the failed mount
raven> (revalidate). It's the return from the following lookup. This is a
raven> lookup in a non-root directory. I replaced the non-root lookup with
raven> the root lookup a while ago and I think this is an unexpected side
raven> affect of that. Becuase of other changes that lead to that decision
raven> I think that it should be now be OK to put back the null function
raven> (always return a negative dentry) that was there before I started
raven> working on the browable maps feature.
>>
raven> I'll change the module I use here and test it out for a while.  If
raven> you have time I could make a patch for the 2.4 code and send it over
raven> so that you could test it out a bit as well.
>> Just send along the 2.6 patch, since I have to deal with that, too.
>> I'll go through the trouble of backporting it.

raven> I'm in the middle of working on lazy multi-mounts atm so I'm not in
raven> a good position to test. It's a little tricky so I don't want to
raven> forget where I'm at by getting side tracked.

raven> But here's the patch that I will apply to my v5 tree for the initial
raven> testing. Hopefully you will be able to give it a run in a standard
raven> setup.

I put together a different patch, but I want to get your input on the
approach before I post it.  It requires both user-space and kernel-space
changes.

Basically, you identify that a given automount tree is a direct map tree.
This information is passed along to the kernel (I did this via a mount
option), and recorded (in the super block info).  Then, when a directory
lookup occurs, if we are in a direct map tree, and ghosting is enabled,
then we pass the lookup on to the real lookup code.

I'm not sold on the approach, as I haven't thought through all of the
implications.  Care to comment?

-Jeff
