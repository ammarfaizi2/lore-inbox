Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVKPIsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVKPIsE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVKPIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:48:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:52129
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030218AbVKPIsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:48:03 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
Date: Wed, 16 Nov 2005 02:47:15 -0600
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Ram Pai <linuxram@us.ibm.com>,
       Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org> <200511160835.28636.a1426z@gawab.com>
In-Reply-To: <200511160835.28636.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511160247.15283.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 November 2005 23:35, Al Boldi wrote:
> Linus Torvalds wrote:
> > This is why we have "pivot_root()" and "chroot()", which can both be used
> > to do what you want to do. You mount the new root somewhere else, and
> > then you chroot (or pivot-root) to it. And THEN you do 'chdir("/")' to
> > move the cwd into the new root too (and only at that point have you
> > "lost" the old root - although you can actually get it back if you have
> > some file descriptor open to it).
>
> Wouldn't this constitute a security flaw?
>
> Shouldn't chroot jail you?

A few years ago I had a build script that compiled a new Linux From Scratch 
system I could chroot into, and one of the things in the new chroot 
environment was a different boot loader.  And for testing purposes (and with 
a boot CD standing by) I would chroot into this new environment and run the 
lilo in it to add the new test kernel into the boot option list.

One day, I upgraded to a new kernel version and it stopped working, because 
chroot had acquired some unwanted security feature that prevented lilo from 
properly talking to /dev/hda from within a chroot environment.

I remember being rather put out by this.

Chroot is sometimes used for other purposes than "security".

Rob
