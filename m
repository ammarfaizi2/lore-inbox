Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWELVqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWELVqm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 17:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWELVql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 17:46:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:1224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932169AbWELVqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 17:46:40 -0400
Date: Fri, 12 May 2006 14:46:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Erik Mouw <erik@harddisk-recovery.com>,
       Or Gerlitz <or.gerlitz@gmail.com>, linux-scsi@vger.kernel.org,
       axboe@suse.de, Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
Subject: Re: [BUG 2.6.17-git] kmem_cache_create: duplicate cache scsi_cmd_cache
In-Reply-To: <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0605121439070.3866@g5.osdl.org>
References: <20060511151456.GD3755@harddisk-recovery.com>
 <15ddcffd0605112153q57f139a1k7068e204a3eeaf1f@mail.gmail.com>
 <20060512171632.GA29077@harddisk-recovery.com> <Pine.LNX.4.64.0605121024310.3866@g5.osdl.org>
 <1147456038.3769.39.camel@mulgrave.il.steeleye.com>
 <1147460325.3769.46.camel@mulgrave.il.steeleye.com>
 <Pine.LNX.4.64.0605121209020.3866@g5.osdl.org> <20060512203850.GC17120@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605121346060.3866@g5.osdl.org> <20060512205804.GD17120@flint.arm.linux.org.uk>
 <Pine.LNX.4.64.0605121409250.3866@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 May 2006, Linus Torvalds wrote:
> 
> You introduced a commit that fixed one thing, and broke another thing.

And btw, don't take that "you" personally. 

This happens.

All the time. And definitely _not_ just to you. 

It's why common infrastructure can be such an incredible pain: it may be a 
nice common layer, but it does obviously end up affecting a hell of a lot 
of different devices and usages. "Private" code is often much better, and 
that's what we used to have.

Now, sadly, I think we need that common device layer infrastructure 
exactly because otherwise we could never have done any global device 
management etc, so in this case that common interface is definitely a 
"necessary evil". 

And with that necessary evil comes the linkages that it implies. 

We'd all be much happier of one piece of code didn't depend on five or six 
other pieces of code, and a bug-fix in one place would be guaranteed to 
not ever have any other side effects.

We'd all also be much happier if we were all young, healthy, good-looking 
and drive Lamborghinis. And didn't have incipient beer-bellies (not that 
_I_ would ever have one, of course.. Oh, no. I'm obviously talking about 
all you other scruffy people. Me, I'm perfect.)

Sadly, neither of the above schenarios are really very realistic.

So we'd love to have more information. Please?

		Linus
