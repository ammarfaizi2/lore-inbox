Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWGQVDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWGQVDL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 17:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWGQVDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 17:03:11 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:28408 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1751193AbWGQVDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 17:03:10 -0400
Message-ID: <44BBFB0D.6040105@namesys.com>
Date: Mon, 17 Jul 2006 14:03:09 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: 7eggert@gmx.de, Eric Dumazet <dada1@cosmosbay.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] reiserfs: fix handling of device names with /'s in them
References: <6xQ4C-6NB-43@gated-at.bofh.it> <6xQea-6ZX-13@gated-at.bofh.it> <E1G1QFx-0001IO-K6@be1.lrz> <44B7D97B.20708@suse.com> <44B9E6D5.2040704@namesys.com> <44BA61A2.5090404@suse.com> <44BA8214.7040005@namesys.com> <44BABB14.6070906@suse.com> <44BAE619.9010307@namesys.com> <44BAECE2.8070301@suse.com> <44BAFDC3.7020301@namesys.com> <44BB0146.7080702@suse.com> <44BB3C42.1060309@namesys.com> <44BBA4CF.8020901@suse.com> <44BBD4B6.5020801@namesys.com> <44BBD942.3080908@suse.com> <44BBDFFC.70601@namesys.com> <44BBEC17.8020507@suse.com>
In-Reply-To: <44BBEC17.8020507@suse.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:

> Hans Reiser wrote:
>
> >Jeff Mahoney wrote:
>
> >>1) Because then the behavior of /proc/fs/reiserfs/ would be
> >>inconsistent. Devices that contain slashes end up being one level deeper
> >>than other devices, which is silly and a userspace visible change.
>
> >And you think translating / to ! is less work for user space?
>
>
> A one line s#/#!# to access devices they couldn't before versus now
> having to deal with going deeper into a tree for no real reason? Yes,
> I do.

I am willing to bet that perl can tree iterate with one line of code....

Please read the Hideous Name by Rob Pike.  You are making it more hideous.

>
> >Jeff, you are a programmer, not an architect, and when you disregard
> >architects we end up with things like the performance disaster that is
> >V3 acls.
>
>
> This again? The original reiser3 implementation was, and still is,
> incomplete in comparison to the design document. The design touted the
> extensibility of the tree and item types. 

Try v4.

> My original xattr
> implementation added another item type, but oh -- wait -- it turns out
> that the file system isn't quite as extensible as claimed.. or, well, AT
> ALL. Adding another item results in an incompatible file system change
> that when mounted on another system, will panic the node. That's
> friendly! There's not even any way to identify which items are in use on
> a particular file system to issue a warning/error on mount. Outstanding
> job "architecting" there.

Well, if you had an obsessive desire to not use V4, you could fix this
in V3 instead.

>
> If I could go back and do it again, I would have forked a reiserfs v3.7
> that actually incorporated a compatibility block to identify which items
> are in use on a particular file systems, so that the mount can succeed
> or fail based on that. 

Might be easier to use V4...  so many bugs got added to an otherwise
stable V3.....

> Xattrs would have been another item type as
> expected, and the performance problems wouldn't be nearly as harsh as
> they are. 

Hmm, maybe it was all perfectly predictable to an architect....

> Not that you wouldn't have been just as resistant to that
> change as well.
>
> The thing is, you have a history of ignoring what users want.

What quality architect does not?  Users are to be listened to with great
care.  Users are to be listened to with great discretion.

> Users
> wanted ACLs and xattrs on reiser3, but you said, "wait for v4, it'll be
> out soon, and it'll have them." That was 4 years ago. Reiser4 still
> isn't completely stable 

It is more stable than V3 was when it went in, and surely it is more
stable than ext4....

It is getting there.  Recent get ready for mainline changes added bugs. 
We need to get some patches out the door tomorrow, and then we should be
back to being stable again.

> (or in mainline),

not my doing;-)  we wasted a lot of time shuffling code from one side of
the room to the other for no measurable benefit.  If only that time
could have been spent on the things I know deserve work.

> and ACLs and xattrs still
> aren't implemented. Users that demanded ACLs certainly aren't waiting
> around for reiser4 to be released and have ACLs added. They've long
> since switched to a file system that actually does what they need. They
> wanted ACLs and xattrs added to the stable file system they were using
> and you refused in an attempt to get more support for your latest
> project. Further, reiser3 users remember what a long painful road it was
> to reiser3 stability

so why did you take their stable branch away from them by working on
more than bugfixes for V3?

Jeff, working on v3 at this point is nuts.  V4 blows it away....

