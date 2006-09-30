Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWI3Lsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWI3Lsg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 07:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWI3Lsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 07:48:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:24246 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750872AbWI3Lsf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 07:48:35 -0400
Date: Sat, 30 Sep 2006 13:48:18 +0200
From: Stefan Seyfried <seife@suse.de>
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-acpi@intel.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] preserve correct battery state through suspend/resume cycles
Message-ID: <20060930114817.GA26217@suse.de>
References: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0609280446230.22576@twin.jikos.cz>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-3-seife
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:50:49AM +0200, Jiri Kosina wrote:
> There is a problem in th following scenario(s):
> 
> boot -> suspend -> (un)plug battery -> resume
> 
> The problem arises in both cases - i.e. suspend with battery plugged in, 
> and resume with battery unplugged, or vice versa.
> 
> After resume, when the battery status has changed (plugged in -> unplegged 
> or unplugged -> plugged in) during the time when the system was sleeping, 
> the /proc/acpi/battery/*/* is wrong (showing the state before suspend, not 
> the current state).

Is this also needed if you use "platform" method? Also with suspend-to-RAM?

> The following patch adds ->resume method to the ACPI battery handler, which
> has the only aim - to check whether the battery state has changed during sleep, 
> and if so, update the ACPI internal data structures, so that information 
> published through /proc/acpi/battery/*/* is correct even after suspend/resume
> cycle, during which the battery was removed/inserted.

Although it generally is a good idea to add suspend and resume methods to
all ACPI drivers, it would be interesting to know if you still need this
when using the correct method (platform) instead of the incorrect default
method (shutdown).

echo "platform" > /sys/power/disk
echo "disk" > /sys/power/state
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
