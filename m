Return-Path: <linux-kernel-owner+w=401wt.eu-S932717AbWLaEF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWLaEF0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 23:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932720AbWLaEF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 23:05:26 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:35589 "EHLO
	smtp151.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932717AbWLaEFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 23:05:25 -0500
Message-ID: <4597375A.2080804@gentoo.org>
Date: Sat, 30 Dec 2006 23:06:50 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 2.0b1 (X11/20061221)
MIME-Version: 1.0
To: marcel@holtmann.org
CC: bluez-devel@lists.sourceforge.net, billk@iinet.net.au,
       linux-kernel@vger.kernel.org
Subject: 2.6.19 bluetooth PPP (rfcomm) regression
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Testing from Bill Kenworthy indicates that commit 
0a85b964e141a4b8db6eaf500ceace12f8f52f93 introduces a ppp-over-bluetooth 
regression.

https://bugs.gentoo.org/show_bug.cgi?id=159277

Dec 28 21:56:54 rattus hcid[22749]: pin_code_request (sba=00:0A:3A:59:39:38,
dba=00:07:E0:06:AC:7A)
Dec 28 21:57:02 rattus hcid[22749]: link_key_notify (sba=00:0A:3A:59:39:38,
dba=00:07:E0:06:AC:7A)
Dec 28 21:57:37 rattus rfcomm_tty_ioctl: TIOCGSERIAL is not supported
Dec 28 21:57:37 rattus dund[23081]: New connection from 00:07:E0:06:AC:7A
Dec 28 21:57:37 rattus pppd[23094]: pppd 2.4.4 started by root, uid 0
Dec 28 21:57:37 rattus pppd[23094]: Couldn't get channel number: 
Input/output
error
Dec 28 21:57:37 rattus pppd[23094]: Exit.

> diffing net/bluetooth/rfcomm/tty.c between the two kernels shows
> 
> 2.6.19-r2: tty_register_device(rfcomm_tty_driver, dev->id,
> rfcomm_get_device(dev));
> 
> and
> 
> 2.16.18-r2: tty_register_device(rfcomm_tty_driver, dev->id, NULL);
> 
> Changing this line to match the earlier kernel (using NULL) removes the error
> and ppp connects as it should.



I see this has already been reported by Johannes Hoerhan on the bluez 
list. http://thread.gmane.org/gmane.linux.bluez.devel/10148/focus=10232

I don't really see how this could be a udev issue, since it's obviously 
so intricately linked to that line of code.

How can we help diagnose this further - any debugging flags we should 
turn on?

Thanks,
Daniel
