Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSLMUvC>; Fri, 13 Dec 2002 15:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbSLMUvC>; Fri, 13 Dec 2002 15:51:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55566 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265385AbSLMUvA>;
	Fri, 13 Dec 2002 15:51:00 -0500
Message-ID: <3DFA49CF.9060106@pobox.com>
Date: Fri, 13 Dec 2002 15:57:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: Roger Luethi <rl@hellgate.ch>, netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pci-skeleton duplex check
References: <Pine.LNX.4.44.0212121743500.10674-100000@beohost.scyld.com>
In-Reply-To: <Pine.LNX.4.44.0212121743500.10674-100000@beohost.scyld.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Donald Becker wrote:
> On Thu, 12 Dec 2002, Jeff Garzik wrote:
> 
>>Donald Becker wrote:
>>
>>>On Thu, 12 Dec 2002, Jeff Garzik wrote:
>>>
>>>>Donald Becker wrote:
>>
>>	[[ I don't know why I bother. The people that now control what
>>	   goes into the kernel would rather put in random patches from
>>	   other people than accept a correct fix from me. ]]
>>I'm sure you'll continue making snide comments on every mailing list you 
>>maintain, but the fact remains:
>>I would much rather accept a fix from you.
> 
> 
> Perhaps we have a different idea of "fix".
> 
> You want are looking for a patch to modifications you have made to code
> I have written.  In the meantime I have been providing working code, and
> have been updating that code to work with new hardware.  So a fix is the
> working, continuously maintained version of the driver. 
> 
> To put an admittedly simplified spin on it, you are saying "I want you
> to tell me what I have broken when I changed this", and to continuously
> monitor and test your changes, made for unknown reasons on a very
> divergent source base.

No, that's not it at all.

I would ecstatic if you even posted the changes made to your own drivers 
to netdev@oss.sgi.com or similar...

I'm asking for _any_ contributions at all.  The more fine-grained the 
better...



>>>The drivers in the kernel are now heavily modified and have significantly
>>>diverged from my version.  Sure, you are fine with having someone else
>>>do the difficult and unrewarding debugging and maintenance work, while
>>>you work on just the latest cool hardware, change the interfaces and are
>>>concerned only with the current kernel version.
>>
>>While I disagree with this assessment, I think we can safely draw the 
>>conclusion that the problem is _not_ people ignoring your patches, or 
>>preferring other patches over yours.
> 
> 
> I can point to specific instances.  Just looking at the drivers in the
> kernel, it is clear that this has happened.

There is an admitted preference to people who actually send me patches. 
  That sometimes translates to "other change" being preferred over logic 
in one of your drivers.

I would still greatly prefer patches from you, however.  And your 
comments on other people's patches are very welcome [and there have been 
plenty of those in past -- thanks].


> But it existed before, and was discarded!
> Yes, the kernel is now _returning_ to a stable state while making
> improvements.  But there was a period of time when interface stability
> and detailed correctness was thrown away in favor of many inexperienced
> people quickly and repeatedly restructuring interfaces without
> understanding the underlying requirements.
> 
> I could mention VM, but I'll go back to one that had a very large direct
> impacted on me: CardBus.  CardBus is a difficult case of hot-swap PCI --
> the device can go away without warning, and it's usually implemented on
> machines where suspend and resume must work correctly.  We had perhaps
> the best operational implementation in the industry, and I had written
> about half of the CardBus drivers.  Yet my proven interface
> implementation was completely discarded in favor one that needed to be
> repeatedly changed as the requirements were slowly understood. 

But... this is how Linux development works.  Believe me, I understand 
you don't like that very much, but here is a central question to you:

	what can we do to move forward?

The CardBus implementation still fails on some systems, and still wants 
work.  However, the pci_driver API is not only codified in 2.4.x, but it 
is extended to the more generic driver model in 2.5.x.  _And_ I have 
proven it works just fine under 2.2.x (see kcompat24 toolkit).

What can we as kernel developers do to reintegrate you back into kernel 
development?  Some of the APIs you obviously don't like, but pretending 
they don't exist is not a solution.  This is the Linux game, for better 
or worse.  At the end of the day, if we don't like Linus's decisions, we 
can either swallow our pride and continue with Linux, or fork a Linux 
tree and make it work "the right way."  The driver model (nee 
pci_driver) is the direction of Linux.


>>I would love to integrate your drivers directly, but they don't come 
>>anywhere close to using current kernel APIs.  The biggie of biggies is 
>>not using the pci_driver API.  So, given that we cannot directly merge 
> 
> 
> Yup, that is just what I was talking about.  Let me continue: 
> 
> The result is that today other systems now have progressed to a great
> implementation of suspend/resume, while Linux distributions now default
> to unloading and reloading drivers to avoid various suspend bugs.  And
> when the driver cannot be unloaded because some part of the networking
> stack is holding the interface, things go horribly wrong...
> 
> You might be able to naysay the individual details, but the end
> technical result is clear.

That's what is currently in development in 2.5.x: sane suspend and 
resume.  I would dispute that other systems have a decently designed 
suspend/resume -- that said, working is obviously better right now than 
non-working but nicer design ;-)


>>your drivers, and you don't send patches to kernel developers, what is 
>>the next best alternative?  (a) let kernel net drivers bitrot, or (b) 
>>maintain them as best we can without Don Becker patches?  I say that "b" 
>>is far better than "a" for Linux users.
> 
> 
> Or perhaps recognizing that when someone that has been a significant,
> continuous contributer since the early days of Linux says "this is
> screwed up", they might have a point.  When Linux suddenly had thousands
> of people wanting to submit patches, that didn't means that there were
> more people that could understand, implement and maintain complex
> systems.


Shit, dude, _I_ recognize this.  Probably better than most people, since 
I see on a daily basis the benefits of your overall design in the net 
drivers, and want to push good elements of that design into the kernel 
net drivers.  At the end of the day you'd be surprised how much I wind 
up defending your code to other kernel hackers, and educating them on 
why -not- to do certain things.

IMO the bigger sticking point is - at what point do you say "yeah, 
2.4.x/2.5.x APIs may suck in my opinion, but they are the official APIs 
so I will use them"?  There are tons of reasons why Red Hat (my current 
employer) is very leery of taking patches which will not eventually find 
their way to the mainline kernel.org kernel.  A lot of those reasons 
apply in the case of your drivers, too.  Using non-standard APIs has all 
sorts of software engineering implications which wind up with a negative 
developer and user experience.

	Jeff



