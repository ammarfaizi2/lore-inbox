Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262619AbVCVKvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbVCVKvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262617AbVCVKvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:51:41 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50843 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262620AbVCVKvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:51:36 -0500
Date: Tue, 22 Mar 2005 02:49:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322014922.GA1512@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org> <20050322004456.GB1372@elf.ucw.cz> <20050321170623.4eabc7f8.akpm@osdl.org> <20050322013535.GA1421@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050322013535.GA1421@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> And they are both "dangerous" -- they introduce new and untested
> functionality while I'm trying to transition from int to
> pm_message_t. They also affect all the drivers.

Actually, there's one even more severe problem with
platform_pci_choose_state...

If we are doing freeze for swsusp snapshot (or freeze for kexec or
something similar, that ACPI does not know about), it is very wrong to
ask ACPI to tell us power levels for devices. ACPI does not even know
about those states, it can not tell us anything meaningfull.

So if this hook is to be reintroduced, it should go down in the
function, and only trigger for ACPI S3 and ACPI S1 cases. Maybe for
swsusp/plaform (== ACPI S4).

But I'd prefer the hook to go away for now, it clearly needs
infrastructure that is not yet there, and provides nothing.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
