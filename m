Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUD2D5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUD2D5r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 23:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUD2D5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 23:57:42 -0400
Received: from smtp101.mail.sc5.yahoo.com ([216.136.174.139]:37745 "HELO
	smtp101.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263173AbUD2D5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 23:57:36 -0400
Message-ID: <40907D23.7000103@yahoo.com.au>
Date: Thu, 29 Apr 2004 13:57:23 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Paul Mackerras <paulus@samba.org>, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
References: <409021D3.4060305@fastclick.com>	<20040428170106.122fd94e.akpm@osdl.org>	<409047E6.5000505@pobox.com>	<40905127.3000001@fastclick.com>	<20040428180038.73a38683.akpm@osdl.org>	<16528.23219.17557.608276@cargo.ozlabs.ibm.com> <20040428185342.0f61ed48.akpm@osdl.org>
In-Reply-To: <20040428185342.0f61ed48.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Paul Mackerras <paulus@samba.org> wrote:
> 
>>Andrew Morton writes:
>>
>>
>>>My point is that decreasing the tendency of the kernel to swap stuff out is
>>>wrong.  You really don't want hundreds of megabytes of BloatyApp's
>>>untouched memory floating about in the machine.  Get it out on the disk,
>>>use the memory for something useful.
>>
>>What I have noticed with 2.6.6-rc1 on my dual G5 is that if I rsync a
>>gigabyte or so of data over to another machine, it then takes several
>>seconds to change focus from one window to another.  I can see it
>>slowly redraw the window title bars.  It looks like the window manager
>>is getting swapped/paged out.
>>
>>This machine has 2.5GB of ram, so I really don't see why it would need
>>to swap at all.  There should be plenty of page cache pages that are
>>clean and not in use by any process that could be discarded.  It seems
>>like as soon as there is any memory shortage at all it picks on the
>>window manager and chucks out all its pages. :(
>>
> 
> 
> I suspect rsync is taking two passes across the source files for its
> checksumming thing.  If so, this will defeat the pagecache use-once logic. 
> The kernel sees the second touch of the pages and assumes that there will
> be a third touch.
> 

I'm not very impressed with the pagecache use-once logic, and I
have a patch to remove it completely and treat non-mapped touches
(IMO) more sanely.
