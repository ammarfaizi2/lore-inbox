Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbTJRPRY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 11:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbTJRPRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 11:17:24 -0400
Received: from line103-242.adsl.actcom.co.il ([192.117.103.242]:7552 "EHLO
	beyondmobile1.beyondsecurity.com") by vger.kernel.org with ESMTP
	id S261656AbTJRPRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 11:17:21 -0400
From: Aviram Jenik <aviram@beyondsecurity.com>
Organization: Beyond Security Ltd.
To: Pavel Machek <pavel@ucw.cz>
Subject: swsusp in test8 fails with intel-agp and i830
Date: Sat, 18 Oct 2003 17:17:03 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200310152347.04263.aviram@beyondsecurity.com> <20031016202105.GL1659@openzaurus.ucw.cz>
In-Reply-To: <20031016202105.GL1659@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310181717.04001.aviram@beyondsecurity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Thursday 16 October 2003 22:21, Pavel Machek wrote:
> Hi!
>
> > Suspend to disk (I'm using echo -n "disk" > /sys/power/state) works about
> > one in ten attempts. When it works, it is _usually_ capable of
> > hibernating a few consecutive times, but then it stops working (reboots
> > on resume).
>
> can you try echo 4 > /proc/acpi/sleep?
>

In 2.6.0-test8 hibernation via "echo 4 > /proc/acpi/sleep" works incredibly 
well from the console. Great work! I tested it many times and it seems quite 
stable.

However, it fails when X is running (even if doing chvt before suspension). 
I followed your advice and removed the video card modules (intel-agp and 
i830). Indeed, when booting without those modules, suspend to disk 
miraculously works from X; I was even able to hibernate from within a KDE 
session and restore to that point exactly.

I am not sure which of the two modules causes the problem, I can only load 
them both. Unfortunately, without those modules the vaio laptop can only give 
640x480, so this is not much of a workaround...

To summarize:
If the intel-agp and i830 modules are not loaded during startup, suspend via 
echo 4 > /proc/acpi/sleep and restore work beautifully. If those modules 
_are_ loaded, and X is running, resume reboots.

- Aviram
