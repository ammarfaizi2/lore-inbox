Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWB0KLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWB0KLH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 05:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWB0KLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 05:11:07 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:41101 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750920AbWB0KLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 05:11:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=5qnVP+Vh4bGodOWFRrn3b6bXiS5zGJg6W0btwFATJRi+GCktjC38FUMmj3WphnMk+bCkZ0hPylghAimKjB79hzbMx+ew4NyM2NVbST1VMF1qPlIJbvW/D3/GLD+tcSEwMFDM9DhiqXbcbHUxG0haP/CWc3iQU+0JMmSG71i4mII=  ;
Message-ID: <4402D039.1050307@yahoo.com.au>
Date: Mon, 27 Feb 2006 21:11:05 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: john@johnmccutchan.com
CC: Andrew Morton <akpm@osdl.org>, holt@sgi.com, linux-kernel@vger.kernel.org,
       rml@novell.com, arnd@arndb.de, hch@lst.de,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: udevd is killing file write performance.
References: <20060222134250.GE20786@lnx-holt.americas.sgi.com>	 <1140626903.13461.5.camel@localhost.localdomain>	 <20060222175030.GB30556@lnx-holt.americas.sgi.com>	 <1140648776.1729.5.camel@localhost.localdomain>	 <20060222151223.5c9061fd.akpm@osdl.org>	 <1140651662.2985.2.camel@localhost.localdomain>	 <20060223161425.4388540e.akpm@osdl.org>	 <20060224054724.GA8593@johnmccutchan.com>	 <20060223220053.2f7a977e.akpm@osdl.org>  <43FEB0BF.6080403@yahoo.com.au> <1140972918.15634.1.camel@localhost.localdomain>
In-Reply-To: <1140972918.15634.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:
> On Fri, 2006-24-02 at 18:07 +1100, Nick Piggin wrote:

>>I saw this problem when testing my lockless pagecache a while back.
>>
>>Attached is a first implementation of what was my idea then of how
>>to solve it... note it is pretty rough and I never got around to doing
>>much testing of it.
>>
>>Basically: moves work out of inotify event time and to inotify attach
>>/detach time while staying out of the core VFS.
> 
> 
> 
> This looks really good. There might be some corner cases but it looks
> like it will solve this problem nicely.
> 

Thanks. You should see I sent a new version which fixes several bugs
and cleans up the code a bit.

There might be some areas of potential problems:
- creating and deleting watches on directories with many entries will
   take a long time. Is anyone likely to be creating and destroying
   these things at a very high frequency? Probably nobody cares except
   it might twist some real-time knickers.

- concurrent operations in the same watched directory will incur the
   same scalability penalty. I think this is basically a non-issue since
   the sheer number of events coming out will likely be a bigger problem.
   Doctor, it hurts when I do this.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
