Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbVCWPQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbVCWPQz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 10:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbVCWPQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 10:16:54 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:50816 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261619AbVCWPQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 10:16:50 -0500
Subject: Re: [PATCH scsi-misc-2.6 04/08] scsi: remove meaningless volatile
	qualifiers from structure definitions
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4240EEFF.8030703@pobox.com>
References: <20050323021335.960F95F8@htj.dyndns.org>
	 <20050323021335.2655518E@htj.dyndns.org>
	 <1111551327.5520.99.camel@mulgrave>  <4240EEFF.8030703@pobox.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 09:16:40 -0600
Message-Id: <1111591000.5441.14.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 23:22 -0500, Jeff Garzik wrote:
> volatile is almost always (a) buggy, or (b) hiding bugs.  At the very 
> least, barriers are usually needed.

The choice is either barrier or volatile usually.  volatile is nasty
primarily because it causes compiler pessimism in variable reloading.

> Almost every case really wants to be inside a spinlock, or atomic_t, or 
> similarly protected.

I know that's what I'm asking if an audit has been conducted for...to
replace the volatile, accesses have to be barrier protected.

> Specifically for SATA, I am making the presumption that SCSI is smart 
> enough not to mess with host_failed until my error handler completes.

Yes, that's a valid assumption ... and by the single threaded nature of
the error handler, always true.  However, the proposed patch wanted to
add a spinlock around the access in the scsi eh thread (the comment
stating for clarity).  Thus, the same change should be made in SATA for
consistency.

Since that change isn't in the patch, I was asking if all the users of
these variables had been audited for barriers instead ... since the
answer looks to be "no" to me.

James


