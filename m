Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760198AbWLFFg1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760198AbWLFFg1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 00:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760229AbWLFFg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 00:36:26 -0500
Received: from adelie.ubuntu.com ([82.211.81.139]:56154 "EHLO
	adelie.ubuntu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760232AbWLFFfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 00:35:54 -0500
Subject: Re: [PATCH 0/3] New firewire stack
From: Ben Collins <ben.collins@ubuntu.com>
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <4575FF08.2030100@redhat.com>
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>
	 <20061205184921.GA5029@martell.zuzino.mipt.ru>
	 <4575FF08.2030100@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Date: Wed, 06 Dec 2006 00:35:49 -0500
Message-Id: <1165383349.7443.78.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-05 at 18:21 -0500, Kristian Høgsberg wrote:
> Alexey Dobriyan wrote:
> > On Tue, Dec 05, 2006 at 12:22:29AM -0500, Kristian Høgsberg wrote:
> >> I'm announcing an alternative firewire stack that I've been working on 
> >> the last few weeks.
> > 
> > Is mainline firewire so hopeless, that you've decided to rewrite it? Could
> > you show some ugly places in it?
> 
> Yes.  I'm not doing this lightheartedly.  It's a lot of work and it will
> introduce regressions and instability for a little while.
> 
> My main point about ohci1394 (the old stacks PCI driver) is, that if you
> really want to fix the issues with this driver, you have to shuffle the code
> around so much that you'll introduce as many regressions as a clean rewrite.
> The big problems in the ohci1394 drivers is the irq_handler, bus reset
> handling and config rom handling.  These are some of the strong points of
> fw-ohci.c:

My main concern is that when I picked up ieee1394 maint myself, it was
because it was not big-endian or 64-bit friendly. I spent the better
part of 3 months getting this right on PPC and UltraSPARC. Not because
it's hard to fix these issues, but because the hardware is not well
defined for a lot of these cases (I know you've seen the ohci1394 code
to handle endianness).

So while I can understand that ieee1394 doesn't have much man power
right now, and that there are some hard to find bugs in the current
tree, I can't see how starting from scratch alleviates this.

The tree is years old, and a lot of work has been put into it (lots of
my work, I'll admit I'm being a little protective). I'm not sure that
"replacing" it is wise, or even needed. Fork it, clean it up, but
rewriting just doesn't make sense.

Granted, this is your time, and you can spend it how you want, I just
don't want to see the ieee1394 stack take a step backwards in the hopes
that it will be better a year down the road.
