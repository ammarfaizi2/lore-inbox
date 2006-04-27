Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWD0F1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWD0F1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 01:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbWD0F1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 01:27:55 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:37300 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964935AbWD0F1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 01:27:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Sz4SmPdG4dBWvJfn3l9nFcflkNMF2RIeACpzIt/wbZ/ivkbfa38EmFU4G6xzDXV1owfTpxLX+1yrMklRg/IHyMybgsUVPziEtZca/1MxesrHRg6WNvE7K/K//4jLa6WsjyW5YrqAEEC9QE6p4WIWVpRKeHnHZkH66in5Qop8REk=  ;
Message-ID: <4450551D.5050000@yahoo.com.au>
Date: Thu, 27 Apr 2006 15:22:37 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org, npiggin@suse.de,
       linux-mm@kvack.org
Subject: Re: Lockless page cache test results
References: <20060426135310.GB5083@suse.de>	<20060426095511.0cc7a3f9.akpm@osdl.org>	<20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
In-Reply-To: <20060426111054.2b4f1736.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>>The top of the 4-client
>>vanilla run profile looks like this:
>>
>>samples  %        symbol name
>>65328    47.8972  find_get_page
>>
>>Basically the machine is fully pegged, about 7% idle time.
> 
> 
> Most of the time an acquisition of tree_lock is associated with a disk
> read, or a page-size memset, or a page-size memcpy.  And often an
> acquisition of tree_lock is associated with multiple pages, not just a
> single page.

Still, most of the times it is acquired would be once per page for
read, write, nopage.

For read and write, often it will be a full page memcpy but even such
a memcpy operation can quickly become insignificant compared to tl
contention.

Anyway, whatever. What needs to be demonstrated are real world
improvements at the end of the day.

> 
> So although the graph looks good, I wouldn't view this as a super-strong
> argument in favour of lockless pagecache.

No. Cool numbers though ;)

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
