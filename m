Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUA3IiW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 03:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUA3IiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 03:38:22 -0500
Received: from cats-mx2.ucsc.edu ([128.114.129.35]:39835 "EHLO ucsc.edu")
	by vger.kernel.org with ESMTP id S266303AbUA3Ih4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 03:37:56 -0500
To: linux-kernel@vger.kernel.org
Subject: net-pf-10, 2.6.1
Message-Id: <E1AmU8a-00005E-00@localhost>
From: root <root@ohlone.ucsc.edu>
Date: Fri, 30 Jan 2004 00:36:28 -0800
X-UCSC-CATS-MailScanner: Found to be clean
X-UCSC-CATS-MailScanner-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since compiling and installing 2.6.1, I, like many others, get these 
repeated error messages:

----------------------------------------------------------------------
Jan 29 22:48:56 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 29 22:53:01 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 29 22:56:28 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 29 23:08:01 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 29 23:14:48 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 29 23:23:01 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
Jan 29 23:31:40 kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256
----------------------------------------------------------------------

I do not have ipv6 support in my kernel-config:

# CONFIG_INET_IPCOMP is not set
# CONFIG_IPV6 is not set
# CONFIG_DECNET is not set

The version of module-init-tools is 3.0-pre5-1 from Debian testing.

Is there any guidance about this little annoyance yet? Most of the
advice I've seen (on other lists) suggests putting the following in
modprobe.conf:

   install net-pf-10 /bin/true

But this has made no difference for me.

There seems to be a correlation between the issue of the error-message
and regular exim runs:

Jan 29 22:53:01 ohlone /USR/SBIN/CRON[284]: (mail) CMD (  if [ -x /usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; then /usr/lib
/exim/exim3 -q ; fi)
Jan 29 22:53:01 ohlone kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256

Jan 30 00:23:01 ohlone /USR/SBIN/CRON[311]: (mail) CMD (  if [ -x /usr/lib/exim/exim3 -a -f /etc/exim/exim.conf ]; then /usr/lib/exim/exim3 -q ; fi)
Jan 30 00:23:01 ohlone kernel: request_module: failed /sbin/modprobe -- net-pf-10. error = 256

Almost all of the error messages from modprobe come exactly on the
heels of a call from cron to run exim. But why should exim spawn an 
attempt to load this module? And why just with kernel 2.6.1?

Thanks for any advice,

Jim
