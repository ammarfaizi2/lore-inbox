Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262759AbVCWEWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbVCWEWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbVCWEWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:22:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8321 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262759AbVCWEWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:22:38 -0500
Message-ID: <4240EEFF.8030703@pobox.com>
Date: Tue, 22 Mar 2005 23:22:23 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 04/08] scsi: remove meaningless volatile
 qualifiers from structure definitions
References: <20050323021335.960F95F8@htj.dyndns.org>	 <20050323021335.2655518E@htj.dyndns.org> <1111551327.5520.99.camel@mulgrave>
In-Reply-To: <1111551327.5520.99.camel@mulgrave>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Wed, 2005-03-23 at 11:14 +0900, Tejun Heo wrote:
> 
>>	scsi_device->device_busy, Scsi_Host->host_busy and
>>	->host_failed have volatile qualifiers, but the qualifiers
>>	don't serve any purpose.  Kill them.  While at it, protect
>>	->host_failed update in scsi_error for consistency and clarity.
> 
> 
> Well ... the data here is volatile so what you're advocating is a move
> away from a volatile variable model to a protected variable one ... did
> you audit all users of both of these to make sure we have protection on
> all of them?  It looks like the sata strategy handlers would still rely
> on the volatile data.

volatile is almost always (a) buggy, or (b) hiding bugs.  At the very 
least, barriers are usually needed.

Almost every case really wants to be inside a spinlock, or atomic_t, or 
similarly protected.

Specifically for SATA, I am making the presumption that SCSI is smart 
enough not to mess with host_failed until my error handler completes.

	Jeff


