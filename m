Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbWKBPF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWKBPF1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 10:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWKBPF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 10:05:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11695 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751247AbWKBPFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 10:05:25 -0500
Subject: Re: [PATCH 1/8] cciss: version number change
From: Arjan van de Ven <arjan@infradead.org>
To: "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>
Cc: Jens Axboe <jens.axboe@oracle.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20061102144623.GC16430@beardog.cca.cpqcorp.net>
References: <20061101214913.GA29928@beardog.cca.cpqcorp.net>
	 <20061102141045.GH13555@kernel.dk>
	 <20061102144623.GC16430@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 02 Nov 2006 16:05:14 +0100
Message-Id: <1162479914.14530.46.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 08:46 -0600, Mike Miller (OS Dev) wrote:
> On Thu, Nov 02, 2006 at 03:10:45PM +0100, Jens Axboe wrote:
> > On Wed, Nov 01 2006, Mike Miller (OS Dev) wrote:
> > > 
> > > PATCH 1/8
> > > 
> > > This patch changes the cciss version number to 3.6.14 to reflect the following
> > > functionality changes added by the rest of the set. They include:
> > 
> > Mike, only some of your patches appeared to go out, both in personal
> > mail and on the list.
> 
> I ran into some last minute issues so I stopped at 5. Still re-testing
> the others.
> This snippet seems to tbe the culprit.
> +               if (blk_queue_stopped(h->gendisk[curr_queue]->queue) ||
> +                   blk_queue_plugged(h->gendisk[curr_queue]->queue))
> +                       blk_start_queue(h->gendisk[curr_queue]->queue);
> 
> We're testing to see if the queue is stopped or plugged so we don't
> try to start am already running queue. Without the blk_queue_plugged
> test it hangs every time. We added blk_queue_plugged and the first tests
> seem to run ok. Then at the last minute something broke. Does this look
> ok to you?


it looks like a design mistake to me if a device driver needs to care
about a queue being plugged at all....


