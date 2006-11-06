Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753218AbWKFQAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753218AbWKFQAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753283AbWKFQAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:00:45 -0500
Received: from brick.kernel.dk ([62.242.22.158]:47415 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1753218AbWKFQAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:00:44 -0500
Date: Mon, 6 Nov 2006 17:02:51 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Brent Baccala <cosine@freesoft.org>, linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061106160250.GY13555@kernel.dk>
References: <Pine.LNX.4.64.0611030311430.25096@debian.freesoft.org> <20061103122055.GE13555@kernel.dk> <Pine.LNX.4.64.0611031049120.7173@debian.freesoft.org> <20061103160212.GK13555@kernel.dk> <Pine.LNX.4.64.0611031214560.28100@debian.freesoft.org> <20061106104350.GR13555@kernel.dk> <454F5A59.8010309@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454F5A59.8010309@cfl.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Phillip Susi wrote:
> Jens Axboe wrote:
> >Yeah, I'm afraid so. We really should be returning EAGAIN or something
> >like that for the congested condition, though.
> 
> How would user mode know when it was safe to retry the request?

You could optimistically retry when you had reaped some completed
events, or use some controlled way of blocking for free request
notification. There are many ways, most of them share the fact that the
time between notification and new io_submit() may change the picture, in
which case you'd get EAGAIN once more.

The important bit is imho to make the blocking at least deterministic.
At some point you _have_ to block for resources, but it's not very
polite to be blocking for a considerable time indeterministically.

-- 
Jens Axboe

