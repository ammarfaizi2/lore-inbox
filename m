Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750956AbWKBUzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWKBUzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 15:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbWKBUzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 15:55:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:59817 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750956AbWKBUzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 15:55:06 -0500
Date: Thu, 2 Nov 2006 12:54:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Rajesh Shah <rajesh.shah@intel.com>, toralf.foerster@gmx.de,
       Jeff Garzik <jeff@garzik.org>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Auke Kok <auke-jan.h.kok@intel.com>,
       Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: 2.6.19-rc4: known unfixed regressions
In-Reply-To: <200611022102.02302.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0611021240300.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061031195654.GV27968@stusta.de> <200611022102.02302.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Nov 2006, Rafael J. Wysocki wrote:

> Can we please add the following two to the list of known regressions:
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=7082

Ok, I think I'll just revert it.

Decoding the PCI IO range is fine - even if a driver has detached, the 
kernel knows where the PCI devices are, and won't re-use the range. So 
while the patch that triggers the problem seems valid in itself, it's 
probably not worth the pain to apply it at this point. So I think I'll 
revert it - the rationale for the patch was fairly weak.

Greg, or would you prefer to do the honors?

> http://bugzilla.kernel.org/show_bug.cgi?id=7207

This one is apparently purely an e1000 driver problem. Can't help you with 
that one. Although I find it suspicious that the "e1000_resume()" path 
doesn't seem to be calling "e1000_power_up_phy()" before e1000_up().

		Linus
