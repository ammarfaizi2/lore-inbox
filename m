Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310331AbSCLCXf>; Mon, 11 Mar 2002 21:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310335AbSCLCX0>; Mon, 11 Mar 2002 21:23:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58635 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310331AbSCLCXS>;
	Mon, 11 Mar 2002 21:23:18 -0500
Message-ID: <3C8D667F.5040208@mandrakesoft.com>
Date: Mon, 11 Mar 2002 21:22:55 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Bill Davidsen <davidsen@tmr.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.4.33.0203111741310.8121-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Mon, 11 Mar 2002, Jeff Garzik wrote:
>
>>Linus, would it be acceptable to you to include an -optional- filter for
>>ATA commands?  There is definitely a segment of users that would like to
>>firewall their devices, and I think (as crazy as it may sound) that
>>notion is a valid one.
>>
>
>I'd rather have the rule that you can turn off this feature altogther: if
>the command is so esoteric that it's not part of the regular commands we
>can generate on our own, 99% of all people probably aren't even interested
>in it.
>
Are we talking about the same thing or different things?

If filtering is done, I agree the filter feature is disable-able if the 
kernel builder / sysadmin desires such.  Disable the filter by default, 
if that's your fancy.  But let us filter.  :)

>If the command is useful on its own, and has a generic meaning (ie across
>a large subset of users), then I think the kernel should support it
>through a _real_ interface, not through some "pass user data though
>inscathed" thing. Because that generic meaning probably exists even
>outside ATA drives.
>
Let me first agree on a point, to get that out of the way.  I agree 
there is generic meaning outside of ATA drives,for most of the ATA[PI] 
commands.  Further, I hope you know by now I agree with your taste in 
kernel interfaces :)

First, for verification of the driver, it's darned useful to be able to 
issue ATA commands from userspace.  But since we're being generic, let's 
just call them device commands, and imagine SCSI perhaps playing in this 
playground too.

Second, if you are issuing device commands from userspace, you need to 
deal with synchronization with the commands being issued from kernel space.

Third, if you have synchronization, that's a good and easy point to add 
-optional- filtering.

Now... the overall point I am trying to sell is...  IFF certain 
lesser-used device commands are primarily issued from userspace, and IFF 
it is not reasonable to create a new kernel interface, is it not 
reasonable to be able to issue raw device commands from userspace?  Just 
the verification case alone seems like a strong argument.

Call it device_command not ata_command if you want, and add SCSI 
support.  Passing in raw device_commands from userspace is useful, IMO. 
 Throw in filtering of those commands, and life is golden for everybody 
AFAICS.  There is no need to be ATA specific with these goals...

    Jeff



