Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbUK3VUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbUK3VUq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 16:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbUK3VUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 16:20:45 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:60355 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262318AbUK3VUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 16:20:25 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Stefan Seyfried <seife@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <41AC6480.6020002@suse.de>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	 <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams> <41AAED32.2010703@suse.de>
	 <1101766833.4343.425.camel@desktop.cunninghams>  <41AC6480.6020002@suse.de>
Content-Type: text/plain
Message-Id: <1101849416.5715.13.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 01 Dec 2004 08:16:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-11-30 at 23:16, Stefan Seyfried wrote:
> >>>change a parameter or forcing them to do an ls in /dev with obscure
> >>>parameters (to get the major and minor numbers) when they already know
> >>>they want /dev/sda1 isn't user friendly. Obviously user friendliness is 
> >>
> >>This can easily be done by a userspace helper. You do use the
> >>(userspace) X server to display your GUI, don't you?
> > 
> > No. Not at all. All of userspace is well and truly wedged in a block of
> > ice by then.
> 
> you are not changing the suspend device after freezing userspace, or i
> am getting something horribly wrong here.

No, it doesn't change once userspace is frozen; you're correct.

> so if you have 2 choices of an interface:
> 1) more complex kernel code, but you can do "echo /dev/name > /proc/foo"
> 2) less complex kernel code, now you have a userspace helper e.g.
>    "suspend_ctl foodev /dev/name" which then does the magic number
>    calculations in userspace and puts the magic number into the kernel.
> 
> I think that interface 2) would be preferred by most kernel developers.
> Especially since this is code only needed on a relatively small subset
> of all linux installations.
> 
> There is a "top" userspace program to parse kernel numbers, we don't
> have "/proc/top".

Forgive me for asking a stupid question, but why all this fuss when the
code is already in the kernel? And isn't really that complex anyway.
Instead of whatever for parsing a major and minor, we have 

        resume_device = name_to_dev_t(commandline);

Is it really worth all this heat for that call and making two routines
(name_to_dev_t and try_name IIRC) not be __init. It seems to me that
it's far more complex to create some userspace program to do this stuff.

> >>Putting only the absolutely necessary things into the kernel (the same
> >>is true for the interactive resume thing - if someone wants interactive
> >>startup at a failing resume, he has to use an initrd, i don't see a
> >>problem with that) will probably increase the acceptance a bit :-)
> > 
> > That's fine if your initrd is properly configured and you're willing to
> 
> This is something distributions have to take care of.

No; it's something the users will have to take care of. Distro makers
might make the process more automated, but in the end it's the user's
problem if it doesn't work.

> > add extra cruft to the kernel so userspace can get the info it needs,
> 
> not much extra cruft is needed. The "echo resume > /sys/power/state"
> just returns (which it wouldn't if the resume was successful), then you
> can decide what to do next.
> 
> > and report what the user wants to do. If, however, you don't use an
> > initrd, you're sunk.
> 
> yes. There are other prerequisites for suspend than using an initrd
> though (you need a computer :-). If you don't use an initrd, you cannot
> use the interactive features but have to decide at compile time which
> way to go if the resume fails. That's life.

Have you looked at the code for handling this? It's really very simple.

> > Regarding acceptance, there's no point in getting it accepted into the
> > kernel if we end up with something that's user-unfriendly. I think it
> > will help a lot if we agree that suspend does need to blur the lines
> > between kernel and userspace a little, in the interests of providing
> > software that is superior.
> 
> User-friendlyness is an joint effort of kernel and userspace. The user
> does not care who does the work when he clicks on his "hibernation" Icon
> in the taskbar. (The same is true for users of an hibernation script).
> Actually, the thing that makes suspend2 more reliable than swsusp is
> probably the very good hibernation script (userspace) that saves users
> the reading of documentation since it automatically unloads all critical
> modules etc. For me, pavel's later versions as in SUSE 9.2 have worked
> out of the box on every non-SMP i386 notebook i have laid my hands on in
> the last 6 months (thanks to userspace taking care of bad modules etc).

Have those boxes had DRI enabled or serious USB usage? I'd be surprised
if you haven't run into the same problems we have.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

