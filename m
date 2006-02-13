Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbWBMAy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbWBMAy3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWBMAy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:54:29 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:23777 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1751105AbWBMAy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:54:28 -0500
Message-ID: <43EFD8BF.1040205@tlinx.org>
Date: Sun, 12 Feb 2006 16:54:23 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: max symlink = 5? ?bug? ?feature deficit?
References: <43ED5A7B.7040908@tlinx.org> <20060212180601.GU27946@ftp.linux.org.uk> <43EFA63B.30907@tlinx.org> <20060212212504.GX27946@ftp.linux.org.uk> <43EFBCA9.1090501@tlinx.org> <20060213000803.GY27946@ftp.linux.org.uk>
In-Reply-To: <20060213000803.GY27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sun, Feb 12, 2006 at 02:54:33PM -0800, Linda Walsh wrote:
>   
>> Al Viro wrote:
>>     
>>> Care to RTFS? I mean, really - at least to the point of seeing what's
>>> involved in that recursion.
>>>  
>>>       
>> Hmmm...that's where I got the original parameter numbers, but
>> I see it's not so straightforward.  I tried a limit of
>> 40, but I quickly get an OS hang when trying to reference a
>> 13th link.  Twelve works at the limit, but would take more testing
>> to find out the bottleneck.
>>     
>
> Sigh...  12 works at the limit on your particular config, filesystems
> being used and syscall being issued (hint: amount of stuff on stack
> before we enter mutual recursion varies; so does the amount of stuff
> on stack we get from function that are not part of mutual recursion,
> but are called from the damn thing).
>   
---
    Yeah, I sorta figured that.  Is there any easier way to
remove the recursion?  I dunno about you, but I was always taught
that recursion, while elegant, was not always the most efficient in
terms of time and space requirements and one could get similar
functionality using iteration and a stack.

    The GNU libraries _seem_ to indicate a max of 20 links supported
there.  Googling around, I see I'm not the first person to be surprised
by the low limit.  I don't recall running into such a limit on any
other Unixes, though I'm sure they had some limit.

    It can be useful for creating a shadow file-system where only
root needs to point to a "target source", and the "symlink" overlay
lies over the top of any real, underlying file.

    Why can't things just be easy sometimes...:-/
Linda
