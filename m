Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261299AbVCKSl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVCKSl0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVCKSkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 13:40:08 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:46347 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261288AbVCKSR2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 13:17:28 -0500
Message-Id: <200503111845.j2BIjkJp003341@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Rob Landley <rob@landley.net>
cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator 
In-Reply-To: Your message of "Thu, 10 Mar 2005 13:41:37 EST."
             <200503101341.37346.rob@landley.net> 
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>  <200503101341.37346.rob@landley.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 11 Mar 2005 13:45:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rob@landley.net said:
> I'm just thinking about those UML hosting farms, with several UML
> instances  per machine, on machines which haven't got a keyboard
> attached constantly  feeding entropy into the pool.  If just ONE of
> them is serving ssl  connections from its own /dev/urandom, that would
> drain the /dev/random  entropy pool on the host machine almost
> immediately... 

All true (except for that last reference to urandom), but also irrelevant to
whether UML's hwrng should be hooked up to the host's /dev/random or not.

As far as I can see, the only thing that matters is that hwrng should produce
real randomness, and that can only be had by reading /dev/random (or maybe
the host's /dev/hwrng, but that's supposed to be fed into /dev/random anyway).

So, hooking up the UML /dev/hwrng to the host's /dev/urandom would be lying.

If the host's entropy pool gets drained as a result, I would say that's an
application bug, and not a reason for UML to get its randomness from the
host's /dev/urandom.

				Jeff

