Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276616AbRJCRpy>; Wed, 3 Oct 2001 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276622AbRJCRpf>; Wed, 3 Oct 2001 13:45:35 -0400
Received: from quechua.inka.de ([212.227.14.2]:2361 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S276616AbRJCRp2>;
	Wed, 3 Oct 2001 13:45:28 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Finegrained a/c/mtime was Re: Directory notification problem
In-Reply-To: <oupitdx9n2m.fsf@pigdrop.muc.suse.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.10-xfs (i686))
Message-Id: <E15oq5j-00056Z-00@calista.inka.de>
Date: Wed, 03 Oct 2001 19:45:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alex Larsson <alexl@redhat.com> writes:
>> I discovered a problem with the dnotify API while fixing a FAM bug today.
>> 
>> The problem occurs when you want to watch a file in a directory, and that 
>> file is changed several times in the same second. When I get the directory 
>> notify signal on the directory I need to stat the file to see if the 
>> change was actually in the file. If the file already changed in the 
>> current second the stat() result will be identical to the previous stat() 
>> call, since the resolution of mtime and ctime is one second. 

If you simply check the mtime and the file size you have the two most
relevant parts. If neighter of those changes this means that programs using
the dnotify api most likely do not need to act. After all it is not an
auditing facility but a notifier for things like reload of directory
listings. The only thing I could imagine can cause problems is a self
reloading config file. But in that case dnotify is overkill anyway and a 1
sec delay could be asumed to be reasonable.

Greetigs
Bernd
