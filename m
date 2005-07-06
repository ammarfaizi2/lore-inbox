Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbVGFTs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVGFTs2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 15:48:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVGFTpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 15:45:32 -0400
Received: from nproxy.gmail.com ([64.233.182.193]:37057 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262320AbVGFOfN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 10:35:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ibd68mTvrv12ACrrXKdMe9Su777ZTn7ZSGgnsMJgCl22dZKVLIBZrPdVgTqIUHghTeBxFdnLYYgkr7KfSyLOmc9qsywn0ZOJ3abq0YnN6X31Msk3gYlbHP60qu/7NQV1C4+EhXJpBfuo47hhbP06kl9bhPfIFCIRDU7logTjuoc=
Message-ID: <58cb370e05070607351fe5eced@mail.gmail.com>
Date: Wed, 6 Jul 2005 16:35:11 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Fix crash on boot in kmalloc_node IDE changes
Cc: linux-ide@vger.kernel.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       christoph@lameter.com
In-Reply-To: <20050706140933.GH21330@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050706133052.GF21330@wotan.suse.de>
	 <58cb370e050706070512c93ee1@mail.gmail.com>
	 <20050706140933.GH21330@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/05, Andi Kleen <ak@suse.de> wrote:
> > drive->hwif check is redundant, please remove it
> 
> It's not. My first version didn't have it but it still crashed.
> It's what actually prevents the crash.
> I also don't know why, but it's true.

very weird as HWIF(drive) == drive->hwif:

	ide_hwif_t *hwif = HWIF(drive);

...

	q = blk_init_queue_node(do_ide_request, &ide_lock,
				pcibus_to_node(drive->hwif->pci_dev->bus));
	if (!q)
		return 1;

...

	if (!hwif->rqsize) {

you should OOPS here

Bartlomiej
