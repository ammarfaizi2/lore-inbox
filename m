Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbTIKQRK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbTIKQRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:17:09 -0400
Received: from ns.suse.de ([195.135.220.2]:202 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261338AbTIKQRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:17:07 -0400
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 11 Sep 2003 18:17:02 +0200
In-Reply-To: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
Message-ID: <p73oexri9kx.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> There's a lot of drivers in the tree that allow you to access the device
> either via IO port space or IO mem space.  Here's some examples:

My gut feeling is to just fix the drivers to make this runtime switchable
and get rid of the compile time options.

This would help distributions (who normally want to build conservative
by default, but still allow the users easy tuning without recompilation) 
For that it would be nice if a standard module parameter or maybe 
sysfs option existed.

The overhead of checking for PIO vs mmio at runtime in the drivers
should be completely in the noise on any non ancient CPU (both MMIO
and PIO typically take hundreds or thousands of CPU cycles for the bus
access, having an dynamic function call or an if before that is makes
no difference at all)

-Andi 
