Return-Path: <linux-kernel-owner+w=401wt.eu-S1750908AbXAICHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbXAICHc (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 21:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750817AbXAICHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 21:07:32 -0500
Received: from mail1.webmaster.com ([216.152.64.169]:2693 "EHLO
	mail1.webmaster.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbXAICHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 21:07:31 -0500
From: "David Schwartz" <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: Intel Core Duo/Duo2 T2300/E6400 - Hyper-Threading (the absence of)
Date: Mon, 8 Jan 2007 18:06:20 -0800
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEOGAMAC.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20070108094432.GF5276@curie-int.orbis-terrarum.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3028
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Mon, 08 Jan 2007 19:09:13 -0800
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Mon, 08 Jan 2007 19:09:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On two of my new machines, with Intel Core Duo T2300 and Core2 Duo E6400
> chips respectively, I noticed some weirdness in how many CPUs are
> present.
>
> If the hyper-threading bit is present in the CPU info, should there
> always be a an extra CPU presented to the system per physical core?

No. That just means the CPU supports hyper-threading technology. That
doesn't mean it actually has an extra CPU per physical core, or that even if
it did, that that core was enabled.

> Both the Core1 and Core2 chips I have the ht bit set, but present only
> their two physical cores to the system. No access to the hyper-threading
> capabilities at all. I also see no configuration options in the BIOS to
> enable or disable hyper-threading. That is, /proc/cpuinfo and all
> topology data only shows 2 CPUs present, and that they are not the HT
> pair.
> (CONFIG_NR_CPUS=8 is set).

Intel considers multiple physical cores on a chip to be hyper-threading too.
HT is a marketing term, not a technical one.

> (This was originally triggered by somebody else's code that read the CPU
> flags, saw hyper-threading, and decided there were 2x cpus for each
> physical core. Said code has already been taken out back and shot
> repeatedly).

Yeah, that's wrong for many reasons. Even if the CPU does support an extra
logical core per physical core, it may or may not be enabled and in use.
Basically, the HT bit being set tells you that you should continue to
determine the number of logical and physical cores present. It's just a step
in the detection sequence.

DS


