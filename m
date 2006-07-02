Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWGBSGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWGBSGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 14:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWGBSGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 14:06:15 -0400
Received: from gw.goop.org ([64.81.55.164]:55491 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S964848AbWGBSGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 14:06:15 -0400
Message-ID: <44A80B20.1090702@goop.org>
Date: Sun, 02 Jul 2006 11:06:24 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Subject: Re: Suspend to RAM regression tracked down
References: <1151837268.5358.10.camel@idefix.homelinux.org>
In-Reply-To: <1151837268.5358.10.camel@idefix.homelinux.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Marc Valin wrote:
> A while ago, I reported a suspend to RAM regression (fail to resume). I
> have since then tracked down the regression to the changes between
> 2.6.12-rc5-git5 and 2.6.12-rc5-git6. On my laptop, I have only been able
> to reproduce the problem with the ondemand cpufreq governor, but I've
> head of another user with the same (Dell D600) laptop having problem
> with the userspace governor as well. All the details are actually
> http://bugzilla.kernel.org/show_bug.cgi?id=6166 but it seems like it's
> being ignored. It's currently assigned to the ACPI category, but maybe
> it belongs to cpufreq? Anyone can help here?
>   

There was a race in ondemand and conservative which made them lock up on 
resume (possibly only on SMP systems though).  There's a patch for that 
in current -mm, but I suspect there's another problem (still haven't had 
any time to track it down).

The workaround is to switch to one of the performance/powersave/user 
governors just before suspend, and restore the governor on resume.

    J

