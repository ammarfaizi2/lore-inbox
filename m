Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282705AbRLKStL>; Tue, 11 Dec 2001 13:49:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRLKStC>; Tue, 11 Dec 2001 13:49:02 -0500
Received: from waste.org ([209.173.204.2]:12710 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S282530AbRLKSsu>;
	Tue, 11 Dec 2001 13:48:50 -0500
Date: Tue, 11 Dec 2001 12:48:19 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Russell King <rmk@arm.linux.org.uk>
cc: gspujar@hss.hns.com, <linux-kernel@vger.kernel.org>,
        <achowdhry@hss.hns.com>
Subject: Re: software watchdog
In-Reply-To: <20011211115059.A3740@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.40.0112111245350.32074-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Russell King wrote:

> On Tue, Dec 11, 2001 at 04:26:07PM +0530, gspujar@hss.hns.com wrote:
> > Why is that the printk output not going to syslog although  I have entry in
> > /etc/syslog.conf
> >
> > kern.crit                       /var/log/pbsc.log
> > even after I remove the mdelay call.
>
> The machine reboots before syslog gets to run.
>
> What happens is:
>
> 	printk();
> 	reboot();
>
> During that period, syslog is unable to run, and therefore is unable to
> write the log message to disk.
>
> > Does it mean that without using "testing" mode ( I cannot beacuse I need a
> > reboot) it is not possible to get log  ?
>
> I suppose you could modify softdog to delay the reboot using it's timer
> (the timer fires the first time, you check data to see if it's non-zero.
> If it's not, increment watchdog_ticktock.data, and set the watchdog to
> timeout in 5 seconds, return).

Silly. The whole point of watchdog is to reboot a wedged machine. The
reason it's firing is presumably because the userspace watchdog
daemon didn't get a chance to touch the device, so odds that syslog would
get a chance to run are pretty slim.

If you really need a log message, get a serial console.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

