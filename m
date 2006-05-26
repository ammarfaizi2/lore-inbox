Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWEZM3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWEZM3t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWEZM3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:29:48 -0400
Received: from mail.axxeo.de ([82.100.226.146]:44161 "EHLO mail.axxeo.de")
	by vger.kernel.org with ESMTP id S1750750AbWEZM3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:29:47 -0400
From: Ingo Oeser <netdev@axxeo.de>
Organization: Axxeo GmbH
To: Meelis Roos <mroos@linux.ee>
Subject: Safe remote kernel install howto (Re: [Bugme-new] [Bug 6613] New: iptables broken on 32-bit PReP (ARCH=ppc))
Date: Fri, 26 May 2006 14:29:35 +0200
User-Agent: KMail/1.9.1
References: <200605251004.k4PA4Lek007751@fire-2.osdl.org> <4475FCFC.5000701@trash.net> <Pine.SOC.4.61.0605261008090.14762@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0605261008090.14762@math.ut.ee>
Cc: kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605261429.36078.netdev@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meelis,

> Unfortunatlety, 2.6.15 does not boot on this machine so I'm locked out 
> remotely at the moment.

Here it my paranoid boot setup:

1. Use "lilo -R new-kernel", to boot a kernel only
    once and reboot the default kernel next time.

2. Force reboot on any panic after 10 seconds:
	append="panic=10" in /etc/lilo.conf

3. Schedule automatic reboot in case of impossible login
	echo "/bin/sync; /sbin/reboot -f "|at now + 15min

4. Put "sysctl -w kernel.panic_on_oops=1" as early as possible
     in your boot scripts[1].

And now reboot into the new kernel, try to login and delete the reboot
cronjob. If this doesn't work, just wait 15min and have the last stable kernel
booted automatically.

This method saved me and our customers a lot of time already :-)


Regards

Ingo Oeser

[1] This should be the default and should be disabled by the init scripts 
      as soon as we reach the desired runlevel (S99oops_not_fatal).
