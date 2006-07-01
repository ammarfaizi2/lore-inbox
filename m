Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWGAWbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWGAWbz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 18:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWGAWbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 18:31:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:54161 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751237AbWGAWby
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 18:31:54 -0400
Message-ID: <44A6F7C4.1090201@zytor.com>
Date: Sat, 01 Jul 2006 15:31:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Theodore Tso <tytso@mit.edu>, Jeff Bailey <jbailey@ubuntu.com>,
       Michael Tokarev <mjt@tls.msk.ru>, Roman Zippel <zippel@linux-m68k.org>,
       klibc@zytor.com, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [klibc] klibc and what's the next step?
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060630181131.GA1709@elf.ucw.cz> <44A5AE17.4080106@tls.msk.ru> <44A5B07E.9040007@zytor.com> <1151751417.2553.8.camel@localhost.localdomain> <20060701150506.GA10517@thunk.org> <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607011306060.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 1 Jul 2006, Theodore Tso wrote:
>> This is going to be a problem given that people are hell-bent at
>> chucking functionality out of the kernel into userspace.
> 
> Btw, I'm not necessarily one of those people.
> 
> There _are_ some things that can be better done in user space, but on the 
> other hand, other things really are better off in the kernel.
> 
> The argument that user space is more debuggable has been shown to be 
> largely a red herring. User space is only more debuggable if it does 
> something independent, and we've seen that user space is _harder_ to debug 
> than kernel space if we have events going back and forth.
>

Indeed.  The stuff that have been moved to userspace in the first cut of 
klibc are stuff which can largely be tested independently, usually just 
from the normal command line.  This is incredibly powerful, but it is 
not -- and shouldn't be -- universally applied just because it can; it 
should be applied if and when it makes sense.

> For example, the old pcmcia layer in user space was crap, crap, crap, and 
> at least I fount it was MUCH harder to debug than the all-in-kernel code.

I have my own share of debugging shared kernel space/user space 
applications, mainly autofs, and if done properly, it can be quite sane. 
  If done *improperly*, it's a nightmare.  Personally, I find that if 
one can:

- Run something as a separate component in userspace, and/or
- Can leverage strace(1) to get more insight

then one can usually get a lot of debugging help.  Otherwise, probably not.

	-hpa
