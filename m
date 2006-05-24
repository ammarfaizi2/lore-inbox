Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbWEXFO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWEXFO0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWEXFOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:14:25 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:15523 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932581AbWEXFOZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:14:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=scLTp/mPKpgCxrZ7qKr3gKH6WME6Xs3bvMv4zJsEZ8GwTwPOV5OAkfd9ES4jl0kY9C2XKV4E3PKVOEWptpNZsp922ROHMBqo6vyvf8NNH5+aKsfnhx2li7zFNMzeeqFfm5AP0rD8J0o7NHD18dMKFfWIbaDloqx6pvBQZNDsO/w=
Message-ID: <21d7e9970605232214l3349df0dka162f794f8eddf95@mail.gmail.com>
Date: Wed, 24 May 2006 15:14:24 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605240017.45039.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605232338.54177.dhazelton@enter.net>
	 <21d7e9970605232108u27bc3ae7mbd161778c51afaf5@mail.gmail.com>
	 <200605240017.45039.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > All the other designs and stuff people have mentioned have all been
> > discussed to death before, people seem to love discussing graphics,
> > but no-one seems to care about fixing it properly, in nice incremental
> > steps that doesn't break older systems. The current systems are very
> > very fixable, however there always seem to be lots of people who want
> > to re-write it because it is a) ugly in their opinion b) don't care
> > about backwards compat.
> >
>
> I'd never advocate just killing a functioning system. What I've been talking
> about is building a new system that sits alongside the existing one in the
> tree, depends on EXPERIMENTAL and BROKEN in the Kconfig system and takes the
> place of the traditional framebuffer system if someone decides to use it.
>
> I say have it depend on BROKEN because that should keep the masses away from
> it while it's being heavily tested, and I say it should sit alongside the
> existing code and be *new* for exactly the reason you've pointed out.
> Modifying the existing systems to integrate the new technology would require
> either changing the driver model or a lot fo dirty hacks. Neither seems that
> good of an option to me.
>

Not going to happen at this stage I believe, while people are in NIH
mode against trying to fix the current system, we are not going to
merge a third incompatible graphics layer into the kernel, we have
enough of them to do the job, we need people to fix the current crap
not add more.

The current system is fixable, we've discussed how to fix it a number
of times, however there have never been resources to do it, we
explained to Jon on a number of occasion how we as the maintainers
felt it should be fixed, the patches he produced didn't follow the
direction we wanted, he stated "the writer decides", we stated "the
maintainers don't accept it".

Step 1: add a layer between fbdev and DRM so that they can see each other.

Do *NOT* merge fbdev and DRM this is the "wrong answer". They may end
up merged but firstly let them at least become away of each others
existence, perhaps a lowerlayer driver that handles PCI functionality.
All other Step 1s are belong to us.

I could even drop the last hack I did in some sort of patch form
somewhere, I might even have a git tree (not sure...)

Dave.
