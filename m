Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUG2GpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUG2GpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 02:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUG2GpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 02:45:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:8888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264382AbUG2Gnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 02:43:49 -0400
Date: Wed, 28 Jul 2004 23:42:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Johannes Stezenbach <js@convergence.de>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-Id: <20040728234214.7121e70d.akpm@osdl.org>
In-Reply-To: <20040729000837.GA6579@convergence.de>
References: <20040728020444.4dca7e23.akpm@osdl.org>
	<20040728222455.GC5878@convergence.de>
	<20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk>
	<20040728232453.GA6377@convergence.de>
	<20040728163440.395b22e0.akpm@osdl.org>
	<20040729000837.GA6579@convergence.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach <js@convergence.de> wrote:
>
> Andrew Morton wrote:
> > Johannes Stezenbach <js@convergence.de> wrote:
> > >
> > > This is a hack introduced by someone years ago. The "pointer" is
> > > actually an integer argument, e.g. in include/linux/dvb/audio.h:
> > > 
> > > #define AUDIO_SET_MUTE             _IO('o', 6)
> > > 
> > > actually takes an integer argument (!0 mute, 0 unmute), so one can write
> > > 
> > > 	if (ioctl(fd, AUDIO_SET_MUTE, 1) == -1)
> > > 		perror("mute");
> > 
> > Is it a boolean argument?
> > 
> > If so, we could change the code to do
> > 
> > 	parg = (void *)(arg ? 1 : 0);
> > 
> > so if someone dereferences it they'll get a nice oops.
> 
> Unfortunately there are a few more ioctls which use enums,
> e.g. AUDIO_CHANNEL_SELECT has an argument of type
> audio_channel_select_t etc. (yes, I know, those typedefs
> should go). Or even DMX_SET_BUFFER_SIZE...

OK.  Well how's about we add a fifth argument to that callback function, of
type `int'?  Stick this integer in there and leave the fourth argument NULL
for this class of ioctl?

