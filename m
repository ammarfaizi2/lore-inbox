Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVE3XBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVE3XBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVE3XBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:01:22 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:58123 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261807AbVE3XBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:01:00 -0400
Date: Mon, 30 May 2005 16:05:57 -0700
To: Karim Yaghmour <karim@opersys.com>
Cc: "Bill Huey (hui)" <bhuey@lnxw.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       James Bruce <bruce@andrew.cmu.edu>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050530230557.GF9972@nietzsche.lynx.com>
References: <20050527233645.GA2283@nietzsche.lynx.com> <4297EB57.5090902@yahoo.com.au> <20050528054503.GA2958@nietzsche.lynx.com> <42981467.6020409@yahoo.com.au> <4299A98D.1080805@andrew.cmu.edu> <429ADEDD.4020805@yahoo.com.au> <429B1898.8040805@andrew.cmu.edu> <429B2160.7010005@yahoo.com.au> <20050530222747.GB9972@nietzsche.lynx.com> <429B99B4.9090005@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429B99B4.9090005@opersys.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2005 at 06:54:44PM -0400, Karim Yaghmour wrote:
> Bill Huey (hui) wrote:
> > Think about what you need to do for app that does sound (hard RT),
> > 3d drawing (mostly soft RT for this example), reading disk IO that's
> > buffered.
> > 
> > By the time you get the sound playback and IO buffering going, you're
> > going to get a pretty complicated commuication layer already going
> > from those points. Now think, what if you intend to do a FFT over that
> > data and display it ?
> > 
> > It's starting to get unmanagably complicated at that point.
> 
> But that's a general argument for having hard-rt in the standard
> kernel. Which one of these steps cannot, from your point of view,
> be implemented in a nanokernel archiecture? ... keeping in mind

No, I'm not that saying that it's impossible. It's just that's going
to be hell to write and maintain since you have deal with jitter across
various domains that influence each other. It's not unlike the "avoid
priority inversion by never letting threads of different priority lock
against each other" argument. It needs to be seperated. But this is an
issue for a single image system as well.

When I think about it in terms of dual kernel primitives, I really have
difficulty thinking about how to use the message queue stuff to integrate
all of the systems involved in particular with shared buffers. Proper
locking in those cases is scary to me for both methods, but at least
the single kernel image stuff uses familiar chunks of memory that I can
manipulate. I'm open to be proven wrong about this point if you have a
good example sources to show me. I really am.

> that, as Andi mentioned, the need for increased responsivness for
> the mainstream kernel is relevant with or without PREEMT_RT and
> that increasing responsiveness is a never-ending work-in-progress.

bill

