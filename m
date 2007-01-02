Return-Path: <linux-kernel-owner+w=401wt.eu-S1755411AbXABVhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbXABVhf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755412AbXABVhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:37:34 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38524 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755410AbXABVhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:37:33 -0500
Date: Tue, 2 Jan 2007 22:37:31 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <E1H1qtW-0001yH-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0701022234520.9775@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
 <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.64.0701022148340.21943@artax.karlin.mff.cuni.cz>
 <E1H1qtW-0001yH-00@dorka.pomaz.szeredi.hu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Certainly, but tar isn't going to remember all the inode numbers.
>>> Even if you solve the storage requirements (not impossible) it would
>>> have to do (4e9^2)/2=8e18 comparisons, which computers don't have
>>> enough CPU power just yet.
>>
>> It is remembering all inode numbers with nlink > 1 and many other tools
>> are remembering all directory inode numbers (see my other post on this
>> topic).
>
> Don't you mean they are remembering all the inode numbers of the
> directories _above_ the one they are currently working on?  I'm quite
> sure they aren't remembering all the directories they have processed.

cp -a is remembering all directory inodes it has visited, not just path 
from root. If you have two directories with the same inode number 
anywhere in the tree, it will skip one of them.

Mikulas

>> It of course doesn't compare each number with all others, it is
>> using hashing.
>
> Yes, I didn't think of that.
>
>>> It doesn't matter if there are collisions within the filesystem, as
>>> long as there are no collisions between the set of files an
>>> application is working on at the same time.
>>
>> --- that are all files in case of backup.
>
> No, it's usually working with a _single_ file at a time.  It will
> remember inode numbers of files with nlink > 1, but it won't remember
> all the other inode numbers.
>
> You could have a filesystem with 4billion files, each one having two
> links.  Not a likely scenario though.
>
> Miklos
>
