Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264975AbTFSMJs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265223AbTFSMJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:09:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37521 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264975AbTFSMJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:09:45 -0400
Date: Thu, 19 Jun 2003 14:20:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Andy Polyakov <appro@fy.chalmers.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Regarding drivers/ide/ide-cd.c in 2.5.72
Message-ID: <20030619122010.GL6445@suse.de>
References: <3EEF8E2E.5E14946E@fy.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EEF8E2E.5E14946E@fy.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 17 2003, Andy Polyakov wrote:
> Hi,
> 
> I have brought this issue once already in 2.5.70 context (see uppermost
> post in http://marc.theaimsgroup.com/?t=105410790500005&r=1&w=2), but it
> apparently slipped through. So I've decided to bring it up again, this
> time describing [hopefully] better how does this *generic* problem with
> ide-cd.c manifests itself. In the nutshell the problem is that [as it is
> now] every failed SG_IO request is replayed second time without data
> transfer. E.g. if WRITE(10) SCSI command fails with sense code X, ide-cd
> immediately resends the command block descriptor one more time, this time
> without programming for any associated I/O payload, which [normally]
> results in *different* sense code. And the catch is that user-land gets
> this second sense code instead of the real/original one. Suggested patch
> overcomes this problem by immediately purging the failed SG_IO request
> from the request queue.

Patch looks fine, care to resend actually trying to follow the style in
the file in question?

-- 
Jens Axboe

