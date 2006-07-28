Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWG1ToM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWG1ToM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161253AbWG1ToM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:44:12 -0400
Received: from 63-162-81-169.lisco.net ([63.162.81.169]:43477 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1161251AbWG1ToK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:44:10 -0400
Message-ID: <44CA6905.4050002@slaphack.com>
Date: Fri, 28 Jul 2006 14:44:05 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.4 (Macintosh/20060530)
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org> <44C9FB93.9040201@namesys.com>
In-Reply-To: <44C9FB93.9040201@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Linus Torvalds wrote:
> 
>>
>> In other words, if a filesystem wants to do something fancy, it needs to 
>> do so WITH THE VFS LAYER, not as some plugin architecture of its own.
>>

> (Let us try to avoid arguments over whether if you extend VFS it is
> still called VFS or is called reiser4's plugin layer, agreed?)

Ok, assuming you actually extend the VFS.  The point is that if we want 
plugins, we don't have to implement them in ext3, but we have to put the 
plugin interface somewhere standard that is obviously not part of one 
filesystem (the VFS is the place) so that ext3 can implement a plugin 
system without having to read or touch a line of reiser4 code, and 
without compiling reiser4 into the kernel.

It may ultimately not be any different, technically.  This seems more 
like an organizational and political thing.  But that doesn't make it 
less important or valid.

> Regarding copyright, these plugins are compiled in.  I have resisted
> dynamically loaded plugins for now, for reasons I will not go into here.

Good point, there's no GPL issue here.  Plugins will either not be 
distributed (used internally) or distributed as GPL.

> If you agree with taking it to the next level, then it is only to be
> expected that there are things that aren't well suited as they are, like
> parsing /etc/fstab when you have a trillion files.  It is not very
> feasible to do it for all of the filesystems all at once given finite
> resources, it needs a prototype. 

Doesn't have to be in fstab, I hope, but think of it this way:  ext3 
uses JBD for its journaling.  As I understand it, any other filesystem 
can also use JBD, and ext3 is mostly ext2 + JDB.

So, make the plugin interface generic enough that it compliments the 
VFS, doesn't duplicate it, and doesn't exist as part of Reiser4 (and 
requires Reiser4 to be present).  This may be just a bunch of renaming 
or a lot of work, I don't know, but I suspect it would make a lot of 
people a lot happier.

> We have finite resources.  We can give you a working filesystem with
> roughly twice the IO performance of the next fastest you have that does
> not disturb other filesystems,.  (4x once the compression plugin is
> fully debugged).  It also fixes various V3 bugs without disturbing that
> code with deep fixes.  We cannot take every advantage reiser4 has and
> port it to every other filesystem in the form of genericized code as a
> prerequisite for going in, we just don't have the finances.

This is a very compelling argument to me, but that's preaching to the 
choir, I've been running Reiser4 since before it was released, and 
before it looked like it was going to be stable anytime soon.

It may be bold of me to speak for the LKML, but I think the general 
consensus is:

The speed of a nonworking program is irrelevant -- no one cares how fast 
it is if it breaks things, either now or in the future.  Currently, the 
concern is that it breaks things in the future, like adding plugin 
support to other filesystems.

And no one else cares what your finances are.  Not out of compassion, 
but out of practicality.  For instance, it would be a huge financial 
benefit to me if the kernel displayed, in big bold letters while 
booting, that DAVID MASOVER WROTE THIS!  (I'm sure Linus knows what I'm 
talking about.)  It would also be untrue in my case, and pointless for 
everyone else in the kernel, so I have to find another way to make money.

This is because one way Linux stays ahead of the competition 
(technologically) is by having quality be a much greater motivation than 
money.

> Without
> plugins our per file compression plugins and encryption plugins cannot
> work.  We can however let other filesystems use our code, and cooperate
> as they extend it and genericize it for their needs.  Imposing code on
> other development teams is not how one best leads in open source, one
> sets an example and sees if others copy it.  That is what I propose to
> do with our plugins.  If no one copies, then we have harmed no one. 
> Reasonable?

Someone still has to maintain the FS.  Anyway, like I said, this is a 
very compelling argument for me, but code speaks louder than words. 
Maybe, if you insist it's not in the VFS, maybe use some insanely simple 
FS like RomFS to demonstrate another FS using plugins?

Do that, and put it in the VFS.  Maybe implement something like cramfs 
as a romfs plugin (another demo).  Maybe even per-file -- implement 
zisofs as isofs + compression plugin.  I think that would effectively 
kill any argument that plugins are bad because they are only in Reiser4.

Beyond that is all marketing, I guess.  The word "plugin" is not helping 
here, too many people remember Plugins like Macromedia Flash...
