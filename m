Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbWBXHTY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbWBXHTY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWBXHTY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:19:24 -0500
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:9339 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750781AbWBXHTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:19:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Z2uekhz613ucj2abXI8bhkpvPZ1MlSbEnuJRKeeNYDykWdTf7YwHn4PA+rultPoLB0bQsBb/CKCA9MZ17vx/RhuOT41wkdY1kCcViVl5xIhStOUis8iB9uNLDAGSCIbJrFZB+VZGjCeJSVfAFEKJO0/zn37e6sG1yhmnkM66KIs=  ;
Message-ID: <43FEB370.6030101@yahoo.com.au>
Date: Fri, 24 Feb 2006 18:19:12 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: john@johnmccutchan.com, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de, dipankar@in.ibm.com
Subject: Re: udevd is killing file write performance.
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>	<1140626903.13461.5.camel@localhost.localdomain>	<20060222175030.GB30556@lnx-holt.americas.sgi.com>	<1140648776.1729.5.camel@localhost.localdomain>	<20060222151223.5c9061fd.akpm@osdl.org>	<1140651662.2985.2.camel@localhost.localdomain>	<20060223161425.4388540e.akpm@osdl.org>	<20060224054724.GA8593@johnmccutchan.com>	<20060223220053.2f7a977e.akpm@osdl.org>	<43FEB0BF.6080403@yahoo.com.au> <20060223231621.0f5d5b8a.akpm@osdl.org>
In-Reply-To: <20060223231621.0f5d5b8a.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>@@ -538,7 +579,7 @@ void inotify_dentry_parent_queue_event(s
>>  	struct dentry *parent;
>>  	struct inode *inode;
>>  
>> -	if (!atomic_read (&inotify_watches))
>> +	if (!(dentry->d_flags & DCACHE_INOTIFY_PARENT_WATCHED))
> 
> 
> Yeah, I think that would work.  One would need to wire up d_move() also -
> for when a file is moved from a watched to non-watched directory and
> vice-versa.
> 
> 

Oh yeah of course, good catch. Are there any other cases missing?

... I'll let the others on this thread digest before spitting out
another patch.

John or Robert, is there some kind of inotify test suite around?

Thanks,

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
