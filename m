Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbWDYO1D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWDYO1D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbWDYO1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:27:03 -0400
Received: from pat.uio.no ([129.240.10.6]:949 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932224AbWDYO1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:27:01 -0400
Subject: Re: question about nfs_execute_read: why do we need to do
	lock_kernel?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
References: <4ae3c140604242157k26f39f71qcf6eed811f1e2d8@mail.gmail.com>
	 <1145941743.8164.6.camel@lade.trondhjem.org>
	 <4ae3c140604250708w438545c1lfa66233fdaa63cc@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 10:26:49 -0400
Message-Id: <1145975209.8193.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.129, required 12,
	autolearn=disabled, AWL 1.68, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 10:08 -0400, Xin Zhao wrote:
> Thanks for your reply. So the only reason is for rpc auditing? If so,
> why not just lock the code that updating the audit information? Now
> the code is:

No. You misunderstood me.

I said that we need to audit the _code_ for races.

In the distant past, the rpc code was entirely protected by the BKL
against concurrent access to shared objects (queues, structures,
variables etc). Today, most of those shared objects have been given
their own locks, but nobody has yet gone through the code line by line
in order to check that it is safe to remove the BKL.

Cheers,
 Trond

