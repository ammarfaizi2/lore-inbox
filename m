Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280660AbRKFXAS>; Tue, 6 Nov 2001 18:00:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280656AbRKFXAJ>; Tue, 6 Nov 2001 18:00:09 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:7945 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280671AbRKFW74>;
	Tue, 6 Nov 2001 17:59:56 -0500
Date: Tue, 6 Nov 2001 15:59:34 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Gutschke <stephan@gutschke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011106155934.B12661@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE870EF.2080508@gutschke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE870EF.2080508@gutschke.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 09 Oct 2001 21:33:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 12:23:27AM +0100, Stephan Gutschke wrote:
> there you go,  the output from  /proc/bus/usb/devices
> By the way I have an Clie N710C which is upgraded
> to an 760 with OS 4.1S, shouldnt make a difference,
> but I just wanted to let you know.

Ah, that might make the difference.  It looks like the number of
endpoints is different on this device, than any other 4.x Clie devices
(they should have 4 bulk endpoints.)  The older devices have 2 endpoints
(endpoints are usually done in hardware)

This Clie is reporting to the driver that it _does_ have 2 "ports" (a
port is 2 endpoint pairs in this scheme), but in reality, it doesn't.
The lying device is then causing the driver to oops when it tries to
write to a port that isn't even there.

I'm going to have to rework the driver to fix this problem, give me a
day or so to come up with a solution.  Are you willing to try a patch
when I have something?

Thanks for the good error reporting, it really helped.

greg k-h
