Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUABRAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 12:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265616AbUABRAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 12:00:22 -0500
Received: from firewall.conet.cz ([213.175.54.250]:16028 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265598AbUABRAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 12:00:14 -0500
Message-ID: <3FF5A36A.5070501@conet.cz>
Date: Fri, 02 Jan 2004 17:59:22 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Christoph Hellwig <hch@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org> <20040102163552.GD31489@wohnheim.fh-wedel.de>
In-Reply-To: <20040102163552.GD31489@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>I'm working on my diploma thesis which is adding snapshot capability 
>>>into Linux VFS (so you can do directory based snapshots - not complete 
>>>device, like in LVM). It'll consist of two separete modules:
>>>Snapshot module:
>>>- will hijack (one or another way) calls to open/move/unlink/mkdir/etc. 
>>>syscall
>>>- when will detect change to selected directory (which I want to 
>>>snapshot), it'll copy/move old file/directory to some temporary 
>>>(selected when creating snapshot) - in fact - copy on write behaviour
>>
>>This should be implemented as a stackable filesystem..
> Does this filesystem stack work with multiple mount points?

I think that stackable filesystem is useless for this. See this:
- I have some BIG (>> 1 TB) filesystem (XFS/ext3/JFS whatever!!!) 
mounted in /BIG
- I call something like snapshot --what=/BIG/data --where=/OTHER_FS/snap1
- from now whenever I delete/create/modify file/dir in /BIG/data then 
BEFORE the action the original file/dir should be copyied/moved to
/OTHER_FS/snap1

There is no place where can I use stackable filesystem because I'd need 
to use it on the very beginning of mounting /BIG so instead:
mount /dev/md0 /BIG -t xfs
I'd need to do something like:
mount /dev/md0 /BIG -t snapfs -o fstype=xfs
Which is something I'm trying to avoid as much as possible for many reasons.


> My guess is that the filesystem change notification would be a better
> solution, either in userspace or in kernelspace, doesn't matter.  But
> that is far from finished or even generally accepted.

This is also something (but just a bit) different - I don't need "change 
notification" but "pre-change notification" ;)

> For the diploma thesis, feel free to use any hack you like, including
> hijacking syscalls.  But remember that it is a hack and nothing else,
> only helping you to remain on schedule and focus more on the real
> subject.  And don't plan on kernel acceptance either, as you will fail
> either that or the thesis and I'd choose the thesis.

You're absolutely right but when I'm going to spent several weeks on 
something like this I'd like to do something usefull - not something 
which will be trashed after exam. So I'm trying to find out some 
"politically correct" way.

Right now I'll code it with the very nasty "find sys_call_table" hack 
just I can test it without rebooting my machine (attempts to get 2.6.0 
running under UML or VMWare failed :-((() and when I'll release some 
0.0.1 version and get some good respondce I'll code it as the VFS patch 
& module.


-- 

Libor Vanek

