Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUAPUsW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265889AbUAPUsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:48:22 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:54483 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265887AbUAPUr7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:47:59 -0500
Message-ID: <40084DFB.5040106@namesys.com>
Date: Fri, 16 Jan 2004 23:47:55 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: raymond jennings <highwind747@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>
In-Reply-To: <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Fri, 16 Jan 2004 11:38:59 PST, raymond jennings <highwind747@hotmail.com>  said:
>  
>
>>Is there any value in creating a new filesystem that encodes long contiguous 
>>blocks as a single block run instead of multiple block numbers?  A long file 
>>may use only a few block runs instead of many block numbers if there is 
>>little fragmentation (usually the case). 
>>
This is already done, they are called "extent"s.  Reiser4 uses them, XFS 
uses them, I think Veritas may have been the first to use them but I am 
not sure of this, maybe it was IBM.

>> Also dynamic allocation of 
>>inodes...etc.
>>
ReiserFS does dynamic allocation of stat data (what stat() returns), we 
don't have inodes.  Many filesystems do dynamic allocation of inodes.

>>  The details are long; anyone interested can e-mail me 
>>privately.
>>    
>>
>
>Only question I have is how you make an efficient scheme for finding the block
>number for an offset several gigabytes into the file.
>
Use a tree to store everything in.  See www.namesys.com for extensive 
details.

>  You either get to run
>through the list linearly (gaak) or you need to stick a tree or hash on the
>front to allow semi-random access to a starting point to scan linearly from, at
>which point you've probably blown any space savings unless you have a VERY low
>fragmentation rate...
>
>On the other hand, dynamic allocation of inodes is interesting, as it means
>you're not screwed if over time, the NBPI value for the filesystem changes (or
>if you simply guessed wrong at mkfs time) and you run out of inodes when you
>still have space free.  Reiserfs V3 already does this, in fact...
>
>  
>
Cheers,

-- 
Hans


