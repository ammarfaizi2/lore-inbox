Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422637AbWJPQWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422637AbWJPQWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWJPQWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:22:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:49288 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422637AbWJPQWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:22:53 -0400
From: Andi Kleen <ak@suse.de>
To: Gerd Hoffmann <kraxel@suse.de>
Subject: Vmware problems was Re: [RFC] Avoid PIT SMP lockups
Date: Mon, 16 Oct 2006 18:22:48 +0200
User-Agent: KMail/1.9.3
Cc: john stultz <johnstul@us.ibm.com>, caglar@pardus.org.tr,
       lkml <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
References: <1160170736.6140.31.camel@localhost.localdomain> <1160592235.5973.5.camel@localhost.localdomain> <4533AE82.6010502@suse.de>
In-Reply-To: <4533AE82.6010502@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161822.48500.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 October 2006 18:08, Gerd Hoffmann wrote:
> john stultz wrote:
> > Hey Gerd,
> > 	Looks like the smp replacements code in 2.6.18 is breaking with vmware.
> > I'm guessing we're taking an interrupt while apply_replacements is
> > running. Any ideas?
> 
> It's not the smp alternatives code, its the one for processor-specific
> instructions.  The eip offset for alternative_instructions() in the
> trace suggests it is the first call to apply_replacements.  The second
> one is the one for the smp alternatives (which doesn't do anything btw
> as we patch away the lock prefixes only).

I would have expected that they trap those writes and invalidate the cache.
Even qemu and valgrind do that fine.

Perhaps Zach has some clue or can refer to someone who has.

-Andi
