Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268036AbUIUUBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268036AbUIUUBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 16:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268033AbUIUUBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 16:01:02 -0400
Received: from gprs214-135.eurotel.cz ([160.218.214.135]:26501 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S268036AbUIUUA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 16:00:57 -0400
Date: Tue, 21 Sep 2004 21:58:02 +0200
From: Pavel Machek <pavel@suse.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: Andi Kleen <ak@suse.de>, acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921195802.GF30425@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi> <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi> <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de> <1095794035.24751.54.camel@tdi> <20040921191826.GF18938@wotan.suse.de> <1095795954.24751.74.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095795954.24751.74.camel@tdi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > >    All pointers are actually interpreted as offsets into the buffer for
> > > this interface.  They are not actually pointers.  I believe the 32bit
> > > emulation problem is limited to an ILP32 application generating data
> > > structures appropriate for an LP64 kernel.  While difficult, it can be
> > > done.
> > 
> > If this involves patching the application - no it cannot be done.
> > The 64bit kernel is supposed to run vanilla 32bit user land.
> > 
> > Please find some other solution for this. An ioctl doesn't sound that bad.
> 
>    Please read the rest of my response to Pavel, I don't think we're on
> the same page as to the extent of this problem.  There is no application
> yet, we're in the process of architecting the interface to it right now.
> Is it impossible to expect an ILP32 application to generate LP64 data
> structures?  Perhaps the LP64 kernel interface could be made smart
> enough to digest ILP32 data structures as Arjan suggests.

You can be pretty sure someone, somewhere will bypass that library,
hardcode types into application, and break it on 64-bit platform.

If I were you, I'd just replace read and write with ioctl, and leave
the rest of design as it was. If we find that someone who bypasses
your userspace library, at least we have a way to deal with it. (And
"cat a file and kill machine" issue is gone, too).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
