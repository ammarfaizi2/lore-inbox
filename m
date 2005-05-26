Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVEZOb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVEZOb0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVEZOb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 10:31:26 -0400
Received: from [81.2.110.250] ([81.2.110.250]:8113 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261487AbVEZObU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 10:31:20 -0400
Subject: Re: ide-cd vs. DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: karim@opersys.com, Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1116905090.4992.7.camel@gaston>
References: <1116891772.30513.6.camel@gaston> <42929F2F.8000101@opersys.com>
	 <1116905090.4992.7.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117117746.5744.152.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 26 May 2005 15:29:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-05-24 at 04:24, Benjamin Herrenschmidt wrote:
> Well, not sure what's wrong here, but ATAPI errors shouldn't normally
> result in stopping DMA. We may want to just blacklist your drive rather
> than having this stupid fallback. In this case, I suspect it's
> CSS/region issue with a DVD.

The fallback should only be triggering on a DMA CRC error. Turning DMA
off or using ide-scsi works (as generally does using the -ac kernel
tree) because that handles partial completions correctly while readahead
caused errors break the base ide-cd driver badly.

I would suggest avoiding the ide-cd driver in the base kernel for most
purposes, at least until that bug and the "rmmod cache flush" bug are
fixed.

Alan

