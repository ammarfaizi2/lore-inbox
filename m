Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbTCJThm>; Mon, 10 Mar 2003 14:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTCJThl>; Mon, 10 Mar 2003 14:37:41 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:31696 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP
	id <S261457AbTCJThl>; Mon, 10 Mar 2003 14:37:41 -0500
Message-ID: <3E6CEC00.4030707@cox.net>
Date: Mon, 10 Mar 2003 12:48:16 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4a) Gecko/20030228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS in do_try_to_free_pages with VERY large software RAID array
References: <8075D5C3061B9441944E1373776451180F0761@cinshrexc03.shermfin.com> <6240000.1047324468@flay>
In-Reply-To: <6240000.1047324468@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> At a wild guess (OK, I only looked for about 1 minute),
> md_status_read_proc is generating more than 4K of information, and overwriting
> the end of it's 4K page. Throw some debug in there, and get it to printk
> how much of the buffer it thinks it's using (just printk sz every time it
> changes it). If it's > 4K, convert it to the seq_file interface.
> 
> May not be it, but it seems likely given the unusual scale of what you're
> doing, and it's easy to check.
> 
> M.

I posted a patch to do exactly this last week to the Linux-RAID mailing list. If 
you check the archives you should find it. This problem also occurs if you use 
the device-mapper under 2.5.X, because it makes all 256 md minors appear in the 
tables and /proc/mdstat wants to tell you about all of them.


