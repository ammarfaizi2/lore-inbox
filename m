Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbTIXMgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbTIXMgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 08:36:19 -0400
Received: from mail.gmx.de ([213.165.64.20]:34282 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261287AbTIXMgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 08:36:18 -0400
X-Authenticated: #536991
Date: Wed, 24 Sep 2003 14:36:14 +0200
From: Robert Vollmert <rvollmert-lists@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Local APIC with ACPI freezes ASUS M2400N (update)
Message-ID: <20030924123614.GB6314@krikkit>
Mail-Followup-To: Robert Vollmert <rvollmert-lists@gmx.net>,
	linux-kernel@vger.kernel.org
References: <20030922155524.GA8167@krikkit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922155524.GA8167@krikkit>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> when Local APIC is enabled, my ASUS M2400N notebook (Centrino / ICH4-M
> chipset) freezes when ACPI initialises or tries to switch the display
> device. When Local APIC is not enabled, this does not occur. This
> happens both with 2.4.22 with ACPI patch from 20030916 and with
> unpatched (apart from a patch to load the DSDT via initrd)
> 2.6.0-test5.

[...]

> The freeze occurs when the DSDT writes to SystemIO address 0xb2. It
> does this both to query information about the active display device
> and to change the device.

a little more information on this issue: The XFree86 driver for the
chipset (i855GM) has some code for switching and querying active
displays that talks to the video BIOS via "int 10h".

Adapting this to LRMI (http://sourceforge.net/projects/lrmi), it is
possible to query and set the active display devices. This works
without freezing the computer even when "Local APIC" is enabled.

Is it likely or at least possible that the BIOS talks to the video
BIOS when the DSDT writes to 0xB2? If so, is that something it
shouldn't be doing, or should this not cause any problems?

Cheers
Robert
