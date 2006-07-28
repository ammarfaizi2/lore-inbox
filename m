Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWG1S5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWG1S5e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbWG1S5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:57:33 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:5350 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1161237AbWG1S5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:57:32 -0400
Message-ID: <44C9FB93.9040201@namesys.com>
Date: Fri, 28 Jul 2006 05:57:07 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: David Masover <ninja@slaphack.com>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Theodore Tso <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: metadata plugins (was Re: the " 'official' point of view" expressed
 by kernelnewbies.org regarding reiser4 inclusion)
References: <200607281402.k6SE245v004715@laptop13.inf.utfsm.cl> <44CA31D2.70203@slaphack.com> <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607280859380.4168@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>
>In other words, if a filesystem wants to do something fancy, it needs to 
>do so WITH THE VFS LAYER, not as some plugin architecture of its own.
>
Where does VFS store the plugin ids that specify per file variations? 
/etc/fstab?  Also, is (current) VFS the interface for specifying where
the hash directory plugin goes (specifies what order directory entries
are within the directory)?  What about the node layout plugin?  The disk
format plugin?  Etc.?  Our approach is different, but it has reasons.

We eliminated the layer of indirection that Hellwig objected to, in
which VFS called the plugin which called its method. 

(Let us try to avoid arguments over whether if you extend VFS it is
still called VFS or is called reiser4's plugin layer, agreed?)

Regarding copyright, these plugins are compiled in.  I have resisted
dynamically loaded plugins for now, for reasons I will not go into here.

You can either portray reiser4 as duplicating VFS, or you can portray it
as taking it to the next level, in which files (objects with classes and
methods) vary rather than solely filesystems.  I would prefer the latter.;-)

If you agree with taking it to the next level, then it is only to be
expected that there are things that aren't well suited as they are, like
parsing /etc/fstab when you have a trillion files.  It is not very
feasible to do it for all of the filesystems all at once given finite
resources, it needs a prototype. 

> We 
>already have exactly the plugin interface we need, and it literally _is_ 
>the VFS interfaces - you can plug in your own filesystems with 
>"register_filesystem()", which in turn indirectly allows you to plug in 
>your per-file and per-directory operations for things like lookup etc.
>
>If that isn't enough, then the filesystem shouldn't make its own internal 
>plug-in architecture that bypasses the VFS layer and exposes functionality 
>that isn't necessarily sane. For example, reiser4 used to have (perhaps 
>still does) these cool files that can be both directories and links, and I 
>don't mind that at all, but I _do_ mind the fact that when Al Viro (long 
>long ago) pointed out serious locking issues with them, those seemed to be 
>totally brushed away.
>  
>
We disabled them, and we won't enable them until them until the bug is
fixed.  It is fixable, but not within this year's programmer resources
to fix it.  I thank him for pointing out the bug, and it is not trivial
to fix it.

>I don't think I've ever had the cojones to argue with Al..
>  
>
Linux needs all kinds of people, not just the kind that can audit
locking and copy Plan 9 well (which was very valuable to do), but now
that Linux is large in the market it also needs those who can take it
where Plan 9 has not already been.   Why should we remain technology
trailers instead of moving into the role of leaders?

We have finite resources.  We can give you a working filesystem with
roughly twice the IO performance of the next fastest you have that does
not disturb other filesystems,.  (4x once the compression plugin is
fully debugged).  It also fixes various V3 bugs without disturbing that
code with deep fixes.  We cannot take every advantage reiser4 has and
port it to every other filesystem in the form of genericized code as a
prerequisite for going in, we just don't have the finances.  Without
plugins our per file compression plugins and encryption plugins cannot
work.  We can however let other filesystems use our code, and cooperate
as they extend it and genericize it for their needs.  Imposing code on
other development teams is not how one best leads in open source, one
sets an example and sees if others copy it.  That is what I propose to
do with our plugins.  If no one copies, then we have harmed no one. 
Reasonable?

Hans

