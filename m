Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbVBNMOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVBNMOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 07:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVBNMOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 07:14:50 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:62933 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261420AbVBNMOo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 07:14:44 -0500
Date: Mon, 14 Feb 2005 13:13:30 +0100 (CET)
To: stelian@popies.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <CKthPPXN.1108383209.9808960.khali@localhost>
In-Reply-To: <20050214100738.GC3233@crusoe.alcove-fr>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, acpi-devel@lists.sourceforge.net,
       "Pekka Enberg" <penberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stelian, all,

On 2005-02-14, Stelian Pop wrote:
> I have some interesting information from one user, who noticed that:
>
> * pbr is the power-on brightness. It's the brightness that the
>   laptop uses at power-on time.

Hey, that makes full sense. After playing around with the debug mode, I
noticed that the brightness was at the minimum level on next boot. I
thought it was related to the fact that I didn't have the opportunity
to stop my system cleanly, but it is indeed possible that I had written
0 to pbr before the crash. Will test this evening.

This reminds me of a related thing I had noticed some times ago but
couldn't explain back then. Brightness changes made under Linux using
spicctrl always seemed to be temporary (lost over reboot) while those
made under Windows on the same laptop were permanent (preserved over
reboot). Now I have to believe that spicctrl was only changing brt,
while the Windows tool was probably changing both brt and pbr?

So, what about either renaming pbr to brightness_default, or making the
brightness file dual-valued (several acpi files do that already)? And I
guess that the pbr value would need to be limited to the 0-8 range just
like is done for brt.

> * cdp is the CD-ROM power. Writing 0 to cdp turns off the cdrom in
>   order to save a bit of power consumption.

I don't seem to have cdp on my system. Is this something I need to
manually activate in the driver, or does it simply mean that my laptop
doesn't support that feature?

Thanks,
--
Jean Delvare
