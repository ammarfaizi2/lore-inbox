Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266124AbUHFTQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266124AbUHFTQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266126AbUHFTQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:16:21 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:43531 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S266124AbUHFTQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:16:19 -0400
Message-ID: <4113D8AF.5030803@lougher.demon.co.uk>
Date: Fri, 06 Aug 2004 20:14:55 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-GB; rv:1.2.1) Gecko/20030228
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
References: <41127371.1000603@lougher.demon.co.uk> <4112D6FD.4030707@yahoo.com.au> <4112EAAB.8040005@yahoo.com.au> <4113B8A2.4050609@lougher.demon.co.uk> <4113D4CD.5080109@yahoo.com.au>
In-Reply-To: <4113D4CD.5080109@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> Phillip Lougher wrote:
> 
>> Nick Piggin wrote:
>>
>>> On second thought, maybe not. I think your filesystem is at fault.
>>
>>
>>
>> No I'm not wrong here. With a read-only filesystem i_size can
>> never change, there are no possible race conditions.  If a too
>> large index is passed it is a VFS bug.  Are you suggesting I should
>> start to code assuming the VFS is broken?
>>
> 
> No, I suggest you start to code assuming this interface does
> what it does. I didn't say there is no bug here, but nobody
> else's filesystem breaks.
> 

Point one: The interface didn't do this UNTIL you changed the code
Point two: Just because no one has reported other filesystem
breakage, it doesn't mean other filesystems have not broken.

Perhaps I should have the check in my code.  However, it is
still stupid to fix an occasional race by ensuring readpage() is
always called with an out of bounds index when files are 0 or a
4K multiple.  The filesystem check may prevent a crash, but it
is needlessly wasteful by design, not through any inadvertant
race condition.

think is it stupid to fix an o.  However, I it
stupid to fix a race co
ll think it stupid to fix a race you en

