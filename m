Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422912AbWJPWlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422912AbWJPWlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 18:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJPWlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 18:41:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:1215 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422912AbWJPWk7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 18:40:59 -0400
From: Andi Kleen <ak@suse.de>
To: Zachary Amsden <zach@vmware.com>
Subject: Re: [RFC] Avoid PIT SMP lockups
Date: Tue, 17 Oct 2006 00:40:49 +0200
User-Agent: KMail/1.9.3
Cc: caglar@pardus.org.tr, Gerd Hoffmann <kraxel@suse.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
References: <1160170736.6140.31.camel@localhost.localdomain> <200610121045.32846.caglar@pardus.org.tr> <453404F6.5040202@vmware.com>
In-Reply-To: <453404F6.5040202@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610170040.49502.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It might only happen with SMP because the difficulty of getting good 
> enough TSC / timer IRQ synchronization during boot increases 
> exponentially with SMP configurations. And it might pass 10% of the time 
> because you were lucky enough not to fire off another timer interrupt yet.

We have the same problem with NMI watchdog events unfortunately. 
Need to call something in the nmi watchdog code to make sure it is 
not renewed and then reenabled.
Or maybe it's better to figure out a way that yields atomic patches.

I think the best way is to make sure all alternative() patches
are always done before the code can be ever executed - this
means doing it very early for the main kernel. The only exception
would be the LOCK prefix patching, which should be atomic.

iirc there was some more patching except lock prefixes going on for 
SMP<->UP transisitions,  but last time I checked they didn't look 
particularly useful and could be probably eliminated.

-Andi
