Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265215AbUANJUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 04:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbUANJSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 04:18:52 -0500
Received: from poup.poupinou.org ([195.101.94.96]:44084 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S266057AbUANJR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 04:17:56 -0500
Date: Wed, 14 Jan 2004 10:17:40 +0100
To: paul.devriendt@amd.com
Cc: davej@redhat.com, pavel@ucw.cz, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk, linux@brodo.de
Subject: Re: Cleanups for powernow-k8
Message-ID: <20040114091740.GN14031@poupinou.org>
References: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99F2150714F93F448942F9A9F112634C080EF392@txexmtae.amd.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 04:37:13PM -0600, paul.devriendt@amd.com wrote:

> I have a totally new driver, that I am hoping to release within about
> a month. (I did target the end of the year, but I got distracted on
> some other stuff). The new driver :
>   - uses ACPI to figure out the available p-states. I have seen a *lot*
>     of buggy BIOSs where the PSB/PST info is wrong or missing,
>   - uses ACPI to handle battery / mains power transitions,
> and some other clean ups.

IMHO, a cpufreq driver have to not do things like that.  It's up to
a common library made eventually by ACPI folks to go.  And AFAIK
Dominik do make some patch for that.  There is not only the K8 that
can benefit from what you want to add (K7, Pentium M,...).

> I would appreciate some advice on a question ... should I leave the old
> non-ACPI capability there for those people who do not want to enable ACPI
> in the kernel ? If so, is this a big ifdef, or is there a better way to do
> it ? Or should I just say that it is dependent on ACPI, got to have ACPI ?

Still IMHO, people that want to disable ACPI, but want to be able to
lower the frequency of their processor don't know what they loose.  The
ACPI C-state, for which ACPI provide a good way to save powers in the
idle loop today.  But, I have seen broken BIOS, or bug in the current
ACPI implentation, that do not permit to enable ACPI under Linux, so
unless those issues are resolved, there may be still a need to support
legacy configuration.

BTW, an other drawback for only ACPI config.  I have a K7 mobile
for which I do have only 5 P-state on the ACPI side, instead
of 9 as reported by the legacy method.  One of the P-state is
also broken (the VID is too high).  I can't say of the 'quality'
of BIOS made for the K8 architecture, but it should be possible
that you get more appropriate information via the legacy table than
the one provided by ACPI..  One solution may be a setup at kernel
boot in order to configure the powernow-k8 with legacy method even
if ACPI is enabled, or even a DMI quirk if such (broken) platform are
known.


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
