Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269607AbUINSS2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269607AbUINSS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 14:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUINSNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 14:13:42 -0400
Received: from [69.28.190.101] ([69.28.190.101]:41694 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S269607AbUINSIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 14:08:06 -0400
Date: Tue, 14 Sep 2004 14:08:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: [PATCH] New QStor SATA/RAID Driver for 2.6.9-rc2
Message-ID: <20040914180805.GA20760@havoc.gtf.org>
References: <41471163.10709@rtr.ca> <414723B0.1090600@pobox.com> <41472FA0.2090108@rtr.ca> <414730D9.3000003@pobox.com> <41473270.3070405@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41473270.3070405@rtr.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 02:03:28PM -0400, Mark Lord wrote:
> It looks to me as if the eh code prevents further queuecommand()
> calls while the LLD *_reset_handler() code is running.
> I wonder if it also does so for the eh_strategy_handler() ?

Yes, it definitely does, by definition:

SCSI's fine-grained eh hooks are called inside scsi_unjam_host(),
which is the default ->eh_strategy_handler.

	Jeff



