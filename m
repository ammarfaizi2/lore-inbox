Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265736AbUBPQ6C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 11:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265740AbUBPQ6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 11:58:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2456 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265736AbUBPQ56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 11:57:58 -0500
Date: Mon, 16 Feb 2004 17:57:56 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: dm core patches
Message-ID: <20040216165756.GB18938@suse.de>
References: <1076690681.2158.54.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076690681.2158.54.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13 2004, James Bottomley wrote:
> > The mechanism is in place, but the SCSI stack still needs a few changes
> > to pass down the correct errors. The easiest would be to pass down
> > pseudo-sense keys (I'd rather just call them something else as not to
> > confuse things, io error hints or something) to
> > end_that_request_first(), changing uptodate from a bool to a hint.
> 
> Yes, I'm ready to do this in SCSI.  I think the uptodate field should
> include at least two (and possibly three) failure type indications:
> 
> - fatal: error cannot be retried
> - retryable: error may be retried
> 
> and possibly
> 
> - informational: This is dangerous, since it's giving information about
> a transaction that actually succeeded (i.e. we'd need to fix drivers to
> recognise it as being uptodate but with info, like sector remapped)
> 
> Then, we also have a error origin indication:
> 
> - device: The device is actually reporting the problem
> - transport: the error is a transport error
> - driver: the error comes from the device driver.
> 
> So dm would know that fatal transport or driver errors could be
> repathed, but fatal device errors probably couldn't.
> 
> Any that I've missed?

Nope, this looks pretty spot-on to me. I have to agree with Lars and
rather keep it simple and straight forward, than introduce shady
informational bits.

-- 
Jens Axboe

