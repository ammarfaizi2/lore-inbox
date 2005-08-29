Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbVH2Gka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbVH2Gka (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 02:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVH2Gka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 02:40:30 -0400
Received: from ozlabs.org ([203.10.76.45]:9871 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751075AbVH2Gk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 02:40:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17170.44500.848623.139474@cargo.ozlabs.ibm.com>
Date: Mon, 29 Aug 2005 16:40:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 8/8] PCI Error Recovery: PPC64 core recovery routines
In-Reply-To: <20050825161325.GG25174@austin.ibm.com>
References: <20050823231817.829359000@bilge>
	<20050823232143.003048000@bilge>
	<20050823234747.GI18113@austin.ibm.com>
	<1124898331.24668.33.camel@sinatra.austin.ibm.com>
	<20050824162959.GC25174@austin.ibm.com>
	<17165.3205.505386.187453@cargo.ozlabs.ibm.com>
	<20050825161325.GG25174@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas writes:

> Actually, no.  There are three issues:
> 1) hotplug routines are called from within kernel. GregKH has stated on
>    multiple occasions that doing this is wrong/bad/evil. This includes
>    calling hot-unplug.
> 
> 2) As a result, the code to call hot-unplug is a bit messy. In
>    particular, there's a bit of hoop-jumping when hotplug is built as
>    as a module (and said hoops were wrecked recently when I moved the
>    code around, out of the rpaphp directory).

One way to clean this up would be to make rpaphp the driver for the
EADS bridges (from the pci code's point of view).  Then it would
automatically get included in the error recovery process and could do
whatever it should.

> 3) Hot-unplug causes scripts to run in user-space. There is no way to 
>    know when these scripts are done, so its not clear if we've waited
>    long enough before calling hot-add (or if waiting is even necessary).

OK, so let's just add a new hotplug event called KOBJ_ERROR or
something, which tells userspace that an error has occurred which has
made the device inaccessible.  Greg, would that be OK?

The only trouble with that is that if we don't have a hotplug bridge
driver loaded for the slot, we can't tell the driver that its device
has gone away.  I guess that's not a big problem in practice.

Paul.
