Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262103AbUD2AKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUD2AKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUD2AKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:10:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2262 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262103AbUD2AK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:10:29 -0400
Message-ID: <409047E6.5000505@pobox.com>
Date: Wed, 28 Apr 2004 20:10:14 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org>
In-Reply-To: <20040428170106.122fd94e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Swapout is good.  It frees up unused memory.  I run my desktop machines at
> swappiness=100.


The definition of "unused" is quite subjective and app-dependent...

I've see reports with increasing frequency about the swappiness of the 
2.6.x kernels, from people who were already annoyed at the swappiness of 
2.4.x kernels :)

Favorite pathological (and quite common) examples are the various 4am 
cron jobs that scan your entire filesystem.  Running that process 
overnight on a quiet machines practically guarantees a huge burst of 
disk activity, with unwanted results:
1) Inode and page caches are blown away
2) A lot of your desktop apps are swapped out

Additionally, a (IMO valid) maxim of sysadmins has been "a properly 
configured server doesn't swap".  There should be no reason why this 
maxim becomes invalid over time.  When Linux starts to swap out apps the 
sysadmin knows will be useful in an hour, or six hours, or a day just 
because it needs a bit more file cache, I get worried.

There IMO should be some way to balance the amount of anon-vma's such 
that the sysadmin can say "stop taking 70% of my box's memory for 
disposable cache, use it instead for apps you would otherwise swap out, 
you memory-hungry kernel you."

	Jeff



