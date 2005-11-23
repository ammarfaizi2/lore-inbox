Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbVKWFQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbVKWFQr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 00:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbVKWFQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 00:16:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:49881 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030186AbVKWFQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 00:16:46 -0500
Subject: Re: [PATCH] Fix USB suspend/resume crasher
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@cyclades.com
Cc: David Brownell <david-b@pacbell.net>, Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <1132715647.4707.8.camel@localhost>
References: <1132715288.26560.262.camel@gaston>
	 <1132715647.4707.8.camel@localhost>
Content-Type: text/plain
Date: Wed, 23 Nov 2005 16:13:16 +1100
Message-Id: <1132722797.26560.279.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sounds great. Maybe I'll finally be able to change my first question to
> people with suspend problems from: "Do you have USB built as modules and
> unloaded while suspending."

Heh, I don't know :) I haven't done anything to UHCI at this point, and
there are still other possible issues.

For example, we should probably do the "handoff" trick on resume as well
as on boot. In fact, I suspect that most PCI quirks should be re-run on
resume, with IRQs off if possible, so that stuffs can be put back into
some sane state when coming back from the BIOS before they get a chance
to spam the kernel with bogus IRQs left enabled by that same BIOS (does
this happen ?) or other niceties of that sort... I don't have any of
these problems on powermacs, but x86 might not be yet at the end of the
tunnel...

Ben.


