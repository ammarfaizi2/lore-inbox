Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVI2EJI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVI2EJI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 00:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVI2EJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 00:09:07 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:42246 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750759AbVI2EJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 00:09:06 -0400
Date: Thu, 29 Sep 2005 06:04:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Message-ID: <20050929040403.GE18716@alpha.home.local>
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com> <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <433B217F.4060509@pobox.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2005 at 07:04:31PM -0400, Jeff Garzik wrote:
> Linux is about getting things done, not being religious about 
> specifications.  You are way too focused on the SCSI specs, and missing 
> the path we need to take to achieve additional flexibility.
> 
> With Linux, it's all about evolution and the path we take.

Hmmm... I'm fine with "not being religious about specs", but I hope we
try to respect them as much as possible, because it's the only way to
get everything working and not get the finger pointed to when there's
a problem. When I put netfilter + window tracking in production 2 years
ago, there were a lot of drops (about 2% of sessions = ~40/s), because
shortcuts had been taken WRT rfc793 ("the specs"). Then, printing the
whole RFC+erratas was the only way to get the code working and
supporting the most bizarre cases that had previously been considered
stupid or impossible by the developpers (including me during the first
phase of the fixes).

I prefer that we stick to specs even if we just implement what we
*need* from them, leaving lots of blank boxes on the diagram, rather
than interprete them as we think would be better and get annoyed
everytime a vendor tries to adapt it to support his hardware.

> >By "too literal" do you mean "following specs too closely",
> >or do you mean "being realistic without tweaking things".
> 
> I mean, paying too much attention to specs at the expense of 
> understanding how Linux code needs to be shaped.

Both are true : Linux code needs to be shaped to match specs. We
must not spend time on what we don't need but we must respect the
model and layering, and that's true in any subsystem. Networking
for example, is very clean in this area. Even accelerations do
not break layering, it's just that some of the work can be pushed
down from layer to layer until one can process it (eg: checksums).
And when I worked on bonding, I did not have problems with it
breaking upper layers. I really believe that's important, it's
the first step to avoid spending time in debugging.

Cheers,
Willy

