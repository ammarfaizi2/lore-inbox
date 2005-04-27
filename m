Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVD0VKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVD0VKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 17:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD0VKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 17:10:48 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48270 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262017AbVD0VKh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 17:10:37 -0400
Message-ID: <426FFFAB.1030005@tmr.com>
Date: Wed, 27 Apr 2005 17:10:03 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Magnus Damm <magnus.damm@gmail.com>,
       mason@suse.com, torvalds@osdl.org, mike.taht@timesys.com,
       mpm@selenic.com, linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
References: <20050426135606.7b21a2e2.akpm@osdl.org><20050426135606.7b21a2e2.akpm@osdl.org> <20050427063439.GA22014@elte.hu>
In-Reply-To: <20050427063439.GA22014@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> 
>>Magnus Damm <magnus.damm@gmail.com> wrote:
>>
>>>My primitive guess is that it was because
>>> the ext3 journal became full.
>>
>>The default ext3 journal size is inappropriately small, btw.  Normally 
>>you should manually make it 128M or so, rather than 32M.  Unless you 
>>have a small amount of memory and/or a large number of filesystems, in 
>>which case there might be problems with pinned memory.
>>
>>Mounting as ext2 is a useful technique for determining whether the fs 
>>is getting in the way.
> 
> 
> on ext3, when juggling patches and trees, the biggest performance boost 
> for me comes from adding noatime,nodiratime to the mount options in 
> /etc/fstab:
> 
>  LABEL=/ / ext3 noatime,nodiratime,defaults 1 1

I said much the same in another post, but noatime is not always what I 
really want. How about a "nojournalatime" option, so the atime would be 
updated at open and close, but not journaled at any other time. This 
would reduce journal traffic but still allow an admin to tell if anyone 
ever uses a file. The info would be lost in a crash, but otherwise 
preserved just as it is for ext2. Might even be useful for ext2, not to 
write the atime, just track it in core.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
