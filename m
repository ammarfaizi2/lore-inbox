Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVBGOWa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVBGOWa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:22:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVBGOWa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:22:30 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:17333 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261425AbVBGOWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:22:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=MTRvKeLwJdVtDZrdvWtwTH/0Bu+nkDeDX65f65fQJJEoCg8/+bNyoPdhJ7M9/FCkgYtIJ+s1QdyUEn3mXvrr3KLYnf/a6EnY50TCk7wVO8x3FFHeJ4Q5Me7p/ddYA3pgXRSS0rFPCEXyEVQeSXwrlhBiLtP6EkVUlXb6wUHCTng=
Message-ID: <d120d500050207062257490ae2@mail.gmail.com>
Date: Mon, 7 Feb 2005 09:22:19 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Linux joydev joystick disconnect patch 2.6.11-rc2
Cc: Vojtech Pavlik <vojtech@suse.de>, David Fries <dfries@mail.win.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050207122033.GA16959@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041123212813.GA3196@spacedout.fries.net>
	 <d120d500050201072413193c62@mail.gmail.com>
	 <20050206131241.GA19564@ucw.cz>
	 <200502062021.13726.dtor_core@ameritech.net>
	 <20050207122033.GA16959@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005 13:20:33 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Feb 06, 2005 at 08:21:13PM -0500, Dmitry Torokhov wrote:
> > > > Opening braces should go on the same line as the statement (if (...) {).
> > >  
> > > How about this patch?
> >
> > Looks fine now. Hmm, wait a sec... Don't we also need kill_fasync calls in
> > disconnect routines as well?
> 
> This should do it:
> 

Not quite...

> +               list_for_each_entry(list, &evdev->list, node)
> +                       kill_fasync(&list->fasync, SIGIO, POLLHUP | POLLERR);

Wrong band constants - for SIGIO POLL_HUP and POLL_ERR should be used.

/*
 * SIGPOLL si_codes
 */
#define POLL_IN         (__SI_POLL|1)   /* data input available */
#define POLL_OUT        (__SI_POLL|2)   /* output buffers available */
#define POLL_MSG        (__SI_POLL|3)   /* input message available */
#define POLL_ERR        (__SI_POLL|4)   /* i/o error */
#define POLL_PRI        (__SI_POLL|5)   /* high priority input available */
#define POLL_HUP        (__SI_POLL|6)   /* device disconnected */

-- 
Dmitry
