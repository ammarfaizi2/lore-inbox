Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVA3Szb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVA3Szb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 13:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVA3Szb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 13:55:31 -0500
Received: from dunaweb1.euroweb.hu ([195.184.0.6]:33756 "EHLO
	szolnok.dunaweb.hu") by vger.kernel.org with ESMTP id S261766AbVA3SzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 13:55:18 -0500
Message-ID: <41FD2ED5.6030903@freemail.hu>
Date: Sun, 30 Jan 2005 20:00:37 +0100
From: Zoltan Boszormenyi <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; hu; rv:1.7.3) Gecko/20041020
X-Accept-Language: hu, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Helge Hafting <helgehaf@aitel.hist.no>, Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.10 dies when X uses PCI radeon 9200 SE, further binary search
 result
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jan 30, 2005 at 10:05:16AM -0500, Jon Smirl wrote:
>> I just checked out on current Linus BK with my AGP Radeon 9000 which
>> is pretty close to a 9200. Everything is working fine.
>> 
>> I notice from his logs that he is running a PCI radeon, not an AGP
>> one. Didn't someone make some changes to the PCI radeon memory
>> management code recently? I run a PCI R128 and that is still working.
>> DRM debug output might give more clues.
>> 
> Yes, it is a PCI radeon.  And the machine has an AGP slot
> too, which is used by a matrox G550.  This AGP card was not
> used in the test, (other than being the VGA console).
> Note that there is no crash if I don't compile 
> AGP support, so the crash is related to AGP somehow even though
> AGP is not supposed to be used in this case.
> 
> As I start X (on the radeon) I notice that the VGA console 
> I'm using (on the G550 AGP) goes black.  I see no need for that either,
> the radeon display is a _different_ device so why black out 
> the vgacon?  Could the problem lurk there somehow?
> 
> Helge Hafting

I suspect it's the X server that makes your G550 go black.

XOrg-X11-6.8.2 RC1 or RC2 fixes that by introducing a VGAAccess
option for its radeon driver. I recompiled xorg-x11-6.8.1 with this
fix on my FC3 system. It made the only thing that annoyed me
using the linuxconsole.sf.net ruby patch go away.

I have a Radeon 7000VE PCI and a Radeon 9200SE AGP8x.
Every time I logged out on the first X ( localhost:0 ),
it made the other one (localhost:1) go blank.

With the above mentioned fix (that I collected from the XOrg devel
mailing list and was made by Ben Herrenschmidt) applied to XOrg
and using

Option "VGAAccess" "on"

on the card that is set up for VGA by the BIOS and

Option "VGAAccess" "off"

on the other, this problem went away. This modification disables
using the "vgahw" module in XOrg and unfortunately only applicable
to the radeon driver. BTW this patch was made for specifically
for systems that don't use vgacon, like PPC that don't even have
legacy VGA and for others that use radeonfb.

I guess the VGA routing patch and X cooperation will also
solve "the other VGA(s) in the system go blank when I fire up X"
in a generic way, not only for Radeons.

Best regards,
Zoltán Böszörményi

