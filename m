Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261476AbULIOqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261476AbULIOqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbULIOqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:46:47 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:12021 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261476AbULIOqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:46:39 -0500
Date: Thu, 9 Dec 2004 15:45:48 +0100 (CET)
To: sensors@Stimpy.netroedge.com
Subject: Re: checksum in (i2c) eeprom driver
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <vojkqBdx.1102603548.0379010.khali@localhost>
In-Reply-To: <41B85D43.8070409@verizon.net>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Deepak Saxena" <dsaxena@plexity.net>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004-12-09, Mark Studebaker wrote:

> I think the checksum code is useful because checksum=1 prevents the module
> from claiming ddc monitor eeproms and other devices in its address space
> 50-57.

DDC monitor EEPROMs *are* EEPROMs so there is no reason to exclude them
from this driver. We used to have a specific (ddcmon) driver for these
but this too is an error IMHO. Developping different eeprom drivers for
different natures of eeproms is silly (how many more?). What the ddcmon
driver was doing really belongs to user-space, not kernel-space.

There are not that many non-EEPROMs chips in the 0x50-0x57 range, only
the Maxim MAX6900 RTC according to sensors-detect (quite a rare chip at
that, we don't even have a driver for it yet).

> Since detection for eeproms is otherwise poor, it's the only way we have
> for robust detection.

Except that it only works with memory module EEPROMs.

If the checksumming was that important, I guess it would have been the
default, which it was not. If it is there for the sole purpose of
allowing the user to prevent the eeprom driver from taking over
non-eeprom chips, then the "ignore" module parameter can be used to
achieve the same effect, faster, plus it is configurable on a
per-address basis, while the checksum parameter isn't.

Thanks,
--
Jean Delvare
