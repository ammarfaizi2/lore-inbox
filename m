Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVBHNTk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVBHNTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 08:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261530AbVBHNTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 08:19:40 -0500
Received: from mail.suse.de ([195.135.220.2]:17539 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261529AbVBHNTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 08:19:38 -0500
Message-ID: <4208BC68.8070700@suse.de>
Date: Tue, 08 Feb 2005 14:19:36 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: aurelien francillon <aurel@naurel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG]  linux-2.6.11-rc3 probably in ACPI  battery procfs ...
References: <4207557B.2090500@naurel.org>
In-Reply-To: <4207557B.2090500@naurel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

aurelien francillon wrote:
> hi,
> since just before linux-2.6.11-rc3  ( i think it's rc2-bk10 ) there
> seems to have a bug in the acpi part of the proc file system :
> reading /proc/acpi/battery/BAT0/info  takes a very long time and locks
> up the computer, time gives:
> cat /proc/acpi/battery/BAT0/info  0.00s user 6.76s system 12030% cpu
> 0.056 total
> I notice it because kde reads it every 10seconds ... so the compuer gets
> locked for ~5s every ~10s ...

> computer is a dell D600 laptop,

I have seen the same on a D600 and an Compaq Armada E500, not 6 seconds
but ~1.2 seconds. Try to put a

#define ACPI_ENABLE_OBJECT_CACHE 1

at the end of include/acpi/acpi.h (before the last #endif), this sort of
fixed it for me (now it again needs ~0.2 seconds, still way too long,
but the same as with the last good 2.6.11-rc2-bk9).

Good luck :-)

Stefan
