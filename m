Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267935AbUHKJvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267935AbUHKJvm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 05:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268015AbUHKJvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 05:51:42 -0400
Received: from users.linvision.com ([62.58.92.114]:58553 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S267935AbUHKJvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 05:51:40 -0400
Date: Wed, 11 Aug 2004 11:51:39 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Paul Jackson <pj@sgi.com>, Eric Masson <cool_kid@future-ericsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Fork and Exec a process within the kernel
Message-ID: <20040811095139.GA10047@harddisk-recovery.com>
References: <4117E68A.4090701@future-ericsoft.com> <20040809161003.554a5de1.pj@sgi.com> <4118E822.3000303@future-ericsoft.com> <20040810092116.7dfe118c.pj@sgi.com> <Pine.LNX.4.53.0408101456260.13579@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408101456260.13579@chaos>
User-Agent: Mutt/1.3.28i
Organization: Harddisk-recovery.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:03:08PM -0400, Richard B. Johnson wrote:
> /dev/console is a symlink to /dev/tty0.

Please don't mislead newbies, Richard. /dev/console is NOT a link to
/dev/tty0, it's a completely different device:

erik@abra2:~ >ls -l /dev/console 
crw-------    1 root     tty        5,   1 Apr  7 09:13 /dev/console
erik@abra2:~ >ls -l /dev/tty0
crw-------    1 root     tty        4,   0 Feb 10  2000 /dev/tty0

On x86 desktop systems console output usually comes on the virtual
terminals, but you can also use serial console. My embedded StrongARM
board only has serial console.

>     struct termios term;
> 
>     tcgetattr(0, &term);	// Get old terminal characteristics
>     (void)close(0);		// Close old terminal(s)
>     (void)close(1);
>     (void)close(2);
>     fd = open("/dev/console", O_RDWR);

And what happens when you have console on a device that's not a serial
port like a line printer?


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
