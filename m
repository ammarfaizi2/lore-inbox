Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWB0UB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWB0UB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 15:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbWB0UB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 15:01:56 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:39712 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932195AbWB0UBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 15:01:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k9PgkRyh/IBtXRcN5xPUGwk3+Zfwr7uxLYk52bp2qrJ0O8dK6ANxwH7dcHQzICHj1fQvg5oPmfG0Pccu5Ht86PxsPVaWrG2favis8HSIFWGkHpXZUjW4DdZvqMa02RjCS57cD/3+Rqzs87aZ2FjoEJTy2Mi33NRsfwpQoijHGJg=
Message-ID: <9a8748490602271201j39d87e9di8d6e2c83b0439c89@mail.gmail.com>
Date: Mon, 27 Feb 2006 21:01:54 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       "Andrew Morton" <akpm@osdl.org>, davej@redhat.com, perex@suse.cz,
       gregkh@suse.de, "Kay Sievers" <kay.sievers@vrfy.org>
In-Reply-To: <20060227190150.GA9121@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060227190150.GA9121@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/06, Greg KH <greg@kroah.com> wrote:
> Hi all,
>
> As has been noticed recently by a lot of different people, it seems like
> we are breaking the userspace<->kernelspace interface a lot.  Well, in
> looking back over time, we always have been doing this, but no one seems
> to notice (proc files changing format and location, netlink library
> bindings, etc.)
>
> Linux is a dynamic system, we add and change things all the time based
> on the need of its developers and users.  Because of this, we now run on
> more platforms than any other operating system ever has, from the
> world's top supercomputers, to the phone in your pocket.  It is how we
> have survived so far, and is how we will survive in the future.
>
> In order to ensure that we can continue to be dynamic in the future, and
> not get bogged down by interfaces that are half-baked, or just turn out
> to be wrong once we implement them and find ways to break them (anyone
> remember the sys_futex evolution?) we need to be able to handle the
> changes in the userspace<->kernelspace ABI properly.
>
> So, here's a first cut at how we can do this.  Lots of other operating
> systems explicity document what the interfaces to it are, and give a
> "stability" rating of those interfaces (for one example, look at
> http://opensolaris.org/os/community/onnv/devref_toc/devref_7/ ).  I feel
> that we too need to document this interface, in order to keep everyone
> in the loop and not cause any unwanted surprises at times they do not
> need them (like right before a company's deadline.)
>
> I've sketched out a directory structure that starts in
> Documentation/ABI/ and has five different states, "stable", "testing",
> "unstable", "obsolete", and "private".  The README file describes these
> different states, and how things can move between them.  I've also
> seeded the directories with some well known examples of the different
> interfaces that are already in these states.
>
> So, any comments?  Criticisms?
>

Great initiative. Thanks.


> thanks,
>
> greg k-h
>
> p.s. I'd like to thank Kay Sievers for the main idea behind this
> structure and need to document this.
>
>
> -----------------------
>
> From: Greg Kroah-Hartman <gregkh@suse.de>
> Subject: Add kernel<->userspace ABI stability documentation
>
>
> Signed-off-by: Kay Sievers <kay.sievers@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
>
> ---
>  Documentation/ABI/README                 |   92 +++++++++++++++++++++++++++++++
>  Documentation/ABI/obsolete/devfs         |   13 ++++
>  Documentation/ABI/private/alsa           |    8 ++
>  Documentation/ABI/stable/syscalls        |   10 +++
>  Documentation/ABI/stable/sysfs-module    |   29 +++++++++
>  Documentation/ABI/testing/sysfs-class    |   16 +++++
>  Documentation/ABI/unstable/sysfs-devices |   25 ++++++++
>  7 files changed, 193 insertions(+)
>
> --- /dev/null
> +++ gregkh-2.6/Documentation/ABI/README
> @@ -0,0 +1,92 @@
> +This directory attempts to document the ABI between the Linux kernel and
> +userspace, and the relative stability of these interfaces.  Due to the
> +ever changing nature of Linux, and the differing maturity levels, these
> +interfaces should be used by userspace programs in different ways.
> +
> +We have four different levels of ABI stability, as shown by the four
> +different subdirectorys in this location.  Interfaces may change levels
> +of stability according to the rules described below.
> +
> +The different levels of stability are:
> +
> +  stable/
> +       This directory documents the interfaces that have determined to
> +       be stable.  Userspace programs are free to use these interfaces

"have determined to be stable." ??
How about "have proven to be stable" or "we have determined to be
stable" or "we have defined as being stable and will not break"
instead?


> +       with no restrictions, and backward compatibility for them will
> +       be guaranteed for at least 2 years.  Most simple interfaces
> +       (like syscalls) are expected to never change and always be
> +       available.
> +
> +  testing/
> +       This directory documents interfaces that are felt to be stable,
> +       as the main development of this interface has been completed.
> +       The interface can be changed to add new features, but the
> +       current interface will not break by doing this.
> +       Userspace programs can start to rely on these interfaces, but
> +       they must be aware of changes that can occur before these
> +       interfaces move to be marked stable.  Programs that use these
> +       interfaces are strongly encouraged to add their name to the
> +       description of these interfaces, so that the kernel developers
> +       can easily notify them if any changes occur (see the description
> +       of the layout of the files below for details on how to do this.)
> +

Maybe a note here that "testing" interfaces may be change in
incompatible ways before moving to stable/ if grave errors or security
vulnerabilities are found in them?


> +  unstable/
> +       This directory documents interfaces that are known to be
> +       unstable, and not ready for widespread use by a lot of different
> +       programs.  That is not to say that they can not be used, but
> +       developers of such programs should track their changes very
> +       closely.  Again, programs that uses these interfaces are
> +       strongly encouraged to add their names to the description of the
> +       interfaces so that they can be notified of changes.
> +
> +  obsolete/
> +       This directory documents interfaces that are still remaining in
> +       the kernel, but are marked to be removed at some later point in
> +       time.  The description of the interface will document the reason
> +       why it is obsolete and when it can be expected to be removed.
> +

A note here that people should check
Documentation/feature-removal-schedule.txt perhaps?


> +  private/
> +       This interface is private between the kernel and a helper
> +       userspace program or library.  If you wish to use this interface
> +       (like alsa or netlink) userspace must use the helper library and
> +       not use the raw kernel interface directly.
> +

Perhaps add something along the lines of "Stability of the interface
is only guaranteed through the helper library, if you choose to
disregard this and use the raw kernel interface anyway, then your
program may break without warning in future kernel releases.".


> +
> +Every file in these directories will contain the following information:
> +
> +What:          Short description of the interface
> +Created:       Date created

Perhaps also a line here specifying the first mainline kernel release
(not -mm or -rc, but first stable kernel) that the interface is
available with. ??


> +Contact:       Primary contact for this interface (may be a mailing list)
> +Description:   Long description of the interface and how to use it.
> +Users:         All users of this interface who wish to be notified for
> +               when it changes.  This is very important for interfaces
> +               in the "testing" stage, and the "unstable" stage, so
> +               that kernel developers can work with userspace
> +               developers to ensure that things do not break in ways
> +               that are unacceptable.  It is also important to get
> +               feedback for these interfaces to make sure they are
> +               working in a proper way and do not need to be changed
> +               further.
> +
> +
> +How things move between states:
> +
> +Interfaces in stable may move to obsolete, as long as the proper
> +notification is given.
> +
> +Interfaces may be removed from obsolete and the kernel as long as the
> +documented amount of time has gone by.
> +
> +Interfaces may be moved from unstable to testing whenever the developers
> +feel they are finished with the interface.  Interfaces should not remain
> +in unstable for very long periods of time without good reasons.
> +
> +Interfaces may be removed entirely from the kernel without notice if
> +they are in the unstable state.
> +
> +Interfaces in the testing state can move to the stable state when the
> +developers feel they are finished.  They can not be removed from the
> +kernel tree without going through the obsolete state first.
> +
> +It's up to the developer to place their interface in the category they
> +wish for it to start out in.

In my oppinion it should be a requirement that an interface spends at
least one kernel release in the "testing" state before moving to
"stable" and can't be added to "stable" straight away.


Just my 0.02 euro :-)


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
