Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261832AbVGFRsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbVGFRsQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 13:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbVGFRsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 13:48:16 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:47631 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261832AbVGFNI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:08:58 -0400
Message-ID: <42CBD7F6.2050203@slaphack.com>
Date: Wed, 06 Jul 2005 08:09:10 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
Cc: Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a> <87hdf8zqca.fsf@evinrude.uhoreg.ca> <42CB7DE0.4050200@namesys.com>
In-Reply-To: <42CB7DE0.4050200@namesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Hubert Chan wrote:
> 
> 
>>On Tue, 05 Jul 2005 20:50:08 -0400 EDT, "Alexander G. M. Smith" <agmsmith@rogers.com> said:
>>
>> 
>>
>>
>>>That sounds equivalent to no hard links (other than the usual parent
>>>directory one).  If there's any directory with two links to it, then
>>>there will be a cycle somewhere!
>>>   
>>>
>>
>>What we want is no directed cycles.  That is A is the parent of B is the
>>parent of C is the parent of A.  We don't care about A is the parent of
>>B is the parent of C; A is the parent of B is the parent of C.
>>
>>OK, here's a random idea that just popped into my head, and to which
>>I've given little thought (read: none whatsoever), and may be the
>>stupidest idea ever proposed on LKML, but thought I would just toss it
>>out to see if it could stimulate someone to come up with something
>>better (read: sane):  Conceptually, foo/.... is just a symlink to
>>/meta/[filesystem]/[inode of foo].
>> 
>>
> 
> Except that we want the metafiles to go away when the base file goes away.

Only, /meta is a filesystem that already makes stuff go away for us, so 
all we have left is the issue of whether using /meta costs us 
performance, or whether breaking POSIX to add a symlink (such as 
foo/...) really gives us that much more usability.

I don't know the first thing about whether it costs us performance, 
although it seems like it could be negligable considering the existance 
of mount --bind.

I don't think file-as-dir gives us that much more usability, because we 
can always create a simple program or shell script that 'cd's us into 
metadata.  It's still easier than having a simple program that 
manipulates the metadata directly, because this way we can do 'cd' and 
'ls' and so on inside the metadata directory.

And, once we start talking about applications, /meta will be more 
readily supported (as in, some apps will go through a pathname and stop 
when they get to a file, and then there's tar).  On apps which don't 
have direct support for /meta, you'd be navigating to the file in 
question and then manually typing '...' into the dialog, so I don't see 
why typing '...' at the end is better than typing '/meta' or '/meta/vfs' 
at the beginning.

That said, I'm still not entirely sure how we get /meta/vfs to work 
other than adding a '...' sort of delimiter anyway.

>>And a question: is it feasible to store, for each inode, its parent(s),
>>instead of just the hard link count?
>> 
>>
> 
> Ooh, now that is an interesting old idea I haven't considered in 20
> years.... makes fsck more robust too....

Doesn't it make directory operations slower, too?

And, will it require a format change?
