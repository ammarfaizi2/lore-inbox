Return-Path: <linux-kernel-owner+w=401wt.eu-S932526AbXAGNLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbXAGNLE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 08:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbXAGNLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 08:11:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:7601 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbXAGNLD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 08:11:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bYqa+DK40Jhd7FWzwf53IysDcnD9wbzV9M7iMQrG2vH3v7y2N83tCxaEiWT8GS78fjAqdpqYxbE8DBNYsLzNoe7TzFH/1yd23Q5GlMare3Zi16ar7idrxRCAgNgGE0Nvy7uCgRxhlhmlvsZ5EkL7QxTjIxbEy723i3rCna3WqsA=
Message-ID: <8355959a0701070511v55c671dibc3bb7d4426129e0@mail.gmail.com>
Date: Sun, 7 Jan 2007 18:41:00 +0530
From: Akula2 <akula2.shark@gmail.com>
To: "Willy Tarreau" <w@1wt.eu>
Subject: Re: Multi kernel tree support on the same distro?
Cc: "Steve Brueggeman" <xioborg@mchsi.com>,
       "Auke Kok" <sofar@foo-projects.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20070107093057.GS24090@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>
	 <459D9872.8090603@foo-projects.org>
	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>
	 <20070107093057.GS24090@1wt.eu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/07, Willy Tarreau <w@1wt.eu> wrote:
> > There are some difficulties with gcc versions between linux-2.4 and linux-2.6,
> > but I do not recall all of the details off of the top of my head.  If I recall
> > correctly, one of the issues is, linux-2.4 ?prefers? gcc-2.96, while newer
> > linux-2.6 support/prefer gcc-3.? or greater.

That's correct about gcc-3.4.x & gcc-4.1.x about 2.6 tree support.
This means 2.6 supports both gcc versions. Here are the binaries I do
use:-

http://download.fedora.redhat.com/pub/fedora/linux/core/3/i386/os/Fedora/RPMS/gcc-3.4.2-6.fc3.i386.rpm
http://download.fedora.redhat.com/pub/fedora/linux/core/3/i386/os/Fedora/RPMS/kernel-2.6.9-1.667.i686.rpm

Now issue remains with 2.4 tree. Is it possible to build/install
gcc-4.1.x along with gcc-3.4.x? This is what am trying to figure by
few tests on the FC3 base machine.
Can we call this as backward compatibility?

Any inputs here is helpful :-)

> Hmm, I think you did it the *hard* way. Gcc has been supporting
> multi-version for years. You just have to compile it with --suffix=-3.4
> or --suffix=4.1 to have a whole collection of gcc versions on your host.
> If you don't want to recompile gcc, simply rename the binaries and you're
> OK. When you build, you only have to do :
>
>   $ make bzImage modules CC=gcc-3.4
>
> I've been using it like this for years without problem. It's really
> convenient, and it also allows you to easily compare output codes and
> sizes between compilers.

I did understand this, thanks. I have one doubt: Imagine I have
built/installed these:-

2.4.34 & 2.6.20 kernels has these gcc-3.4.x & gcc-4.1.x compilers
built on say FC6 box. Now issue comes when I run an application. How
does it understand which library use?

example:
myArmWireless app. needs gcc-3.4.x, NOT gcc-2.6.x libs on say 2.4.34 kernel.

Will it take automatically? Or we need to pass args to target the
gcc-3.4.x libs?


Hope you guys consider these (my) questions as Novice, because am
trying to figure a design @ How-To build such multi kernel/gcc
systems.

> Regards,
> Willy

~Akula2
