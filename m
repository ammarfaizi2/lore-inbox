Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUCWLrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 06:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbUCWLrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 06:47:04 -0500
Received: from gamemakers.de ([217.160.141.117]:3287 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S262515AbUCWLq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 06:46:57 -0500
Message-ID: <40602419.4040407@gamemakers.de>
Date: Tue, 23 Mar 2004 12:48:41 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@gamemakers.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: your dnotify work
References: <1080009581.3104.29.camel@vertex>
In-Reply-To: <1080009581.3104.29.camel@vertex>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:
> Hi,
> 
> I like the work you are doing on dnotify, your improvements are great.
> But by far the biggest problem with dnotify is that the client needs an
> open file descriptor, causing unmount problems. I was writing up some
> stuff for a new solution to dnotify. My solution was to use the inode
> number, and the device number to uniquely identify a file without using
> a file descriptor. Do you have any plans or ideas for this problem of
> dnotify?
> 
That was my initial approach. Have a device that just reports the 
filesystem id/inode number/type of change for each change. I posted 
something in this direction in december. But unfortunately inode numbers 
do *not* uniquely identify a file on all file systems. I was a bit 
shocked about this, too...

To quote jan harkes, who repiled to my original proposal:

"Inode number are not necessarily unique per filesystem. Any filesystem
that uses iget4 can have several objects that have the same inode
number. For instance, Coda uses 128-bit file-identifiers and the i_ino
number is a simple hash that is 'typically' unique. There are also
filesystems that invent inode numbers whenever inodes are brought into
the cache, but which have no persistency when the inode_cache is pruned.
So the next time you see the same object, it could have a different
(unique) inode number."

I am aware of the fact that there might be unmount problems. I just use 
an open directory for backwards compatibility with the old dnotify 
mechanism and since it is an easy way to say what exactly you want to 
watch. How do you propose to get the information out to user space?

I could have a device /dev/dnotify2 or whatever. But then all change 
information would appear in this device, and interested programs would 
have to sort out this huge stream of information and pick the few 
entries they are interested in.

Maybe there is another solution for the unmount problem. One could 
propagate a special event to all listening files before the do_unmount 
call to tell them that they have to stop listening.

Thanks for your kind words.

best regards,

Rüdiger
