Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287939AbSBMRjW>; Wed, 13 Feb 2002 12:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSBMRjJ>; Wed, 13 Feb 2002 12:39:09 -0500
Received: from [195.63.194.11] ([195.63.194.11]:18186 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S287946AbSBMRis>; Wed, 13 Feb 2002 12:38:48 -0500
Message-ID: <3C6AA495.3030103@evision-ventures.com>
Date: Wed, 13 Feb 2002 18:38:29 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <Pine.LNX.4.33.0202131059250.13632-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>
>On Wed, 13 Feb 2002, Jeff Garzik wrote:
>
>>Applying a patch like s/virt_to_bus/virt_to_phys/ makes it more
>>difficult to find the right spots to change later.
>>
>
>Yes and no.
>
>The thing is, for architectures that care, you can just grep for
>"virt_to_phys()". It's basically _never_ the right thing to do on
>something like sparc.
>
>My personal preference would actually be to keep "virt_to_bus()" for x86
>for now, and undo the change to make it complain. Instead, make it
>complain on other architectures where it _is_ wrong, so that you don't
>have to fix up drivers that simply aren't an issue. What's the point of
>breaking some drivers that only exist on x86?
>
I think that the suggestion from Jeff Garzik, that there is currently 
just too much of code
duplication for quite common cases in drivers is the right way to go. 
Most of the
stuff doing the virt_to_phys is doing quite common things from a broader 
point of view.

Well even worser, there is quite a lot of code replication there as well 
...  see for example the
ide and scsi midlayers ;-). The whole hostadapter/iobus/device stuff 
handling could be made common
at least. There is no real need for different driver handler lookup 
mechanisms between them.

HWIF(device)-> and Scsi_Host_Templ come into mind...


