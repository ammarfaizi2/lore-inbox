Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262572AbVBCK5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262572AbVBCK5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVBCK5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:57:07 -0500
Received: from isilmar.linta.de ([213.239.214.66]:57737 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S262652AbVBCK4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:56:52 -0500
Date: Thu, 3 Feb 2005 11:56:47 +0100
From: Dominik Brodowski <linux@dominikbrodowski.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050203105647.GA17526@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.de>,
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	LKML <linux-kernel@vger.kernel.org>,
	Dave Jones <davej@codemonkey.org.uk>
References: <200502021428.12134.rjw@sisk.pl> <20050202133153.GD29579@elf.ucw.cz> <200502030108.09508.rjw@sisk.pl> <20050203104126.GC1389@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203104126.GC1389@elf.ucw.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Feb 03, 2005 at 11:41:26AM +0100, Pavel Machek wrote:
> Okay, you are right, restoring it unconditionaly would be bad
> idea. Still it would be nice to tell cpufreq governor "please change
> the frequency ASAP" so it does not run at 800MHz for half an hour
> compiling kernels on AC power.

It already does that... or at least it should. in cpufreq_resume() there is
a call to schedule_work(&cpu_policy->update); which will cause a call
cpufreq_update_policy() in due course. And cpufreq_update_policy() calls the
governor, and it is supposed to adjust the frequency to the user's wish
then.

	Dominik
