Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262258AbVFUUKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbVFUUKJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVFUUJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:09:15 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:39390 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262298AbVFUUFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:05:44 -0400
Message-ID: <42B87318.80607@namesys.com>
Date: Tue, 21 Jun 2005 13:05:44 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com>
In-Reply-To: <42B831B4.9020603@pobox.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>
>
>> reiser4
>>
>>    
>
>
> The plugin stuff is crap.  This is not a filesystem but a filesystem +
> new layer.  IMO considered in that light, it duplicates functionality
> elsewhere.


What functionality where?  Please remember that this is per file, per
item, per node, per attribute, per disk format, per bitmap, per super
block, etc.,  abstracting, not per filesystem abstracting.

Plugins allow a number of things:

1) They allow us to never pay the cost to change the disk format again,
no matter how much we add in future years.  This really matters: the
prohibitive cost of disk format changes are the number one impediment to
filesystem improvements, and the primary reason why most filesystems
ossify after time has past.

2) They allow us to easily structure code for reuse.   If we want to
create a new kind of file that is like some other kind of file except
for one thing, we just write the one thing, and then easily reuse all
the other code, and create a new plugin id. 

The use of plugins forced all the programmers to think about reusability
at every layer of design.  V3 of reiserfs is way too hard to work on and
modify.  If you ask one of the team to code something for V3 instead of
V4, they quietly groan at the thought.  It is just so much easier to do
in V4.

When I asked one of our team to completely change the key assignment
algorithm for V4 (which controls what things get packed near what in the
tree), he complained that it would take 6 weeks to do it.  Under V3 it
would have taken 3 months.  It took him 3 days, and now to change it
again would take him 3 hours I think.  Oh, by the way, the change
boosted performance dramatically.

If you take the time to become familiar with coding within our plugin
layer, I think you will find yourself wanting the same to exist for
other filesystems.  Of course, no other filesystem needs to be impacted
by our plugin layer, and there is no way reiser4 could easily be
rewritten to exist without it (it would be like requiring that the
kernel not use function calls and only use gotos). 

Reiser4's plugin layer has as its explicit objective making it possible
for the weekend hacker to add something useful to reiser4 and send it in
for inclusion.  We want to democratize filesystem innovation so that
random bright guys who usually work on something other than filesystems
can act on their bright ideas without spending 3 years in the filesystem
field to do it.  I believe that most great filesystem innovations are
envisioned by persons not working on filesystems, and go nowhere because
of the especially high cost of entry into our field.

I am not as bright as other filesystem developers, and so we must tinker
with three ideas and keep one of them.  The speed of tinkering is
crucial to us, and the plugin layer increases that speed several fold.

Please reconsider your view. 
