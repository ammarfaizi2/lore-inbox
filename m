Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285020AbRLKNFO>; Tue, 11 Dec 2001 08:05:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284971AbRLKNFD>; Tue, 11 Dec 2001 08:05:03 -0500
Received: from [202.54.26.202] ([202.54.26.202]:16059 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S285019AbRLKNEn>;
	Tue, 11 Dec 2001 08:04:43 -0500
X-Lotus-FromDomain: HSS
From: gspujar@hss.hns.com
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, achowdhry@hss.hns.com
Message-ID: <65256B1F.0047CC75.00@sandesh.hss.hns.com>
Date: Tue, 11 Dec 2001 18:37:13 +0530
Subject: Re: software watchdog: it works
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,
Thanks a lot for your help. I modified the softdog code and I get the message
logged in my log file on system reboot.

Thanks
Girish





Russell King <rmk@arm.linux.org.uk> on 12/11/2001 05:20:59 PM

To:   Girish S Pujar/HSS@HSS
cc:   linux-kernel@vger.kernel.org, Atul Chowdhry/HSS@HSS

Subject:  Re: software watchdog




On Tue, Dec 11, 2001 at 04:26:07PM +0530, gspujar@hss.hns.com wrote:
> Why is that the printk output not going to syslog although  I have entry in
> /etc/syslog.conf
>
> kern.crit                       /var/log/pbsc.log
> even after I remove the mdelay call.

The machine reboots before syslog gets to run.

What happens is:

     printk();
     reboot();

During that period, syslog is unable to run, and therefore is unable to
write the log message to disk.

> Does it mean that without using "testing" mode ( I cannot beacuse I need a
> reboot) it is not possible to get log  ?

I suppose you could modify softdog to delay the reboot using it's timer
(the timer fires the first time, you check data to see if it's non-zero.
If it's not, increment watchdog_ticktock.data, and set the watchdog to
timeout in 5 seconds, return).

You should probably prevent softdog_write updating the timer if the
data field is non-zero, so once you don't change the behaviour; this
is of course dependent on your test case.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html





