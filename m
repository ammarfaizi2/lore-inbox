Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbRADXyA>; Thu, 4 Jan 2001 18:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRADXxu>; Thu, 4 Jan 2001 18:53:50 -0500
Received: from 209.102.21.2 ([209.102.21.2]:64524 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S129588AbRADXxb>;
	Thu, 4 Jan 2001 18:53:31 -0500
Message-ID: <3A54DC87.5B861B7@goingware.com>
Date: Thu, 04 Jan 2001 20:26:47 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-prerelease-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: How to Power off with ACPI/APM?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I said:

> Looking back in the ACPI kernel config help, it says you can use ACPI 
> if you also have APM enabled, which I didn't do at first. 

egger@suse.de (Daniel) replied:

> That's wrong then, you can't use ACPI and APM at the same time. 

I think the documentation in the kernel config help is unclear.  The way it's
phrased seems to imply that you want to use them together.  Thinking about it, I
believe what is really meant is that if ACPI and APM are both enabled, ACPI will
take precedence - but that is not what happens.

 APM gives its message first in the boot process, then later ACPI does.  But
ACPI says something like "APM already present, exiting", so the doc is wrong
both ways you read it, or else ACPI doesn't succeed in the intended behavior to
override APM.

in linux/Documentation/Configure.help, the following text appears in ACPI's
entry:

If both ACPI and Advanced Power Management (APM) support
are configured, ACPI is used.

Perhaps better wording would be (um, perhaps someone could show this clueless
old Mac programmer how to use diff to make a patch?):

If both ACPI and Advanced Power Management (APM) support
are configured, ACPI takes precedence and APM is not used.

but that's not what actually happens, in practice APM gets used.

Anyway, I turned off ACPI in my config and rebuilt my kernel, and I still can't
power off.

Just to make sure, I tried to force the power off with this:

sync
sync
sync
halt -f -p

I got the message "Power Down" but my system stayed on and I was still in my
shell.

I verfied that apmd got started at boot time and that the file /proc/apm exists
and has some stuff in it:

1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

I'm using the binary of halt that came with Slackware 7.1.  Do I need to update
any of my executable programs to work with the new kernel?  The only thing I've
done is installed the latest modutils.  I did download the latest util-linux
from kernel.org but this didn't appear to have the same program Slackware uses -
there's a shutdown program, but on slackware I think shutdown is a script and
there's a halt binary with reboot symlinked to it.

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
