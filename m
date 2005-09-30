Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030461AbVI3WE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030461AbVI3WE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbVI3WE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:04:29 -0400
Received: from zctfs063.nortelnetworks.com ([47.164.128.120]:35738 "EHLO
	zctfs063.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932597AbVI3WE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:04:28 -0400
Message-ID: <433DB64B.70405@nortel.com>
Date: Fri, 30 Sep 2005 16:03:55 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "Theodore Ts'o" <tytso@mit.edu>, dipankar@in.ibm.com,
       viro@ftp.linux.org.uk
Subject: Re: dentry_cache using up all my zone normal memory
References: <433189B5.3030308@nortel.com>
In-Reply-To: <433189B5.3030308@nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2005 22:04:19.0817 (UTC) FILETIME=[E83C5D90:01C5C60A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:VC21:EXCH] wrote:

> With a bit of digging the culprit appears to be the dentry_cache.  The 
> last log I have shows it using 817MB of memory.  Right after that the 
> oom killer kicked me off the system.  When I logged back in, the cache 
> usage was back down to normal and everything was fine.

There hasn't been any new suggestions as to the culprit, so I started 
experimenting a bit.

It turns out that if I limit the memory on the system to 896MB, the 
dcache slab usage peaks at around 600MB and sits there for the duration 
of the test.

When I limit the memory to 1024MB, the dcache slab chews up all my zone 
normal memory and the oom killer runs.

It almost seems like the dcache responds to memory pressure on the 
system as a whole, but not as well to pressure on zone normal.  Would 
this make sense?

Chris
