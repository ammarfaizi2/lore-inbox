Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTEYEQU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbTEYEQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:16:20 -0400
Received: from smtp4.knology.net ([24.214.63.227]:42724 "HELO
	smtp4.knology.net") by vger.kernel.org with SMTP id S261589AbTEYEQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:16:17 -0400
Subject: Re: Still more Redhat Module Troubles
From: John Shillinglaw <linuxtech@knology.net>
To: mikpe@csd.uu.se
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305241014.h4OAE8s0011456@harpo.it.uu.se>
References: <200305241014.h4OAE8s0011456@harpo.it.uu.se>
Content-Type: text/plain
Organization: 
Message-Id: <1053836965.2912.5.camel@Aragorn>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 May 2003 00:29:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks again,

My only real problem now seems to be that while X loads like it's
supposed to, my mouse ( generic ps/2 wheel mouse ) doesn't move once X
has started.

Only other problems were a message about keybdev being not found which I
understand is normal, and a usb-ohci not found error which hopefully I
found the missing config setting for.

If I can just figure out why the mouse doesn't work, I'll be running on
2.5.69

Thanks again
On Sat, 2003-05-24 at 06:14, mikpe@csd.uu.se wrote:
> On 24 May 2003 00:02:30 -0400, John Shillinglaw wrote:
> >Anyway I get not found messages when redhat modprobes char-major-10-1,
> >eth1, etc. when it boots up. This seems to be related to aliases since
> >eth1 is aliased to sis900 and char-major-10-1 to psaux. All help greatly
> >appreciated... exact details and .config file below:
> ...
> >I also tried to run the generate modprobe.conf script with no changes to
> >the behavior.
> 
> Did you install the generated modprobe.conf in /etc? If not, do so.
> 
> rc.sysinit has a known problem that causes it to disable module
> autoloading in 2.5 kernels. Fixed by the patch below.
> 
> mkinitrd generally doesn't work with 2.5 modules, or once the new
> module-init-tools have been installed. I don't know how to fix
> that; maybe an LKML archive search will find something.
> 
> --- /etc/rc.d/rc.sysinit~	2003-02-24 22:54:17.000000000 +0100
> +++ /etc/rc.d/rc.sysinit	2003-05-01 17:07:09.000000000 +0200
> @@ -357,7 +357,7 @@
>      IN_INITLOG=
>  fi
>  
> -if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
> +if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
>      USEMODULES=y
>  fi
>  
> 

