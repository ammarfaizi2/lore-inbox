Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263984AbUCZKKP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUCZKKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:10:14 -0500
Received: from gamemakers.de ([217.160.141.117]:38876 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S263984AbUCZKKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:10:04 -0500
Message-ID: <406401F1.1050201@gamemakers.de>
Date: Fri, 26 Mar 2004 11:12:01 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] dnotify: enhance or replace?
References: <4061986E.6020208@gamemakers.de> <1080142815.8108.90.camel@localhost.localdomain> <1080146269.23224.5.camel@vertex> <4061BD2E.2060900@gamemakers.de> <1080158032.30769.13.camel@vertex> <20040324200443.GS31500@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040324200443.GS31500@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

[snip]

 > "Doctor, It Hurts When I Do It"
 >
 > Seriously, dnotify sucks in a lot of ways, starting with the basic
 > premise - that userland can do notification-based maintainig of directory
 > tree image.  It's racy by definition, so any attempts to use it for
 > "security improvements" are scam.  Which leaves us with file manglers
 > and their ilk.
 >
I thought about this some more. If you watch for e.g. all writes on the 
root of a file system you get a complete, correctly ordered log of all 
file writes on that filesystem. So you can find out wether a certain 
file has been changed or not. That could be relevant security information.

You would get changes to the file pointed to by the path /etc/shadow, 
even if the file has been changed by a hard link from /tmp/bla.

I am assuming here that there is a way like inode numbers to uniquely 
identify and persistently identify a file. If something like this does 
not exist, you are out of luck.

 > Note that any attempts to trace "aliases" in userland are hopelessly 
racy;

You don't trace aliases in userland. All the relevant information is 
logged in kernel space. The only thing you do in userspace is to convert 
this information into a user readable form. You can take as long as you 
want for that.

Btw: why did you put aliases in quotes? Is aliases not the correct term 
when refering to multiple paths pointing to the same file?

 > that mounting/unmounting doesn't even show on the radar;

There is an event for mounting and unmounting.

 > hat different users can see different parts of tree or, while we are
 > at it, completely different trees;
 >
That is why the paths returned by the mechanism are relative to the 
directory from which you watch.

 > that this crap is a DDoS on a server that exports any
 > sort of network filesystem to many clients - *especially* if you want
 > notifications on the entire tree.
 >
If you have 100 clients, and each client wants its own notification for 
/home, you would indeed have a problem. But if a single process like fam 
watches for changes in /home on behalf of all 100 clients, it would be 
no problem.

 > IOW, idea is fundamentally flawed and IMO the real fix is to try and 
figure
 > out a decent UI that would provide what file managers are really used 
for.
 >
File managers are just one application of an enhanced file change 
notification mechanism. There are many much more interesting 
applications. For file managers the current dnotify mechanism is OK.
