Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284989AbRLKLvf>; Tue, 11 Dec 2001 06:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284996AbRLKLvZ>; Tue, 11 Dec 2001 06:51:25 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:49930 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284989AbRLKLvT>; Tue, 11 Dec 2001 06:51:19 -0500
Date: Tue, 11 Dec 2001 11:50:59 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: gspujar@hss.hns.com
Cc: linux-kernel@vger.kernel.org, achowdhry@hss.hns.com
Subject: Re: software watchdog
Message-ID: <20011211115059.A3740@flint.arm.linux.org.uk>
In-Reply-To: <65256B1F.003BCCC1.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <65256B1F.003BCCC1.00@sandesh.hss.hns.com>; from gspujar@hss.hns.com on Tue, Dec 11, 2001 at 04:26:07PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

