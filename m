Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWDRXHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWDRXHW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWDRXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:07:22 -0400
Received: from sccrmhc11.comcast.net ([204.127.200.81]:908 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750801AbWDRXHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:07:22 -0400
Message-ID: <44457128.2010708@acm.org>
Date: Tue, 18 Apr 2006 18:07:20 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rudolf Marek <r.marek@sh.cvut.cz>
CC: wim@iguana.be, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Watchdog device class
References: <4443EED9.30603@sh.cvut.cz>
In-Reply-To: <4443EED9.30603@sh.cvut.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Marek wrote:

>
> The char device of watchdog class is compatible with existing watchdog
> API,
> so no need to change the user applications. There is just one exception
> and this is temperature handling. I belive it should be implemented not
> via IOCTL but using the HWMON class. (100% compatibility can be restored
> with the ioctl class op)
>
> I have defined this class ops so far:
>
> struct watchdog_class_ops {
>     int (*enable)(struct device *);
>     int (*disable)(struct device *);
>     int (*ping)(struct device *);
>     int (*set_timeout)(struct device *, int sec);
>     int (*notify_reboot)(struct notifier_block *this, unsigned long code,
>             void *unused);
> };

Some watchdog devices have the ability to say "I'm about to reboot you,
do you want to do something about it?".  The IPMI watchdog calls this a
pretimeout, but I have seen this concept on at least two other watchdog
devices.  This can be delivered via an NMI or SMI and can be used to
inform the OS ahead of time that it's going to reboot the system.  This
is useful because you can panic, do a coredump, or perform other useful
operations instead of just rebooting.

Do you think this interface belongs in the structure?

-Corey
