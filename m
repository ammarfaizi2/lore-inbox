Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWF1Gw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWF1Gw3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWF1Gw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:52:29 -0400
Received: from styx.suse.cz ([82.119.242.94]:52181 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932694AbWF1Gw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:52:29 -0400
Date: Wed, 28 Jun 2006 08:52:04 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Marko Macek <Marko.Macek@gmx.net>, thoffman@arnor.net,
       vanackere@lif.univ-mrs.fr, linux-kernel@vger.kernel.org
Subject: Re: USB input ati_remote autorepeat problem
Message-ID: <20060628065204.GC5546@suse.cz>
References: <44A18C38.7040504@gmx.net> <29495f1d0606271446y79ffef0aiffe445ee9e3909cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d0606271446y79ffef0aiffe445ee9e3909cd@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 02:46:39PM -0700, Nish Aravamudan wrote:
> On 6/27/06, Marko Macek <Marko.Macek@gmx.net> wrote:
> >Hello!
> >
> >I have problems with autorepeat in ati_remote (drivers/usb/input) driver
> >in "recent" kernels: all keys start repeating immediately without some
> >delay.
> >
> >This makes some things, like changing the channel prev/next or toggling
> >fullscreen, etc... impossible/hard.
> >
> >The problem seems to be related to FILTER_TIME and HZ=250 (which I
> >forgot to change).
> >
> >FILTER_TIME is defined to HZ / 20, and since 250 is not divisible by 20,
> >the time will be too short to ignore enough events.
> >
> >Defining FILTER_TIME to HZ / 20 + 1 seems to fix things, but I'm not
> >sure if there are any bad side effects.
> 
> Can you try just defining it to msecs_to_jiffies(50)? That should
> handle the various HZ cases just fine.
 
Indeed, that would be thr right solution. Even better would be to 

	#define	FILTER_TIME	50	/* 50 msec */

and later use

	msecs_to_jiffies(FILTER_TIME)

in the code.

-- 
Vojtech Pavlik
Director SuSE Labs
