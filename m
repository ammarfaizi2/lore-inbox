Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbVLLUCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbVLLUCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbVLLUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:02:05 -0500
Received: from api.pobox.com ([208.210.124.75]:65497 "EHLO thorn.pobox.com")
	by vger.kernel.org with ESMTP id S932192AbVLLUCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:02:03 -0500
Date: Mon, 12 Dec 2005 15:01:55 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Brian King <brking@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Jens Axboe <axboe@suse.de>,
       Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Memory corruption & SCSI in 2.6.15
Message-ID: <20051212200155.GC19599@localhost.localdomain>
References: <1134371606.6989.95.camel@gaston> <439DC9E4.6030508@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439DC9E4.6030508@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian King wrote:
> Benjamin Herrenschmidt wrote:
> >Hi !
> >
> >Current -git as of today (that is 2.6.15-rc5 + the batch of fixes Linus
> >pulled after his return) was dying in weird ways for me on POWER5. I had
> >the good idea to activate slab debugging, and I now see it detecting
> >slab corruption as soon as the IPR driver initializes.
> 
> Please try the attached patch. There appears to be a double free going on
> in the scsi scan code. There is a direct call to scsi_free_queue and then
> the following put_device calls the release function, which also frees
> the queue.

Tested against 2.6.15-rc5, seems to fix it, thanks.


Nathan
