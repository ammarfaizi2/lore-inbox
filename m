Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVCAWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVCAWdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbVCAWcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:32:45 -0500
Received: from gate.crashing.org ([63.228.1.57]:65474 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262104AbVCAWax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:30:53 -0500
Subject: Re: [PATCH/RFC] I/O-check interface for driver's error handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linas Vepstas <linas@austin.ibm.com>,
       "Luck, Tony" <tony.luck@intel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
References: <422428EC.3090905@jp.fujitsu.com> <m1hdjvi8r3.fsf@muc.de>
	 <Pine.LNX.4.58.0503011001320.25732@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 09:26:30 +1100
Message-Id: <1109715991.5680.49.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In fact, I'd argue that even a driver that _uses_ the interface should not
> necessarily shut itself down on error. Obviously, it should always log the
> error, but outside of that it might be good if the operator can decide and
> set a flag whether it should try to re-try (which may not always be
> possible, of course), shut down, or just continue.

In lots of case, you don't have an operator smart enough to make this
decision nowadays, and even if you had, for things like your SCSI
adapter, you just can't expect userland to be operational. The error
recovery policy should be buildable in the driver. If it's not, however,
then I agree that userland intervention is probably a good idea.

Note that on pSeries, we have no choice. On error, the slot is isolated.
So we can't let the driver continue anyway.

Ben.
  

