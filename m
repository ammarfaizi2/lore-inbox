Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUBBVSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 16:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265901AbUBBVSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 16:18:34 -0500
Received: from imo-d02.mx.aol.com ([205.188.157.34]:39596 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S265886AbUBBVSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 16:18:31 -0500
Date: Mon, 02 Feb 2004 16:18:27 -0500
From: jgluckca@netscape.net (John)
To: linux-kernel@vger.kernel.org
Subject: ACPI and laptop question
MIME-Version: 1.0
Message-ID: <182E8021.2C94112E.009D6C5C@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 67.61.182.160
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

My first time posting here...

I have a problem that I'm trying to find a solution to...

When Linux starts, the startup script checks to see if the filesystem is due to be checked. If I'm running on AC, it's fine to check the filessystem. However, on batteries, I want to prevent the check from happening.

I'm running a 2.6 series kernel.

Once everything is up and ruuning, the /proc filesystem is mounted and I could do something like this in a script:

# If runninng on batteries, /proc/acpi/ac_adapter/ACAD/state
# will have a line that reads: "state:                   off-line"
# We use this to avoid a fsck if on batteries.
# The next time we go to AC power, the fsck will get done.

if [ -f /proc/acpi/ac_adapter/ACAD/state ]; then
    ac_state=$(grep -o 'off-line' /proc/acpi/ac_adapter/ACAD/state)
      echo "AC adapter is $ac_state"
else
      echo "AC adapter state file not found"                
fi

Unfortunately, the root filesystem check is done before /proc is mounted, so that won't work.

Next I looked at the kernel files to see what it does. I founnd a include/linux/acpi.h which seems to interface with the ACPI subsystem but I can't seem to find any doc on this.

I poked around in the kernel and found various functions driver/acpi/ac.c but I don't think these are avialable as system calls. So.. I can't write a C program to get the ac adapter state.

If anyone cann tell me how to get the ac adapter state __before__ /proc is mounted it would be greatly appreciated.

Please cc my e-mail as I'm not subscribed to this list.

Thanks

John




-- 
The past is history
The future is a mystery
Now is a gift
That's why it's called the present



__________________________________________________________________
New! Unlimited Netscape Internet Service.
Only $9.95 a month -- Sign up today at http://isp.netscape.com/register
Act now to get a personalized email address!

Netscape. Just the Net You Need.
