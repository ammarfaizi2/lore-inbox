Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264933AbSKEVcn>; Tue, 5 Nov 2002 16:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSKEVcn>; Tue, 5 Nov 2002 16:32:43 -0500
Received: from sccrmhc01.attbi.com ([204.127.202.61]:33247 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S264933AbSKEVck>; Tue, 5 Nov 2002 16:32:40 -0500
Message-ID: <3DC83A7B.5050107@namesys.com>
Date: Tue, 05 Nov 2002 13:39:07 -0800
From: reiser <reiser@namesys.com>
Reply-To: reiser@namesys.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Nikita Danilov <Nikita@namesys.com>, Tomas Szepe <szepe@pinerecords.com>,
       Alexander Zarochentcev <zam@namesys.com>,
       lkml <linux-kernel@vger.kernel.org>, Oleg Drokin <green@namesys.com>,
       umka <umka@namesys.com>
Subject: Re: [BK][PATCH] Reiser4, will double Linux FS performance, pleaseapply
References: <3DC1D63A.CCAD78EF@digeo.com> <3DC1D885.6030902@namesys.com> <3DC1D9D0.684326AC@digeo.com> <3DC1DF02.7060307@namesys.com> <20021101102327.GA26306@louise.pinerecords.com> <15810.46998.714820.519167@crimson.namesys.com> <20021102132421.GJ28803@louise.pinerecords.com> <15814.21309.758207.21416@laputa.namesys.com> <3DC19F61.5040007@namesys.com> <3DC773B0.4070701@namesys.com> <20021105022944.A14575@munet-d.enel.ucalgary.ca>
In-Reply-To: <3DC1D63A.CCAD78EF@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew Roselli did traces of overwrite patterns, and the typical time to 
overwrite was about 6 minutes, so if you want the write cache to be 
effective you want it to last for more than 6 minutes.  I encourage you 
to read the PhD thesis she wrote and argue with it and me on it, I am 
far from dogmatically certain that 10 minutes is the right amount of 
time.  60 seconds is the most I would want for my Dell laptop (laptops 
are crash prone).  10 minutes for a non-mobile computer with a UPS, or 
in an area with a competent electric utility company, is quite 
reasonable though.  10 minutes is clearly the right amount of time for, 
say, a user space programmer, and probably too risky for a kernel 
programmer.  Probably kernel programmers are outnumbered 10 to 1 by user 
space programmers?  ( I don't really know.)

There simply is not enough empirical data for what we argue about, 
unfortunately.  Drew Roselli's thesis is the only one, and there is a 
need for 5 such theses before one can consider the topic reasonably 
understandable by the discerning.  I worry a lot that her samples are 
distorted by site specific usage patterns that might not resemble those 
of the usual linux user.

I wish I personally had a better understanding of what the usual linux 
user does in the way of IO.....

Hans

Andreas Dilger wrote:

>On Nov 04, 2002  23:30 -0800, reiser wrote:
>  
>
>>The appropriate setting of 
>>transaction max age depends on the user.  The setting we chose is 
>>appropriate for software developers doing compiles.  It is not clear to 
>>me yet what the right setting is.  Perhaps 3 minutes is more 
>>appropriate.  I was probably overly influenced by Drew Roselli's 
>>statistics on how long the cyle is between rewrites.  Her statistics are 
>>probably skewed by having lots of CS students using the machines she got 
>>her data from.  5 seconds is too short to perform good layout 
>>optimization for subsequent reads.
>>    
>>
>
>I think the bdflush defaults are (were?) something like 5 seconds for
>metadata, and 30 seconds for file data. reiser4 should (if it doesn't
>already) use the parameters set by sys_bdflush() to tune the writeout
>intervals.
>
>I would think that either:
>a) A file was completely written in under 30 seconds (e.g. untar or gcc
>   or whatever else you are doing), so deferring allocation and writing
>   to disk does not help you at all.
>b) A file is continuing to be written for more than 30 seconds that
>   has a very large amount of outstanding data which can be committed
>   to disk with (probably) the same read optimization quality as any
>   larger amount of data.
>c) A file is continuing to be written for more than 30 seconds that
>   is growing slowly and no matter how long you defer the write you
>   will only get an incremental read layout.  Presumably you could do
>   something to pre-allocate/reserve a bunch of space at the end of this
>   file as it continues to grow.
>
>So, except for the very unusual case of files with lifespans between 30
>seconds and 300 seconds, or files that are written to between those
>intervals, I would guess that you are not gaining much extra benefit by
>deferring the writes another 270 seconds.
>

>
>Cheers, Andreas
>--
>Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
>                 \  would they cancel out, leaving him still hungry?"
>http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
>
>
>  
>


