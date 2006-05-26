Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWEZMmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWEZMmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWEZMmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:42:31 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:15197 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1750705AbWEZMma (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:42:30 -0400
Message-ID: <4476F7B1.20307@tls.msk.ru>
Date: Fri, 26 May 2006 16:42:25 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Ingo Oeser <netdev@axxeo.de>
CC: Meelis Roos <mroos@linux.ee>, kernel list <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: Safe remote kernel install howto (Re: [Bugme-new] [Bug 6613]
 New: iptables broken on 32-bit PReP (ARCH=ppc))
References: <200605251004.k4PA4Lek007751@fire-2.osdl.org> <4475FCFC.5000701@trash.net> <Pine.SOC.4.61.0605261008090.14762@math.ut.ee> <200605261429.36078.netdev@axxeo.de>
In-Reply-To: <200605261429.36078.netdev@axxeo.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> Hi Meelis,
> 
>> Unfortunatlety, 2.6.15 does not boot on this machine so I'm locked out 
>> remotely at the moment.
> 
> Here it my paranoid boot setup:
> 
> 1. Use "lilo -R new-kernel", to boot a kernel only
>     once and reboot the default kernel next time.
> 
> 2. Force reboot on any panic after 10 seconds:
> 	append="panic=10" in /etc/lilo.conf
> 
> 3. Schedule automatic reboot in case of impossible login
> 	echo "/bin/sync; /sbin/reboot -f "|at now + 15min

Instead of this, I usually use a system startup script like this:

case "$(cat /proc/cmdline)" in
 *linux-test*)
   (sleep 300; [ -f /var/run/noreboot ] || reboot) &
   ;;
esac

which means that if the kernel image is named 'linux-test', it will
be rebooted in 15 minutes after booting if no /var/run/noreboot file
exist.  So if I'm able to log in, i just touch /var/run/noreboot and
be done with it.

And oh, yes, for this to work, in lilo.conf the new entry should be
labeled linux-test -- ie, install new kernel, add new entry into lilo.conf
with label=linux-test, run `lilo && lilo -R linux-test && init 6' and..
wait ;)  After successeful reboot (and touching /var/run/noreboot), edit
lilo.conf, restore the proper label, set proper order of entries if needed
and re-run lilo.

/mjt
