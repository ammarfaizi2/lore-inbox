Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbVLTVrY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbVLTVrY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbVLTVrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:47:24 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:46730 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S932141AbVLTVrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:47:23 -0500
Date: Tue, 20 Dec 2005 16:46:59 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH rc6] block: Fix CDROMEJECT to work in more cases
In-reply-to: <20051220205306.GS3734@suse.de>
To: Jens Axboe <axboe@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1135115219.16754.41.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20051219195014.GA13578@swissdisk.com>
 <Pine.LNX.4.64.0512200930490.4827@g5.osdl.org> <20051220174948.GP3734@suse.de>
 <Pine.LNX.4.64.0512201005370.4827@g5.osdl.org>
 <1135111130.16754.23.camel@localhost.localdomain>
 <20051220205306.GS3734@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-20 at 21:53 +0100, Jens Axboe wrote:
> On Tue, Dec 20 2005, Ben Collins wrote:
> > However, I don't see the issue with using READ. We know this isn't a
> > write operation, we are sending a single command with no data. I know
> > you say reads are precious, but 3 requests for something that isn't
> > going to happen very often doesn't seem that bad.
> 
> It's not a READ either!
> 
> Yes I'm being stubborn, but my point stands. I'm not changing something
> that is perfectly valid, "just because". If it finds a bug (you
> mentioned ide-cd, I still want the details on that when you have the
> time), then it's all for the better since it would bite us for other
> paths as well.
> 
> In summary - it's not a bug, it doesn't need fixing.

Then for the sake of nothing other than consistency, fix sg_io() to use
WRITE for cases where data_len==0? That means it would use READ only
when data is actually being read, and WRITE for everything else,
including all zero data commands (sounds sort of backwards to me,
though). Currently, it does the opposite. The main point being that
sending these commands from SG_IO ioctl should be the same as they get
sent from CDROMEJECT ioctl.

I wonder how many bugs will pop up if you do that. Probably less now
that the scsi code is fixed.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

