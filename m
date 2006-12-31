Return-Path: <linux-kernel-owner+w=401wt.eu-S933202AbWLaRH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933202AbWLaRH5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 12:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933204AbWLaRH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 12:07:57 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:1465 "EHLO
	anchor-post-32.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933202AbWLaRH4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 12:07:56 -0500
Date: Sun, 31 Dec 2006 15:10:06 +0000
From: Darren Salt <linux@youmustbejoking.demon.co.uk>
To: linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx
Mail-Followup-To: linux@youmustbejoking.demon.co.uk,linux-kernel@vger.kernel.org,drzeus-mmc@drzeus.cx
Subject: Re: [PATCH 2.6.20-rc2] Add a quirk to allow at least some ENE PCI SD card readers to work again
Message-ID: <4E9DE7C297%linux@youmustbejoking.demon.co.uk>
References: <4E9DA5E8EB%linux@youmustbejoking.demon.co.uk> <4597A791.60007@drzeus.cx>
In-Reply-To: <4597A791.60007@drzeus.cx>
User-Agent: Messenger-Pro/4.14b7 (MsgServe/3.26b1) (RISC-OS/4.02) POPstar/2.06+cvs
X-Editor: Zap 1.47 (27 Apr 2006) [TEST], ZapEmail 0.28.3 (25 Mar 2005) (32)
X-SDate: Sun, 4870 Sep 1993 15:10:06 +0000
X-Message-Flag: Outlook Express is broken. Upgrade to mail(1).
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: 192.168.0.2
X-SA-Exim-Mail-From: linux@youmustbejoking.demon.co.uk
X-SA-Exim-Scanned: No (on pentagram.youmustbejoking.demon.co.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I demand that Pierre Ossman may or may not have written...

> Darren Salt wrote:
>> Add a quirk to allow at least some ENE PCI SD card readers to work again

>> Support for these devices was broken for 2.6.18-rc1 and later by commit
>> 146ad66eac836c0b976c98f428d73e1f6a75270d, which added voltage level
>> support.

>> This restores the previous behaviour for these devices (PCI ID 1524:0550).

>> Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>

> Oh? If this is the source of problems for ENE controllers then this is
> indeed a magnificent find. Good work.

> I'd like to know a little more about it though:

> - Exactly what errors where you seeing without this patch?

The device was recognised, but insertion of a card was effectively not being
noticed, with no messages in the kernel log. (I say 'effectively': interrupts
were definitely being received and processed.)

> - The patch effectively sets only the highest power. Have you tried other
> bit combinations to figure out if all of these are really needed?

I have now... bits 4 to 7 are ignored, so 0x0F is fine; and it's what's
needed since lower values don't work.

It turns out that the reader only supports one voltage (caps &
SDHCI_CAN_VDD_330 is true, the others are false) and the code was already
selecting the correct value for the hardware. So I tried reverting the patch
and ensuring that the first writeb() in sdhci_set_power() isn't done if the
second one will be - and things started working properly again.

> (This also means that the current patch is broken as the limited voltage
> range needs to also be reported to the MMC layer).

> - Could you change the patch so that it covers all ENE controllers and send
> it out for testing on sdhci-devel? That way we could see if there are any
> more ENE controllers that will benefit from this quirk. Just remember to
> ask people for a lspci.

Sent as a follow-up to this message.

(BTW, is there a version of Thunderbird which preserves Mail-Followup-To in
followups? I ask because I see that that header got lost...)

-- 
| Darren Salt    | linux or ds at              | nr. Ashington, | Toon
| RISC OS, Linux | youmustbejoking,demon,co,uk | Northumberland | Army
| + Generate power using sun, wind, water, nuclear.      FORGET COAL AND OIL.

File already exists, 0:1
