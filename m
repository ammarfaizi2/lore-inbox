Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161189AbWHJLqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161189AbWHJLqu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161114AbWHJLqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:46:50 -0400
Received: from tango.0pointer.de ([217.160.223.3]:8456 "EHLO tango.0pointer.de")
	by vger.kernel.org with ESMTP id S1161089AbWHJLqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:46:49 -0400
Date: Thu, 10 Aug 2006 13:46:47 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 2/2] acpi,backlight: MSI S270 laptop support - driver
Message-ID: <20060810114647.GA18242@tango.0pointer.de>
References: <CFF307C98FEABE47A452B27C06B85BB60133D741@hdsmsx411.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB60133D741@hdsmsx411.amr.corp.intel.com>
Organization: .phi.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
X-Disclaimer-1: Diese Nachricht wurde mit einer elektronischen 
X-Disclaimer-2: Datenverarbeitungsanlage erstellt und bedarf daher 
X-Disclaimer-3: keiner Unterschrift.
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10.08.06 05:36, Brown, Len (len.brown@intel.com) wrote:

> Lennart,

Hi!

> 
> Your s270 platform driver needs a different home in the source tree
> outside of drivers/acpi/, and the patch that adds it must add an entry
> to MAINTAINERS.

If you look closely you'll see that the patch already adds a new
entry to MAINTAINERS.

I put the the driver in drivers/acpi/ because it relies heavily on the
ACPI EC stuff. But OK, what is a better place for the driver? 

drivers/char/ 
  It doesn't even register any character device.

drivers/video/backlight/
  It doesn't just do backlight control.

drivers/misc/
  Seems to be the last resort for everything that doesn't fit it
  otherwise.

Unless anyone has a better idea I will move it to drivers/misc/, then.

> lcd brightness platform support should talk to the existing
> backlight stuff under sysfs.

It already does exactly that, you can find the backlight class driver
in /sys/class/backlight/s270/.

I cannot map the "automatic brightness control" feature to the
backlight class driver, that's why I duplicated the brightness stuff
in /proc/acpi/s270/.

> wlan and bluetooth indicators/controls need to appear under
> generic places under sysfs -- not under platform specific
> files under /proc/acpi.

What are those "generic" places? I cannot think of any besides a
"platform" device.

> Yes, the existing platform specific drivers such as asus, toshiba, and
> ibm
> are bad examples.

Ok, I will move the /proc/acpi/s270/ stuff to a sysfs platform device,
then. I will cook up another patch shortly.

Any ideas on that ec_transaction() patch I sent earlier?

Lennart

-- 
Lennart Poettering; lennart [at] poettering [dot] net
ICQ# 11060553; GPG 0x1A015CC4; http://0pointer.net/lennart/
