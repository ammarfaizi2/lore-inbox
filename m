Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267107AbUBMQow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267114AbUBMQow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:44:52 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:40088 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S267107AbUBMQou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:44:50 -0500
Subject: Re: dm core patches
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 13 Feb 2004 11:44:41 -0500
Message-Id: <1076690681.2158.54.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The mechanism is in place, but the SCSI stack still needs a few changes
> to pass down the correct errors. The easiest would be to pass down
> pseudo-sense keys (I'd rather just call them something else as not to
> confuse things, io error hints or something) to
> end_that_request_first(), changing uptodate from a bool to a hint.

Yes, I'm ready to do this in SCSI.  I think the uptodate field should
include at least two (and possibly three) failure type indications:

- fatal: error cannot be retried
- retryable: error may be retried

and possibly

- informational: This is dangerous, since it's giving information about
a transaction that actually succeeded (i.e. we'd need to fix drivers to
recognise it as being uptodate but with info, like sector remapped)

Then, we also have a error origin indication:

- device: The device is actually reporting the problem
- transport: the error is a transport error
- driver: the error comes from the device driver.

So dm would know that fatal transport or driver errors could be
repathed, but fatal device errors probably couldn't.

Any that I've missed?

James

