Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbTB0UYh>; Thu, 27 Feb 2003 15:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbTB0UYg>; Thu, 27 Feb 2003 15:24:36 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21960 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266888AbTB0UYe>; Thu, 27 Feb 2003 15:24:34 -0500
Message-ID: <3E5E71EF.2030907@namesys.com>
Date: Thu, 27 Feb 2003 23:15:43 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Results of using tar with 2.5.[60 63 62-mm3] and reiser[fs 4],
 ext3, xfs.
References: <1046289007.6618.220.camel@spc9.esa.lanl.gov>
In-Reply-To: <1046289007.6618.220.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:

>
>Brief summary: It looks like the order of performance for this
>particular load is reiserfs, reiser4, ext3, xfs.
>

The performance of reiserfs V3 relative to ext3 and XFS in this 
benchmark is consistent with past experience as best I can remember it.  
I would say that roughly speaking these results have been true without 
major change during the period we have been testing (at least for 
writes, ext3 does better on reads, and I won't predict which of ext3 or 
reiserfs is currently faster for reads, ext3 has tended to have a slight 
read speed advantage for linux kernel source code).

The ~6% disadvantage of V4 compared to V3 is a bit surprising, and we 
are still evaluating that result.  We just checked in a complete rewrite 
of the flushing code today: give us a few weeks of analysis and we will 
hopefully have better results for V4 versus V3.  The primary purpose of 
the rewrite was code clarity, but rumor has it we found unnecessary work 
being done during the rewrite and corrected it.;-)  With clear code it 
will be easier for us to analyze what it is doing.

I would advise using a larger benchmark with  30-60 kernels being 
copied.  Filesystems sometimes perform differently for sync than for 
memory pressure.

I would be interested to understand why ext3 is slower for sync: is it 
because it has more in its write cache, or because of something else?  
If it has more in its write cache, then our write caching is less 
aggressive in reiser4 than I want it to be, and if it is something else 
then the ext3 guys need to look into it.

Thanks for doing this test.

-- 
Hans


