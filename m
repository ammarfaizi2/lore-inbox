Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUAJIrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 03:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUAJIrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 03:47:12 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:10370 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264905AbUAJIrE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 03:47:04 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter.koenigsmann@gmx.de>,
       Gunter =?iso-8859-1?q?K=F6nigsmann?= <gunter@peterpall.de>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync loss (With Patch).
Date: Sat, 10 Jan 2004 03:44:03 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
In-Reply-To: <Pine.LNX.4.53.0401091101170.1050@calcula.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401100344.03758.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 January 2004 05:17 am, Gunter Königsmann wrote:
> Don't know if I'm supposed to the list or to the maintainer, mailing
> tho both.
>
> PROBLEM: My Touchpad generates rapid movements, random clicks and even
> keypress events on the keyboard connected to the same BUS. Resetting
> the Touchpad after bad syncs doesn't help.
>
> Throwing away two packets after a bad sync loss fixed the whole
> problem. One packet is not sufficient.
>

Hi,

As I wrote in my other email the patch as it written does not discard
2 first packets after restoring synchronization, instead it ignores every
2nd packet.

It seems that your laptop can't keep up with 480 bytes/sec data stream that
Synaptics generates in 'high' report rate mode (80 packets/sec, 6 bytes per
packet). Luckily Synaptics offers low rate mode, 40 packets/sec, and I think
you should get the same result as by your patch switching your touchpad in
that mode.

I am going to send 2 patches, one that allows switching high and low rate
for Synaptics using psmouse.rate option (>=80 sets high rate and its default
state). You should try psmouse.rate=40 (or just rate=40 if psmouse is compiled
as a module). The second patch makes psmouse check status of received byte and
drop it early if i8042 reports timeout or parity error.

The patches are on top of my other input patches, you can find all of them at
http://www.geocities.com/dt_or/input/2_6_1/

Or you can grab 2.6.1-mm1 and apply just the 2 I am sending...

I am very interested in results.

Thank you in advance,

Dmitry
