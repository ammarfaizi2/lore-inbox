Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284963AbRLKKyC>; Tue, 11 Dec 2001 05:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284964AbRLKKxx>; Tue, 11 Dec 2001 05:53:53 -0500
Received: from [202.54.26.202] ([202.54.26.202]:48294 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S284963AbRLKKxo>;
	Tue, 11 Dec 2001 05:53:44 -0500
X-Lotus-FromDomain: HSS
From: gspujar@hss.hns.com
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org, achowdhry@hss.hns.com
Message-ID: <65256B1F.003BCCC1.00@sandesh.hss.hns.com>
Date: Tue, 11 Dec 2001 16:26:07 +0530
Subject: Re: software watchdog
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Hi,
Why is that the printk output not going to syslog although  I have entry in
/etc/syslog.conf

kern.crit                       /var/log/pbsc.log
even after I remove the mdelay call.

Where as I am getting a log from another driver I am using. It also uses printk.

Does it mean that without using "testing" mode ( I cannot beacuse I need a
reboot) it is
not possible to get log  ?

Thanks in advance
Girish





Russell King <rmk@arm.linux.org.uk> on 12/11/2001 03:38:03 PM

To:   Girish S Pujar/HSS@HSS
cc:   linux-kernel@vger.kernel.org, Atul Chowdhry/HSS@HSS

Subject:  Re: software watchdog




On Tue, Dec 11, 2001 at 01:33:04PM +0530, gspujar@hss.hns.com wrote:
> >>>printk(KERN_CRIT "SOFTDOG: Initiating system reboot.\n"); prints the
> message on the console.
>
> I put a delay of 5secs with mdelay, and I can see the message on the console.
> I wanted the message as a syslog,

In order to log this message to syslog, you need to allow the syslog
process to run.  If you're using a uniprocessor machine, using mdelay()
doesn't allow syslog to run during this time.

Softdog has a "testing" mode, which can be enabled by defining
ONLY_TESTING.  This disables the automatic reboot, but the system
will log the timeout message.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html





