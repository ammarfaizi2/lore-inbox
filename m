Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310234AbSCLAfK>; Mon, 11 Mar 2002 19:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310238AbSCLAe7>; Mon, 11 Mar 2002 19:34:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10249 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310234AbSCLAep>;
	Mon, 11 Mar 2002 19:34:45 -0500
Message-ID: <3C8D4D12.90606@mandrakesoft.com>
Date: Mon, 11 Mar 2002 19:34:26 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

>On Mon, 11 Mar 2002, Linus Torvalds wrote:
>
>>Note that I've actually tried to read all patches, and right now they are 
>>all in my tree (of course, the "all" is the Linus kind of "all", which 
>>only includes the ones I actually _noticed_. 
>>
>>That includes your AMD IDE driver change _and_ the oh-so-much-discussed
>>patches by Martin (which in turn included Pavel's change, which - together
>>with his changelog entry - seems to be the one that triggered the "lively
>>discussions").
>>
>
>I think you might want to offer an opinion (or edict, mandate, whatever)
>WRT taskfile. While I think that some protective editing of commands is
>desirable, useful, etc, I'm damn sure that some form of raw access is
>required long term to allow diagmostics. I wouldn't argue if that
>interface was required for low level format and other really drastic
>operations as well.
>
One sticking point seems to be the question of whether there needs to be 
some amount of validation performed on the commands passed through the 
taskfile interface.  I don't think Andre buys into the argument that 
most other kernel hackers understand, which is, "if userspace is allowed 
to bang away at random i/o ports, why validate taskfile  requests in the 
kernel?"

And IMO, we should have some basic validation of taskfile requests in 
the kernel...
Reason 1: Standard kernel convention.  In other ioctls, we check basic 
arguments and return EINVAL when they are wrong, even for privieleged 
ioctls.
Reason 2: If you have multiple programs issuing ATA commands, you would 
want a decent amount of synchronization, provided by the kernel, for the 
multiple user processes and multiple kernel processes issuing requests. 
 Having the userspace commands come down a single spot in the kernel 
code makes this job a lot easier, if not making the impossible possible :)

Regards,

    Jeff








