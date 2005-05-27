Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVE0HWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVE0HWl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVE0HW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:22:28 -0400
Received: from brick.kernel.dk ([62.242.22.158]:31930 "EHLO
	nelson.home.kernel.dk") by vger.kernel.org with ESMTP
	id S261724AbVE0HTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:19:50 -0400
Date: Fri, 27 May 2005 09:20:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
Message-ID: <20050527072046.GN1435@suse.de>
References: <20050526140058.GR1419@suse.de> <4295F87B.9070106@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4295F87B.9070106@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26 2005, Jeff Garzik wrote:
> >+	return 0;
> >+}
> >+
> >+/**
> >  *	ata_bus_probe - Reset and probe ATA bus
> >  *	@ap: Bus to probe
> >  *
> >@@ -2753,6 +2830,16 @@
> > 	struct ata_port *ap = qc->ap;
> > 	unsigned int tag, do_clear = 0;
> > 
> >+	if (likely(qc->flags & ATA_QCFLAG_ACCOUNT)) {
> >+		if (qc->flags & ATA_QCFLAG_NCQ) {
> >+			assert(ap->ncq_depth);
> >+			ap->ncq_depth--;
> >+		} else {
> >+			assert(ap->depth);
> >+			ap->depth--;
> >+		}
> >+	}
> 
> why is this accounting conditional?

I double checked this. If you agree to move the setting of QCFLAG_ACTIVE
_after_ successful ap->ops->qc_issue(qc) and clear it _after_
__ata_qc_complete(qc) then I can just use that bit and kill
ATA_QCFLAG_ACCOUNT.

What do you think?

-- 
Jens Axboe

