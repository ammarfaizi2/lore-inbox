Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268902AbUIXRXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268902AbUIXRXk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUIXRXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:23:39 -0400
Received: from spirit.analogic.com ([208.224.221.4]:53521 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S268902AbUIXRWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:22:45 -0400
From: "Johnson, Richard" <rjohnson@analogic.com>
Reply-To: "Johnson, Richard" <rjohnson@analogic.com>
To: Rahul Karnik <deathdruid@gmail.com>
Cc: "Johnson, Richard" <rjohnson@analogic.com>, linux-kernel@vger.kernel.org
Date: Fri, 24 Sep 2004 13:25:52 -0400 (EDT)
Subject: Re: Migration to linux-2.6.8 from linux-2.4.26
In-Reply-To: <5b64f7f040924093035495d74@mail.gmail.com>
Message-ID: <Pine.LNX.4.53.0409241258180.24517@quark.analogic.com>
References: <Pine.LNX.4.53.0409241038250.24372@quark.analogic.com>
 <5b64f7f040924093035495d74@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Rahul Karnik wrote:

> On Fri, 24 Sep 2004 11:10:23 -0400 (EDT), Johnson, Richard
> <rjohnson@analogic.com> wrote:
> >
> > (1) I compiled the new module-init-tools-3.1-pre5.tar.gz. It
> > claimed to be backward-compatible. After installing it, it
> > complained about something then seg-faulted. Nevertheless
> > `insmod` seemed to work so I proceeded.
>
> Error message would be nice to have.
>

>From memory:

Kernel requires old lsmod but couldn't run ./lsmod.old No such
file or directory.

I don't know how it 'knew' that I had proviously copied
all the modutil utilities to *.old before installing the
new ones. In any event, it would certainly never find
them at "./filename.old". They would have to be un
/sbin or /usr/sbin or /usr/local/something, never in
the current directory.


> > (2) `make oldconfig` didn't work after copying over the
> > linux-2.4.26 .config file. This meant that I had to answer
> > hundreds of questions.
>
> This is unavoidable; 2.6 has lots and lots of new features.
>

Actually not. It spends its time doing CRCs and linking in
anti-compatibility stuff (I'm actually being kind, stuff is
really not the best word).

> > (3) `make bzImage` required that I install a new 'C' compiler.
> > This took several hours.
>
> gcc 2.95 should work for 2.6, although I have heard some mention on
> the list of that not being true anymore.
>

Well I had to use gcc 3.2 which generates a lot of bloat.
egcs-2.91.66 worked best for about two years. The code was
much more compact. Unfortunately, people started using:

#define whatever(a,b,...)

... which the compiler didn't like, probably because a definition
isn't a function that can take a variable parameter list.

> > (4) Eventually "bzImage" got made. I tried `make modules`.
> > This took over 2 hours, went through everything several times.
> > This is a 2.8 GHz system. It usually takes about 6 minutes
> > to compile the kernel and all the modules. There is something
> > very wrong with the new compile method when it takes 120
> > times longer to compile than previously.
>
> Something is seriously wrong here, and it has nothing to do with the
> "new compile method". Please post your 2.4 and 2.6 config files,
> compiler version and platform info.
>

I can't get to them yet.

> > (6)  The system would boot, but not find a file-system to mount.
>
> Details?
>

Like I said. `insmod` failed. It failed because somebody
removed kernel function call query_module, number 167.
It returns ENOSYS and that's the end of trying to install
modules. Therefore my root file-system (on a SCSI disk)
isn't available.

That `insmod` was the un-touched insmod.static that was
in the untouched initrd boot image.

Nobody should have been allowed to remove that functionality.
You are supposed to add new functionality to existing software,
not destroy backward compatibility. Last time I checked
there were 252 function call numbers. Since it's a 32-bit
int, there are quite a few more available before one needs to
delete previous ones to make room.

> > (7)  Tried to reboot using previous kernel. It failed to
> > load the required drivers for my SCSI disks so I have no
> > root file-system there.
> >
> > (8)  I am currently unable to use my main system. I will have
> > mount my main SCSI drive on this system, and replace the
> > module-init-tools with the previous modutils. This should
> > allow me to get "back" to my previous mounted root.
>
> Related to (1), I assume.
>
> Have you tried using a rescue disk to fix the problem? Knoppix (or a
> distro rescue disk) should work fine.
>

It's a SCSI disk. All I have to do is mount it on this system
can copy all the saved modutils stuff back.

> Thanks,
> Rahul
>

Also, further experiments shows that even my last-resort IDE
drive can't be used with the new kernel as a root file-system
because, even though IDE stuff is compiled in, the actual
drive number, i.e., /dev/hda, etc., is different and can't
be found, or it uses devfs or something else equally annoying.

Yep.
Doesn't have to be better, only different.


Richard B. Johnson
Project Engineer
Analogic Corporation
Penguin : Linux version 2.2.15 on an i586 machine (330.14 BogoMips).
