Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261956AbSJIUgl>; Wed, 9 Oct 2002 16:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261964AbSJIUgl>; Wed, 9 Oct 2002 16:36:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18957 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261956AbSJIUgk>;
	Wed, 9 Oct 2002 16:36:40 -0400
Message-ID: <3DA49496.10401@pobox.com>
Date: Wed, 09 Oct 2002 16:41:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
References: <20021009195531.B1708@mars.ravnborg.org> <Pine.LNX.4.44.0210091141360.14464-100000@penguin.transmeta.com> <20021009212613.A12743@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> But there is a good reason why they do it.
> Take a look at dirvers/video/Config.in for example.
> See the size of the big if's. They span several pages if not the whole file.
> Why they do this is simple. Only check for PCI once, and group all
> PCI stuff there.
> With the syntax Roman propose we see instead that _each_ config option
> check for PCI. Which is good IMHO.

That falls apart for multiple-bus drivers.

The way the current config files handle this seems reasonable...  for 
example drivers/net/ in fact _already_ splits things up by bus type to 
some extent.  But this is not a hard and fast rule, just easing some pain.


> But the whole argumentation boils down to something rahter simple:
> 1) Shall we group configuration files together
> 2) Shall we group related files together


This reminds me of another point:

An eventual goal is for people, mostly initial driver merges or vendors, 
to be able to add a simple driver without patching _any_ files.

Which implies that the equivalent of "source drivers/net/Config*" 
(wildcarding) in Roman's system would be useful.  Or maybe "source 
drivers/net" and it knows that when given a directory it should scan for 
all Config* files in that dir.

	Jeff



