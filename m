Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932247AbWGKX2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWGKX2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWGKX2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:28:42 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:29659
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932247AbWGKX2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:28:40 -0400
Message-ID: <44B43409.2020401@microgate.com>
Date: Tue, 11 Jul 2006 18:28:09 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jon Smirl <jonsmirl@gmail.com>, Theodore Tso <tytso@mit.edu>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: tty's use of file_list_lock and file_move
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>	 <1152552806.27368.187.camel@localhost.localdomain>	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>	 <1152554708.27368.202.camel@localhost.localdomain>	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>	 <1152573312.27368.212.camel@localhost.localdomain>	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>	 <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>	 <20060711012904.GD30332@thunk.org>	 <20060711194456.GA3677@flint.arm.linux.org.uk>	 <9e4733910607111508x526ee642p5b587698306b22d3@mail.gmail.com> <1152657465.18028.72.camel@localhost.localdomain>
In-Reply-To: <1152657465.18028.72.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-07-11 am 18:08 -0400, ysgrifennodd Jon Smirl:
> 
>>What about adjusting things so the BKL isn't required? I tried
>>completely removing it and died in release_dev. tty_mutex is already
>>locks a lot of stuff, maybe it can be adjusted to allow removal of the
>>BKL.
> 
> 
> Thats what is happening currently. However it is being done piece by
> piece, slowly and carefully.

I hate to chime in since I don't have time in the near term
to contribute to the subject, but I do like the idea of removing
the BKL dependence as a first step. I find its semantics akward to keep
track of, and error prone. More explicit locking, even global, would clear things
up for a later push to finer grained (per tty?) locking (where appropriate).

Making the necessary changes to all the individual drivers,
as Russel's comment about explicitly dropping the new lock when
sleeping pointed out, would be a time consuming (and probably
tedious) task.

--
Paul

