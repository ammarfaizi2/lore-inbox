Return-Path: <linux-kernel-owner+w=401wt.eu-S1754962AbXABUuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbXABUuy (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754966AbXABUux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:50:53 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:37100 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbXABUuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:50:52 -0500
Date: Tue, 2 Jan 2007 21:50:50 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, bhalevy@panasas.com, arjan@infradead.org,
       jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
In-Reply-To: <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
Message-ID: <Pine.LNX.4.64.0701022148340.21943@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <20061221185850.GA16807@delft.aura.cs.cmu.edu>
 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
 <1166869106.3281.587.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
 <4593890C.8030207@panasas.com> <1167300352.3281.4183.camel@laptopd505.fenrus.org>
 <4593E1B7.6080408@panasas.com> <E1H01Og-0007TF-00@dorka.pomaz.szeredi.hu>
 <20070102191504.GA5276@ucw.cz> <E1H1qRa-0001t7-00@dorka.pomaz.szeredi.hu>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Jan 2007, Miklos Szeredi wrote:

>>>>>> It seems like the posix idea of unique <st_dev, st_ino> doesn't
>>>>>> hold water for modern file systems
>>>>>
>>>>> are you really sure?
>>>>
>>>> Well Jan's example was of Coda that uses 128-bit internal file ids.
>>>>
>>>>> and if so, why don't we fix *THAT* instead
>>>>
>>>> Hmm, sometimes you can't fix the world, especially if the filesystem
>>>> is exported over NFS and has a problem with fitting its file IDs uniquely
>>>> into a 64-bit identifier.
>>>
>>> Note, it's pretty easy to fit _anything_ into a 64-bit identifier with
>>> the use of a good hash function.  The chance of an accidental
>>> collision is infinitesimally small.  For a set of
>>>
>>>          100 files: 0.00000000000003%
>>>    1,000,000 files: 0.000003%
>>
>> I do not think we want to play with probability like this. I mean...
>> imagine 4G files, 1KB each. That's 4TB disk space, not _completely_
>> unreasonable, and collision probability is going to be ~100% due to
>> birthday paradox.
>>
>> You'll still want to back up your 4TB server...
>
> Certainly, but tar isn't going to remember all the inode numbers.
> Even if you solve the storage requirements (not impossible) it would
> have to do (4e9^2)/2=8e18 comparisons, which computers don't have
> enough CPU power just yet.

It is remembering all inode numbers with nlink > 1 and many other tools 
are remembering all directory inode numbers (see my other post on this 
topic). It of course doesn't compare each number with all others, it is 
using hashing.

> It doesn't matter if there are collisions within the filesystem, as
> long as there are no collisions between the set of files an
> application is working on at the same time.

--- that are all files in case of backup.

> Miklos

Mikulas
