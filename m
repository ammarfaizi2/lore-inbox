Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317002AbSEWUev>; Thu, 23 May 2002 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317004AbSEWUeu>; Thu, 23 May 2002 16:34:50 -0400
Received: from [195.63.194.11] ([195.63.194.11]:2576 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317002AbSEWUes>;
	Thu, 23 May 2002 16:34:48 -0400
Message-ID: <3CED438B.6090906@evision-ventures.com>
Date: Thu, 23 May 2002 21:31:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.33.0205231251430.2815-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> On Thu, 23 May 2002, Martin Dalecki wrote:
> 
>>Hey and finally if someone want's to use /dev/port for
>>developement on some slow control experimental hardware for example.
>>Why doesn't he just delete the - signs at the front lines
>>of the patch deleting it plus module register/unregister trivia and
>>compile it as a *separate* character device module ?
> 
> 
> That's not a productive approach, Martin.

"I will submitt my dual 8255 PIO ISA card driver from 1.xx days
immediately for kernel inclusion"

This was the exmaple I had in my mind as I wrote the above.
Slow controll means in experimental physics - controll of
devices which don't have hard real time constrains.
Once in my life I wrote a driver for such a beast which was
controlling an experimental tomography device. But I have
found it specific and trivial enough to don't bother to
submitt it to the general public. It was *trivial* to
implement becouse I could trick the LP driver to do what
I wanted by deleting most of the code in it.
I assume that this kind of application is what Pete was
talking about as he was speaking about "quite frequently"
and finally "Solaris does without it so we could as well".

This was what I had in my mind with the advantage of having
full access to the source code of the system. I certainly
don't buy myself in the philosophical zealots view of
of open source OS supreriority quite frequently propagated here
by some individuals.

And please note even at the time then I didn't write
the application by using the cards from user land
directly - I just wrote the damn driver for it, becouse
the "cheating" smelled to me immediately.

> Yes, with open source you can do whatever you want.
> 
> HOWEVER, there is a huge amount of advantage to having a common base that 
> is big enough to matter: why do you think MS does well commercially? 
> 
> It's important to _not_ have to force people to do site-specific (or 
> problem-specific) hacks, even if they could do so. Because having to have 
> site-specific hacks detracts from the general usability of the code.
> 
> So when simplifying, it's not just important to say "we could do without 
> this". You have to also say "and nobody can reasonably expect to need it".

What I'm saying is: It has already caused people who write applications
to control things like the system clock settings or keyboard speed
to write the applications in a way which:

1. doesn't use the proper system interfaces,
2. is attracted to the particular hardware implementation
3. is inherently not portable across different systems. (Alan got this wrong).
4. a damn comon thing to do.

As a consequence of this it has caused the system
interfaces for those purposes to never mature.
USB keyboards to name one.

The single only guy who wanted to use it for some sane purpose
and  had some serious intentions about it noticed immediately
that it is BTW seriously broken from day one on!

So in regard of the above I have decided for myself that
the sanest way to fix it is to remove it.

> Which doesn't seem to be the case with /dev/ports. So it stays.
> 
> 		Linus

I think one doesn't have only to provide things. One has
to prevent damage as well. And hwclock and kbdrate are
seriously damaged already for example. Once just didn't
notice until now becouse it all kind of "works".
Please look at the code there.

If you reffer to MS as a success story of about how to
be a bitch to everybody ... well please tell me: Why do we use
page protection for example at all. The implementers of
DOS where not even dreaming about it and Win98 didn't care.
All of the follow up operating systems from Redmond are
making it seriously difficult to get direct hardware access.
For scincetific applicatons there are even some special third
party expensive drivers out there which are supposed to
permitt just that - port access from user space.

This is one of the reasons I did implement the host controll
software for the tomography device under Linux and NOT any
windows or doors system. And it was in fact the first Linux
in experimental medicine around there! (The circle was quite
wide those days...)


