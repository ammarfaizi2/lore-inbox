Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUG2U7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUG2U7c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265263AbUG2U7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:59:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:46507 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265027AbUG2U7L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:59:11 -0400
Date: Thu, 29 Jul 2004 14:02:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Michael Hunold <hunold@convergence.de>
Cc: js@convergence.de, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-Id: <20040729140211.2a946af4.akpm@osdl.org>
In-Reply-To: <4109519A.1000201@convergence.de>
References: <20040728020444.4dca7e23.akpm@osdl.org>
	<20040728222455.GC5878@convergence.de>
	<20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk>
	<20040728232453.GA6377@convergence.de>
	<4109519A.1000201@convergence.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Hunold <hunold@convergence.de> wrote:
>
> > This is a hack introduced by someone years ago. The "pointer" is
> > actually an integer argument, e.g. in include/linux/dvb/audio.h:
> > 
> > #define AUDIO_SET_MUTE             _IO('o', 6)
> > 
> > actually takes an integer argument (!0 mute, 0 unmute), so one can write
> > 
> > 	if (ioctl(fd, AUDIO_SET_MUTE, 1) == -1)
> > 		perror("mute");
> > 
> > It is unusual (maybe even wrong?), but we cannot change it without
> > losing binary API compatibility. However, I see that sparse might
> > flag this as a possible bug :-(
> 
> Is this convenient trick considered harmful?
> Or is it a creative way of using ioctls?
> 
> We're currently using this stuff in the overhauled DVB v4 API, too. So 
> before we finally establish the DVB v4 API, I'd like to know if this is 
> a no-no.

It's a no-no.  Please define the interface to be as typesafe and as
__user-correct as possible.
