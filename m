Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751907AbWCEXDJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbWCEXDJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWCEXDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:03:09 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:55782 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751907AbWCEXDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:03:08 -0500
Message-ID: <440B6E05.9010609@tlinx.org>
Date: Sun, 05 Mar 2006 15:02:29 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Marr <marr@flex.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Readahead value 128K? (was Re: Drastic Slowdown of 'fseek()' Calls
 From 2.4 to 2.6 -- VMM Change?)
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <440374DF.8080901@namesys.com> <4403935A.3080503@tmr.com>
In-Reply-To: <4403935A.3080503@tmr.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does this happen with a seek call as well, or is this limited
to fseek?

if you look at "hdparm's" idea of read-ahead, what does it say
for the device?.  I.e.:

hdparm /dev/hda:

There is a line entitled "readahead".  What does it say?

I noticed that this seems to default to "256" sectors, or 128K
in 2.6.

This may be unrelated, but what does the kernel do with
this number?  I seem to remember this being set to ~8-16 (4-8K)
in 2.4.  I thought it was the number of sectors to read ahead, by
default, when a read was done, but I haven't noticed a performance
degradation like I would expect for such a large read-ahead value.

On the other hand: you do seem to be experiencing something consistent
with that setting.  I'm not sure under what circumstances the kernel
uses the "readahead" value as a number of sectors to read ahead...

Have the disk read routines changed with respect to this value?

-linda
< bottom or top posting is a personal preference somewhat based
on the email tool one uses.  In a GUI, bottom posting often means
you can't see what the person wrote without skipping to the end
of message.  When dealing with Chronological information, it
often makes more sense to put the most recent information _first>

Bill Davidsen wrote:
> Hans Reiser wrote:
>> Andrew Morton wrote:
>>> runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k 
>>> read
>>> on every fseek.
>>>
>>> - There may be a libc stdio function which allows you to tune this
>>>  behaviour.
>>>
>>> - libc should probably be a bit more defensive about this anyway -
>>>  plainly the filesystem is being silly.
>> I really thank you for isolating the problem, but I don't see how you
>> can do other than blame glibc for this.  The recommended IO size is only
>> relevant to uncached data, and glibc is using it regardless of whether
>> or not it is cached or uncached.   Do I misunderstand something 
>> myself here?
> I think the issue is not "blame" but what effect this behavior would 
> have on things like database loads, where seek-write would be common. 
> Good to get this info to users and admins.
>
