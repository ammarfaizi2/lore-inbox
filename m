Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268045AbUHKMvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268045AbUHKMvR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 08:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268047AbUHKMvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 08:51:17 -0400
Received: from users.linvision.com ([62.58.92.114]:56008 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S268045AbUHKMvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 08:51:14 -0400
Date: Wed, 11 Aug 2004 14:51:13 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Paul Jackson <pj@sgi.com>, Eric Masson <cool_kid@future-ericsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
Message-ID: <20040811125113.GC10047@harddisk-recovery.com>
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com> <4118E822.3000303@future-ericsoft.com> <20040810092116.7dfe118c.pj@sgi.com> <Pine.LNX.4.53.0408101456260.13579@chaos> <20040811095139.GA10047@harddisk-recovery.com> <Pine.LNX.4.53.0408110721540.15879@chaos> <20040811114100.GB10047@harddisk-recovery.nl> <Pine.LNX.4.53.0408110743020.15953@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408110743020.15953@chaos>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 07:55:52AM -0400, Richard B. Johnson wrote:
> RedHat is NOT Linux. The MAJOR-MINOR 5.1 used in RedHat for the
> console has a very serious problem for anybody doing development
> work. If there are any kernel messages, they go to __all__ open
> terminals. This means that the only "quiet" terminals that may be
> available to kill off a runaway process are available iff you can
> log in over the network.

If you don't want console messages, you just disable console at all, or
you use a serial console (using the "console=" on the kernel command
line), or you adjust the kernel console log level. Please have a look
at the "dmesg" manual page, especially the "-n" parameter. In emergency
situations, Alt-Sysrq-[0-8] will allow you to do the same (on VGA
consoles for PCs, that is. for serial consoles use Break-[0-8]).

> Most everybody I know, who does serious development work, and
> certainly those who want to control where the %*)&$#!@ kernel
> messages go, will make sure they go to the "ALT-F1" as I have
> shown.

Not all the world is a PC, there is a lot of linux beyond x86. Looks to
me like you haven't done development on embedded systems that don't
have any VGA terminal at all.

Getting kernel messages on a certain pseudo tty is just a matter of
supplying the correct "console=" paramater to the kernel. For example:
"console=tty1" will get your console output on pseudo tty 1.
Alternatively, you can configure syslog to write all kernel messages to
a pseudo tty.

> The original query was about how to make kernel messages
> go to where, i.e., what VT do they come from. I have shown
> how you can control where they go.

Here is the original question:

  Thanks for the pointer! My user mode program is running. Any idea how to
  control which console it shows up on?

No reference on how to get kernel messages somewhere.

> Now, if you look at the kernel source, you will note that
> just prior to attempting to exec /sbin/init, /dev/console
> is opened. This means that you can properly use whatever
> you want if you continue to use a sym-link.

That was true for linux < 2.1.71, which was released almost 7 years
ago. Things have changed. Newer kernels use the "console=" kernel
command line to select the console. With multiple the "console="
parameter, you can even have mutiple consoles.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
