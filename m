Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVKINEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVKINEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbVKINEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:04:12 -0500
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:42682 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1750702AbVKINEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:04:12 -0500
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: video4linux user land API concern
Date: Wed, 09 Nov 2005 12:58:28 GMT
Message-ID: <05G2S1G12@briare1.heliogroup.fr>
X-Mailer: Pliant 94
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> Many of the encodings done by hardware are extremely complicated and
> tricky to unpack in kernel space. If a camera captures jpeg for example
> you don't want in kernel jpeg decoders, let alone mpeg decoders etc

So you fall back on the current main bad point about the Linux kernel design.

One quality of Linux, as opposed to some other proposed kernels, is that all
drivers are part of the kernel tarball, so you can expect to always get drivers
that are consistent with the kernel internal API.

On the other hand, over time, more and more kernel only related features
have been rejected to user land, for various reasons mostly related to
stability and security. I mean 'ifconfig', raid tools, etc.
Your agument about video decoding falls in the stability category.

Now, if you look for documentation about the interface between the kernel
and the user land tool that have has been written at the same time to provide
an overall services (let think about software raid) then you discover that
it's mosty inexisting, and that the interface in the middle is just an
unengeneered nightmare.
So, in facts you can't use the kernel function without adopting the user
land tool associated, but then you discover that very fiew eyes watched and
checked the user land part of the tool, and that it's quality is really really
poor (opens a file, but not check the error code, etc, etc)

The proper solution seems clear: it is to have an in kernel tarball
minimalistic glibc, in kernel tarball set of kernel related user land tools so
that all of them benefit from the magic Linus taste.
Building the kernel should build a new /kbin/ and /klib/ directory with all
kernel related user land tools and libraries.
Then distibutions should just set softlinks to these.

As a summary, the fact that you say you don't want to have the decoding
running at ring 0 does not mean that it should not be part of the kernel
tarball.

