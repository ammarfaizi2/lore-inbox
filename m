Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311232AbSCLT6O>; Tue, 12 Mar 2002 14:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSCLT6E>; Tue, 12 Mar 2002 14:58:04 -0500
Received: from fmfdns01.fm.intel.com ([132.233.247.10]:41950 "EHLO
	calliope1.fm.intel.com") by vger.kernel.org with ESMTP
	id <S311232AbSCLT5z>; Tue, 12 Mar 2002 14:57:55 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7CDB@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Mario 'BitKoenig' Holbe'" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Date: Tue, 12 Mar 2002 11:57:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Mario 'BitKoenig' Holbe [mailto:Mario.Holbe@RZ.TU-Ilmenau.DE]
> However, if someone of the ACPI developers or someone of the
> patch-acceptors (:)) tells me 'do it, we'll patch it in', I'll do
> it.
> If it has no chance to get in, I wont do it - for me myself, my
> patch is quite enough :)

Basically we have to disable non-wake GPEs prior to sleeping - I agree with
Pavel that this should not be a config option. The real problem is that the
keyboard GPE should be flagged as a wake GPE, but it isn't yet.

What needs to happen is, when we are entering a sleep state, we need to
evaluate _PRW and _PSW objects for devices, and take the appropriate action
- I would bet that a result of doing this would be that keyboard (WOL too?
maybe) would be properly flagged as a wake device, so the call to that
function would but turn off its GPE bit.

Regards -- Andy
