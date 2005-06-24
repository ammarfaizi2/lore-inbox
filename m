Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263165AbVFXKND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbVFXKND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbVFXKND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:13:03 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20369 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263165AbVFXKMA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:12:00 -0400
Date: Fri, 24 Jun 2005 12:12:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP+irq handling broken in current git?
Message-ID: <20050624101242.GK8193@suse.de>
References: <20050623135318.GC9768@suse.de> <42BAEA67.7090606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BAEA67.7090606@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Hi,
> >
> >Something strange is going on with current git as of this morning (head
> >ee98689be1b054897ff17655008c3048fe88be94). On an old test box (dual p3
> >800MHz), using the same old config I always do on this box has very
> >broken interrupt handling:
> 
> Does 2.6.12 work for you?
> 2.6.11?
> 
> I noticed a few "2.6.12 is broken, 2.6.11 works" bug reports with 
> vaguely similar circumstances -- irq handling being a culprit.

To follow up on this on the list, the culprit appears to be the attached
string.h update introduced between -rc3 and -rc4. Backing it out makes
the kernel work, making it clobber memory (as suggested by Linus) makes
it work as well.

The failed test was in mpparse.c, it didn't recognise the pci bus.

-- 
Jens Axboe

