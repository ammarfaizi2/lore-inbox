Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbUKHWgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbUKHWgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbUKHWgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:36:46 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:23883 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261273AbUKHWgg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:36:36 -0500
Date: Mon, 8 Nov 2004 23:37:03 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: makeing a loadable module
Message-ID: <20041108223703.GC16261@mars.ravnborg.org>
Mail-Followup-To: Gene Heskett <gene.heskett@verizon.net>,
	linux-kernel@vger.kernel.org
References: <200411072328.48785.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411072328.48785.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 07, 2004 at 11:28:48PM -0500, Gene Heskett wrote:
> Greetings;
> 
> I found some code I can play with/hack/etc, in the form of a loadable 
> module and some testing driver programs, in 'dpci8255.tar.gz'.
> 
> Unforch its for a slightly different card than the one I have, and 
> once I've hacked the code to suit, I need to rebuild it.
> 
> So whats the gcc command line to make just a bare, loadable module for 
> say a 2.4.25 kernel?   Obviously I'm missing something when it 
> complains and quits, claiming there is no 'main' defined, which I 
> don't think modules actually have one of those?
> 
> What I'm trying to do (hey, no big dummy jokes please :)
> 
> [root@coyote dist]# cc -o dpci8255.o dpci8255lib.c
> /usr/lib/gcc-lib/i386-redhat-linux/3.3.3/../../../crt1.o(.text+0x18): 
> In function `_start':
> : undefined reference to `main'
> collect2: ld returned 1 exit status

Create a small Makefile:
echo obj-m := dpci8255.o > Makefile

And use:
make -C $PATH_TO_KERNEL_SRC SUBDIRS=$PWD modules

This will give you the correct gcc commandline - adopted to actual
configuration of the kernel.
Any other way to compile a module is br0ken.

For 2.6 the above syntax works as well, but simpler versions exists.

	Sam
