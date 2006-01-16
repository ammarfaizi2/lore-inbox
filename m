Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWAPJa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWAPJa0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWAPJaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:30:10 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:45507 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932281AbWAPJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:30:02 -0500
Message-ID: <43CB6796.4040104@namesys.com>
Date: Mon, 16 Jan 2006 01:29:58 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, linux-xfs@oss.sgi.com,
       Jeff Mahoney <jeffm@suse.com>, Mattia Dongili <malattia@linux.it>
Subject: Re: 2.6.15-mm3 bisection: git-xfs.patch makes reiserfs oops
References: <20060110235554.GA3527@inferi.kami.home> <20060110170037.4a614245.akpm@osdl.org> <20060115221458.GA3521@inferi.kami.home> <20060116094817.A8425113@wobbly.melbourne.sgi.com>
In-Reply-To: <20060116094817.A8425113@wobbly.melbourne.sgi.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nathan, Mattia, and Andrew.

vs, can you or Jeff look at whether our buffer head inits are
sufficiently hardened by next Monday (I know that vs has a lot of mail
to catch up to)?  Jeff, if you have time before then, it would be nice
if you could handle it, I know hardening V3 is an interest of yours.

Thanks,

Hans

 Nathan Scott wrote:

>On Sun, Jan 15, 2006 at 11:14:58PM +0100, Mattia Dongili wrote:
>  
>
>>[CC-in relevant people/ML]
>>
>>Hello!
>>
>>second bisection result!
>>
>>On Tue, Jan 10, 2006 at 05:00:37PM -0800, Andrew Morton wrote:
>>    
>>
>>>Mattia Dongili <malattia@linux.it> wrote:
>>>      
>>>
>>[...]
>>    
>>
>>>>1- reiser3 oopsed[1] twice while suspending to ram. It seems
>>>>   reproducible (have some activity on the fs and suspend)
>>>>        
>>>>
>>>No significant reiser3 changes in there, so I'd be suspecting something
>>>else has gone haywire.
>>>      
>>>
>>you're right: git-xfs.patch is the bad guy.
>>
>>Unfortunately netconsole isn't helpful in capturing the oops (no serial
>>ports here) but I have two more shots (more readable):
>>http://oioio.altervista.org/linux/dsc03148.jpg
>>http://oioio.altervista.org/linux/dsc03149.jpg
>>    
>>
>
>Hmm, thats odd.  It seems to be coming from:
>reiserfs_commit_page -> reiserfs_add_ordered_list -> __add_jh(inline)
>
>I guess XFS may have left a buffer_head in an unusual state (with some
>private flag/b_private set), somehow, and perhaps that buffer_head has
>later been allocated for a page in a reiserfs write.  Does this patch,
>below, help at all?
>
>I see one BUG check in __add_jh for non-NULL b_private, but can't see
>the top of your console output from the photos - is there a preceding
>line with "kernel BUG at ..." in it?
>
>cheers.
>
>  
>

