Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTBVQaw>; Sat, 22 Feb 2003 11:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTBVQaw>; Sat, 22 Feb 2003 11:30:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13698
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266292AbTBVQau>; Sat, 22 Feb 2003 11:30:50 -0500
Subject: Re: Module loading on demand
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: davidsen@tmr.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200302221545.h1MFjmkW006417@harpo.it.uu.se>
References: <200302221545.h1MFjmkW006417@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045935675.4721.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 17:41:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 15:45, Mikael Pettersson wrote:
> If this is the RedHat system you mentioned in your post on sym53c8xx
> loading oddity, then you need apply the fix below which I posted to
> LKML on Jan 19th.
> 
> ===snip===
> If you're running a RedHat system, you'll also need the following
> patch to /etc/rc.d/rc.sysinit. Without it the kernel's modprobe and
> hotplug functionalities will be disabled by rc.sysinit.
> 
> --- /etc/rc.d/rc.sysinit.~1~	2002-08-22 23:10:52.000000000 +0200
> +++ /etc/rc.d/rc.sysinit	2003-01-14 03:04:57.000000000 +0100
> @@ -334,7 +334,7 @@
>      IN_INITLOG=
>  fi
>  
> -if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
> +if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
>      USEMODULES=y
>  fi

The other nasty is that if you install Rusty's rpms for the better module tools, and
then install a Red Hat kernel errata your errata kernel will not boot because the
Rusty tools replace insmod.static with a tool which only works standalone on 2.5. Its
not a big deal since most people who build 2.5 kernels build their own 2.4 ones too,
and you can fix the initrd by hand, but it is one to know about.

