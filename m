Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVKIQrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVKIQrj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVKIQrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:47:39 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:32926 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1751457AbVKIQri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:47:38 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: video4linux user land API concern
Date: Wed, 09 Nov 2005 16:41:37 GMT
Message-ID: <05G32DD11@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> And this is different to a "linux distribution" how ?

Think about two entry level utilities, I mean 'ls' and 'ifconfig'.

'ls' is clearly part of the Linux distribution because it should not care
the underlying kernel.

On the other hand 'ifconfig' has no meaning if the underlying is not Linux.

So, what I'm saying is that bringing all these utilities that have no meaning
if the underlying kernel is not Linux to /usr/src/linux/userland/
would help.

Most of us once falled on the problem you switch from 2.4 to 2.6 or the other
way round, and the system start not to work properly because the distribution
needs a different package for 2.4 and 2.6
(I've also discovered more subtil troubles such a 32 bits iptables will not
 be abble to configure a 64 bits Opteron kernel with 32 bits support,
 probably because the data structure at the interface of the kernel and iptable
 are long size dependent)

If all the kernel centric user land utilities are part of the kernel tree,
then:
1) when you change of kernel, you change of utilities set
2) it can be mandatory that these must not rely on external distribution files

As a result, you get a properly layered distribution, with:
. a kernel
. a mini SELF CONTAINED distibution with all kernel centric utilities and
  libraries
. the full distribution with true mostly kernel agnostic tools and applications

Such a design makes Linux
. more robust: fiewer computers are silently running with user land tools that
  don't match the kernel
. more flexible: packaging Linux for strange non Unix usage get's cheaper

The underlying reasoning is that even if most of the time the right
boundary between kernel and application is the kernel API, as you pointed
out, sometime it cannot (you don't want MPEG2 decoder in the kernel) so
the boundary should be between the kernel distribution and the overall
distribution, not between two parts (the kernel and the bloated distribution)
that we have no serious reason to assert that they will always match each
other.

Ok, this does not append if you assert that end users install new kernel
through their distribution packages, since the distribution packages will
(should) contain the dependencies to keep an overall consistent system.

So another question might be: do you prefer power users to compile and run
Linux kernel from the kernel.org plain source tarball, so send easy to use
feedback, or run only distribution packaged kernels.
In the first case, packing the low level kernel centric user land tools with
the kernel tarball makes power users life much easier, and improves feedback
since it helps to keep the system consistent.

Once upon a time, akpm stated that he has no way to reward people that mostly
provide feedback. That's ok since a mostly crash free kernel is a serious
reward.
Also helping them with a packaging troubles free kernel would be a serious
bonus, so I'm cc ing him this message.
