Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030256AbWEZDOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWEZDOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 23:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWEZDOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 23:14:12 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:387 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030256AbWEZDOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 23:14:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5BigYx33/+7B2wefGQrhaM4e81OiWU3dmIJqQ9juTs9hGaNKksXwvZbsKAn/BijlJwsoTMG7UoCdApkY98f7lnP/lPi+0b4YRD1OBZbDSPW/ruNoPrhWhhrQWyHyeeKr2k/wE75ieSPD71ui52PsPu1rPpV9ke1ct7Fbc9LlyGM=  ;
Message-ID: <4476727C.8040803@yahoo.com.au>
Date: Fri, 26 May 2006 13:14:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050831 Debian/1.7.8-1sarge2
X-Accept-Language: en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       linux-kernel@vger.kernel.org, mstone@mathom.us
Subject: Re: [PATCH 00/33] Adaptive read-ahead V12
References: <348469535.17438@ustc.edu.cn>	 <20060525084415.3a23e466.akpm@osdl.org> <9e4733910605251910k3bcd434aq5f7410c53fc8b17d@mail.gmail.com>
In-Reply-To: <9e4733910605251910k3bcd434aq5f7410c53fc8b17d@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

> On 5/25/06, Andrew Morton <akpm@osdl.org> wrote:
>
>> These are nice-looking numbers, but one wonders.  If optimising 
>> readahead
>> makes this much difference to postgresql performance then postgresql 
>> should
>> be doing the readahead itself, rather than relying upon the kernel's
>> ability to guess what the application will be doing in the future.  
>> Because
>> surely the database can do a better job of that than the kernel.
>>
>> That would involve using posix_fadvise(POSIX_FADV_RANDOM) to disable 
>> kernel
>> readahead and then using posix_fadvise(POSIX_FADV_WILLNEED) to launch
>> application-level readahead.
>
>
> Users have also reported that this patch fixes performance problems
> from web servers using sendfile(). In the case of lighttpd they
> actually stopped using sendfile() for large transfers and wrote a user
> space replacement where they could control readahead manually. With
> this patch in place sendfile() went back to being faster than the user
> space implementation.


Of course, that is something one would expect should be made to work 
properly
with the current readahead implementation.

I don't see Wu's patches getting in for a little while yet.

Reproducable test cases (preferably without a whole lot of network clients)
should get this proble fixed.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
