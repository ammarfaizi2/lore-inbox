Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310371AbSCLDLP>; Mon, 11 Mar 2002 22:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310372AbSCLDLG>; Mon, 11 Mar 2002 22:11:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29708 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310371AbSCLDKz>;
	Mon, 11 Mar 2002 22:10:55 -0500
Message-ID: <3C8D71AC.3080305@mandrakesoft.com>
Date: Mon, 11 Mar 2002 22:10:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: "J. Dow" <jdow@earthlink.net>
CC: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com> <3C8D667F.5040208@mandrakesoft.com> <01a401c1c970$aeb74110$1125a8c0@wednesday>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Dow wrote:

>From: "Jeff Garzik" <jgarzik@mandrakesoft.com>
>
>>Second, if you are issuing device commands from userspace, you need to 
>>deal with synchronization with the commands being issued from kernel space.
>>
>Generally speaking, yes.
>
cool

>>Third, if you have synchronization, that's a good and easy point to add 
>>-optional- filtering.
>>
>And while I see your point I still ask, "But why?" To make this work the
>way it should work you will need a special table of normally disallowed
>commands that are allowed for each specific device on the IDE buses
>within a machine.
>
[...]

>It might be a good exercise, Jeff, to define the filters in such a way
>that potentially harmful commands can be adequately filters while other
>potentially "saving" commands can be allowed even if they differ only in
>parameters. It is also interesting to note that direct userland ATA and
>
I'm afraid I may have been confusing to the casual reader, because the 
current thread of discussion mutated from talking about (among other 
things) implementation details of the existing ATA raw command "filter" 
and the existing interface for issuing raw ATA commands.

You can, certainly, make a filter that addresses the issues you list. 
 The existing filter is mainly a correctness filter -- it ensures that 
only known and standard ATA commands are passed down to the actual 
devices.  It filters out vendor-specific commands as well as potentially 
nefarious future commands like COPYPROTECT or somesuch.

So, to summarize my points on the thread so far (as modified by Linus's 
responses to me):

1) There should be a raw device command interface (not ATA or SCSI specific)
2) There should be kernel interfaces for the standard cases, so that the 
raw device command interface is often not needed
3) There should be capability to optionally install filter the raw 
device command interface.  The filter is built into the kernel at 
compile-time, but can also be disabled at boot time.

    Jeff




