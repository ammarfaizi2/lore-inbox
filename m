Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267366AbUG2AHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267366AbUG2AHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267367AbUG2AHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:07:40 -0400
Received: from mail.convergence.de ([212.84.236.4]:43490 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267366AbUG2AHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:07:34 -0400
Date: Thu, 29 Jul 2004 02:08:37 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040729000837.GA6579@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040728222455.GC5878@convergence.de> <20040728224423.GJ12308@parcelfarce.linux.theplanet.co.uk> <20040728232453.GA6377@convergence.de> <20040728163440.395b22e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728163440.395b22e0.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Johannes Stezenbach <js@convergence.de> wrote:
> >
> > This is a hack introduced by someone years ago. The "pointer" is
> > actually an integer argument, e.g. in include/linux/dvb/audio.h:
> > 
> > #define AUDIO_SET_MUTE             _IO('o', 6)
> > 
> > actually takes an integer argument (!0 mute, 0 unmute), so one can write
> > 
> > 	if (ioctl(fd, AUDIO_SET_MUTE, 1) == -1)
> > 		perror("mute");
> 
> Is it a boolean argument?
> 
> If so, we could change the code to do
> 
> 	parg = (void *)(arg ? 1 : 0);
> 
> so if someone dereferences it they'll get a nice oops.

Unfortunately there are a few more ioctls which use enums,
e.g. AUDIO_CHANNEL_SELECT has an argument of type
audio_channel_select_t etc. (yes, I know, those typedefs
should go). Or even DMX_SET_BUFFER_SIZE...

Johannes
