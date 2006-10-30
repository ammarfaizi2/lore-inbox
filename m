Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWJ3SzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWJ3SzQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 13:55:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161362AbWJ3SzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 13:55:15 -0500
Received: from brick.kernel.dk ([62.242.22.158]:21534 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1161367AbWJ3SzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 13:55:11 -0500
Date: Mon, 30 Oct 2006 19:56:51 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Lord <liml@rtr.ca>,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, mingo@elte.hu
Subject: Re: 2.6.19-rc3-git7: scsi_device_unbusy: inconsistent lock state
Message-ID: <20061030185651.GK14055@kernel.dk>
References: <20061030154444.GH4563@kernel.dk> <1162225002.2948.45.camel@laptopd505.fenrus.org> <20061030162621.GK4563@kernel.dk> <1162225915.2948.49.camel@laptopd505.fenrus.org> <20061030175224.GB14055@kernel.dk> <45463C5B.7070900@rtr.ca> <45464064.2090108@rtr.ca> <20061030181645.GF14055@kernel.dk> <454644C1.4080702@rtr.ca> <1162233918.2948.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1162233918.2948.65.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Arjan van de Ven wrote:
> 
> > (gdb) l *cfq_set_request+0x33e
> > 0xc021780e is in cfq_set_request (block/cfq-iosched.c:1224).
> > 1219            if (unlikely(!cfqd))
> > 1220                    return;
> > 1221
> > 1222            spin_lock(cfqd->queue->queue_lock);
> 
> this looks interesting... and buggy ;)
> (this is changed_ioprio() )

Yeah it is, changed_ioprio() used to be called under local_irq_save(),
but it's not anymore.

-- 
Jens Axboe

