Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263407AbTC2L6N>; Sat, 29 Mar 2003 06:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263404AbTC2L6N>; Sat, 29 Mar 2003 06:58:13 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:26126 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S263407AbTC2L6M>;
	Sat, 29 Mar 2003 06:58:12 -0500
Date: Sat, 29 Mar 2003 13:09:28 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: "list, linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: problem with "ps -olstart"
Message-ID: <20030329120928.GB12005@win.tue.nl>
References: <3E85003A.3DE4DDE7@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E85003A.3DE4DDE7@eyal.emu.id.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 29, 2003 at 01:08:58PM +1100, Eyal Lebedinsky wrote:

> I see a different start time returned on different calls. An example
> is attached below. This is a show stopper for me. Is this a known
> problem? Does it have a solution?
> 
> This is vanilla (my build) 2.4.20 on i386.
> 
> $ while true ; do ps --pid "3026" -olstart,cmd --no-headers ; done
> Thu Mar 27 22:03:11 2003 sh
> Thu Mar 27 22:03:11 2003 sh
> Thu Mar 27 22:03:12 2003 sh
> Thu Mar 27 22:03:11 2003 sh

Look at your ps source. There are many incarnations of ps,
but perhaps you'll find something like

	seconds_since_boot = uptime(0,0);
	seconds_since_1970 = time(NULL);
	time_of_boot = seconds_since_1970 - seconds_since_boot;
	start = time_of_boot + pp->start_time/Hertz;

The interplay of rounding and truncating you see here
results in what you see. Instead of using ps you might try
a tiny utility that reads the start time directly.

Andries

