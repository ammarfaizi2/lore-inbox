Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422662AbWBNTpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422662AbWBNTpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 14:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWBNTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 14:45:32 -0500
Received: from verein.lst.de ([213.95.11.210]:36306 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1422662AbWBNTpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 14:45:31 -0500
Date: Tue, 14 Feb 2006 20:45:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: use kthread_ API
Message-ID: <20060214194522.GA21385@lst.de>
References: <20060214175016.GA19080@lst.de> <20060214193713.GA9435@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214193713.GA9435@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 07:37:13PM +0000, Russell King wrote:
> On Tue, Feb 14, 2006 at 06:50:16PM +0100, Christoph Hellwig wrote:
> > Use the kthread_ API instead of opencoding lots of hairy code for kernel
> > thread creation and teardown.
> > 
> > Also use wake_up_process instead of an additional per-socket waitqueue.
> 
> Nack.  This breaks an error path - look at what happens when we fail to
> register a socket - we set socket->thread to NULL and exit.   That is
> then picked up by the "socket thread for socket %p did not start" code
> which you decided to remove.

Yes, you're right.  Let's drop the patch for now.
