Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282640AbRLBBNZ>; Sat, 1 Dec 2001 20:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282645AbRLBBNQ>; Sat, 1 Dec 2001 20:13:16 -0500
Received: from smtp-abo-1.wanadoo.fr ([193.252.19.122]:17363 "EHLO
	villosa.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S282640AbRLBBNK>; Sat, 1 Dec 2001 20:13:10 -0500
Message-ID: <3C097FB2.7A376199@wanadoo.fr>
Date: Sun, 02 Dec 2001 02:11:14 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre5 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
		<9u9qas$1eo$1@penguin.transmeta.com>
		<200112010701.fB171N824084@vindaloo.ras.ucalgary.ca>
		<3C0898AD.FED8EF4A@wanadoo.fr>
		<200112011836.fB1IaxY31897@vindaloo.ras.ucalgary.ca>
		<3C093F86.DA02646D@wanadoo.fr> <200112012320.fB1NKro03024@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:

 
> I assume if you use kernel 2.4.16 with devfsd-1.3.20 that there is no
> Oops?

No there is no oops with 2.4.16, BUT I am sure CONFIG_DEBUG_KERNEL is
not set in my kernel 2.4.16. I shall try to re-compile it with it.

2.5.1-pre5 is fine as well, provided that you don't say yes to
CONFIG_DEBUG_KERNEL.

>ksymoops 2.4.3 on i686 2.5.1-pre5.  Options used
>     -V (default)
>     -k /proc/ksyms (default)
>     -l /proc/modules (default)
>     -o /lib/modules/2.5.1-pre5/ (default)
>     -m /usr/src/linux/System.map (default)
> Did you install the appropriate System.map in /usr/src/linux? If not,

I am building linux in /usr/gnu/linux. There is only one file in
/usr/src/linux, the System.map I put before running ksymoops.

> > > Edit your /etc/fstab and remove the line for devfs. You don't
> > > need/want that if you have CONFIG_DEVFS_MOUNT=y.
> >
> > no problem
> I assume that didn't help. It would be helpful if you said so
> explicitely.

I have now removed this line in fstab. It was useful when /dev had
permanent device files. With devfs only it's not needed but it doesn't
improve.
 
> I'm not asking you to give up using NVidia drivers forever, but it's
> very important that those drivers are not loaded until the Oops has
> happened, you've captured the boot messages, run them through ksymoops
> and either mailed them to me, or at the very least saved them to a
> file for later emailing. By moving the NVidia drivers, you ensure that
> they aren't autoloaded prior to Oops generation and debug capturing.
> 
> If you're unwilling to move those drivers elsewhere (I don't see why
> this is a problem for you: you can live without them for a few
> minutes), then neither I nor anyone else on this list can or will help
> you. Binary-only drivers like NVidia cause no end of problems, and
> kernels with them loaded (or even once loaded and then unloaded) are
> not debuggable by the community. For all I know, the NVidia driver
> abuses devfs in some way, and there isn't a bug in devfs itself. But
> not having the source, *I can't be sure*. And since I don't know, I
> can't help.
> 
> Just why are you unwilling to move those drivers?

You misundertood me. I would never include in the kernel a binary driver
which would break at each new release of linux. 
 
> > > prevent their being loaded. Even if you load but don't use such
> > > drivers, they still make debugging information unreliable.
> > >
> > > I've had a look at the code, and I see no reason for devfs to fail in
> > > this way, unless some driver is abusing it.
> >
> > I would suspect 1st devfsd. 2.4.16 is not happy at all with
> > devfsd-1.3.20, even rxvt fails to find a terminal.
> 
> Devfsd is just a user-space process, and can't cause an Oops unless
> there is a kernel bug (i.e. a devfs bug, or maybe a driver bug). I
> believe that devfsd-v1.3.20 should not make it more likely to get an
> Oops than when using devfsd-1.3.18. If devfsd-v1.3.20 really does
> trigger an Oops while 1.3.18 doesn't then please try 1.3.19 and report
> the results.
> 
> A separate issue is why rxvt doesn't work. Again, it's important to
> try devfsd-v1.3.19 to see if that also breaks rxvt. If so, report and
> also send a strace output of rxvt so I can see what's going wrong
> there.
> 
> Finally, please try kernel 2.4.17-pre1, which has the latest version
> of devfs. The 2.5.1-pre kernels have a lot of new experimental code
> which could be causing some of the problems. By using 2.4.17, it
> limits the changes to (mostly) devfs, so limits the variables. When
> you use 2.5.1, I can't tell if there is a bug in devfs, or perhaps
> some driver which is doing something illegal with devfs.


Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
