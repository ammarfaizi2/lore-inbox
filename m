Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261809AbUJYNwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUJYNwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261817AbUJYNt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:49:56 -0400
Received: from sd291.sivit.org ([194.146.225.122]:35005 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261806AbUJYNtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:49:22 -0400
Date: Mon, 25 Oct 2004 15:50:36 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041025135036.GA3161@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025125629.GF6027@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 02:56:29PM +0200, Stelian Pop wrote:

> I have quite a few changes in my tree already for the sonypi driver,
> and I was delaying the submission because I need to solve a problem
> with the integration with the input subsystem...

Speaking of this, Vojtech, how should I proceed ?

Let me remind you the problem: I am in the process of converting
the sonypi driver to (fully) use the input subsystem to forward 
special key presses to X and the console instead of using a userspace
daemon which pushes the KeyPress events into the X queue.

The special keys are like KEY_BACK, KEY_HELP, KEY_ZOOM, KEY_CAMERA,
and a dozen FN + some key combinations.

I can integrate those events into the input layer in 2 different ways:

* allocate a new key event (in include/linux/input.h) for each
  key *and* combination. This will make the keys and the combinations
  work both on the console and in X.

  Unfortunately only events under the 0xff limit seem to be
  propagated to X, the other ones don't generate any X event (I haven't
  looked at the problem but I suppose it somewhere into the X code).

  showkey does corectly see the keys in raw mode.

* allocate a FN key event and let FN be a modifier.

  This is much nicer (less events allocated in input.h), but I haven't
  found a way (and I'm not sure there is one) to say to X that Fn is a 
  *new* modifier. Yes, I can say FN act like a Control, Meta or whatever
  existing modifier, but this is useless since I already have a Control,
  Alt, etc. key on my keyboard. The whole point is to add support for 
  a new key !

  I also haven't looked yet at adding a new modifier in the console
  mode...

Please advice on the recommended way to do this properly.

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
