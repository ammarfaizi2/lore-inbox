Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbVE0G6Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbVE0G6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 02:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVE0G6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 02:58:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:29405 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261913AbVE0G6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 02:58:19 -0400
Message-ID: <4296C505.2030806@pobox.com>
Date: Fri, 27 May 2005 02:58:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Mark Lord <liml@rtr.ca>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de> <42964498.9080909@rtr.ca> <20050527062802.GH1435@suse.de>
In-Reply-To: <20050527062802.GH1435@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Yeah, I'm not a huge fan of the need for the above code... If every qc
> was tied to a SCSI command, we could just ask for a later requeue of the
> request as is currently done with NCQ commands. Alternatively, we could
> add an internal libata qc queue for postponing these commands. That
> would take a little effort, as the sync errors reported by
> ata_qc_issue() would then be need to signalled async through the
> completion callback instead.
> 
> Jeff, what do you think?

Just use the SCSI layer for requeueing.  That's what I intended.

Every qc that matters can be requeued.  Just don't worry about 
non-queued, non-fast-path commands.  They are typically used in 
functions that will immediately notice a failure, and handle it accordingly.

	Jeff


