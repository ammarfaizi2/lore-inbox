Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUD2Afa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUD2Afa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUD2Afa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:35:30 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:54182 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262213AbUD2AfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:35:23 -0400
Message-ID: <40904A84.2030307@yahoo.com.au>
Date: Thu, 29 Apr 2004 10:21:24 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, brettspamacct@fastclick.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com>
In-Reply-To: <409047E6.5000505@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Andrew Morton wrote:
> 
>> Swapout is good.  It frees up unused memory.  I run my desktop 
>> machines at
>> swappiness=100.
> 
> 
> 
> The definition of "unused" is quite subjective and app-dependent...
> 
> I've see reports with increasing frequency about the swappiness of the 
> 2.6.x kernels, from people who were already annoyed at the swappiness of 
> 2.4.x kernels :)
> 
> Favorite pathological (and quite common) examples are the various 4am 
> cron jobs that scan your entire filesystem.  Running that process 
> overnight on a quiet machines practically guarantees a huge burst of 
> disk activity, with unwanted results:
> 1) Inode and page caches are blown away
> 2) A lot of your desktop apps are swapped out
> 
> Additionally, a (IMO valid) maxim of sysadmins has been "a properly 
> configured server doesn't swap".  There should be no reason why this 
> maxim becomes invalid over time.  When Linux starts to swap out apps the 
> sysadmin knows will be useful in an hour, or six hours, or a day just 
> because it needs a bit more file cache, I get worried.
> 

I don't know. What if you have some huge application that only
runs once per day for 10 minutes? Do you want it to be consuming
100MB of your memory for the other 23 hours and 50 minutes for
no good reason?

Anyway, I have a small set of VM patches which attempt to improve
this sort of behaviour if anyone is brave enough to try them.
Against -mm kernels only I'm afraid (the objrmap work causes some
porting difficulty).
