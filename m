Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbUD2BZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbUD2BZI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 21:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbUD2BZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 21:25:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21721 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262499AbUD2BZA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 21:25:00 -0400
Message-ID: <4090595D.6050709@pobox.com>
Date: Wed, 28 Apr 2004 21:24:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: brettspamacct@fastclick.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com>	<20040428170106.122fd94e.akpm@osdl.org>	<409047E6.5000505@pobox.com>	<40905127.3000001@fastclick.com> <20040428180038.73a38683.akpm@osdl.org>
In-Reply-To: <20040428180038.73a38683.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Brett E." <brettspamacct@fastclick.com> wrote:
> 
>> Or how about "Use ALL the cache you want Mr. Kernel.  But when I want 
>> more physical memory pages, just reap cache pages and only swap out when 
>> the cache is down to a certain size(configurable, say 100megs or 
>> something)."
> 
> 
> Have you tried decreasing /proc/sys/vm/swappiness?  That's what it is for.
> 
> My point is that decreasing the tendency of the kernel to swap stuff out is
> wrong.  You really don't want hundreds of megabytes of BloatyApp's
> untouched memory floating about in the machine.  Get it out on the disk,
> use the memory for something useful.

Well, if it's truly untouched, then it never needs to be allocated a 
page or swapped out at all... just accounted for (overcommit on/off, 
etc. here)

But I assume you are not talking about that, but instead talking about 
_rarely_ used pages, that were filled with some amount of data at some 
point in time.  These are at the heart of the thread (or my point, at 
least) -- BloatyApp may be Oracle with a huge cache of its own, for 
which swapping out may be a huge mistake.  Or Mozilla.  After some 
amount of disk IO on my 512MB machine, Mozilla would be swapped out... 
when I had only been typing an email minutes before.

BloatyApp?  yes.  Should it have been swapped out?  Absolutely not.  The 
'SIZE' in top was only 160M and there were no other major apps running.

Applications are increasingly playing second fiddle to cache ;-(

Regardless of /proc/sys/vm/swappiness, I think it's a valid concern of 
sysadmins who request "hard cache limit", because they are seeing 
pathological behavior such that apps get swapped out when cache is over 
50% of all available memory.

	Jeff


