Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282958AbRK0Vb6>; Tue, 27 Nov 2001 16:31:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282967AbRK0Vbs>; Tue, 27 Nov 2001 16:31:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25617 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282958AbRK0Vbg>; Tue, 27 Nov 2001 16:31:36 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.1-pre2 does not compile
Date: Tue, 27 Nov 2001 20:50:09 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9u0ua1$1g2$1@penguin.transmeta.com>
In-Reply-To: <200111272044.fARKiTv13653@db0bm.ampr.org>
X-Trace: palladium.transmeta.com 1006894523 11003 127.0.0.1 (27 Nov 2001 20:55:23 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 27 Nov 2001 20:55:23 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200111272044.fARKiTv13653@db0bm.ampr.org>,
f5ibh  <f5ibh@db0bm.ampr.org> wrote:
>
>I've the following error :

Yes.

The next-generation block-layer support is starting to be merged into
the 2.5.x tree, and that breaks old drivers that haven't been updated to
the new locking.

In particular, there used to be _one_ lock for the whole IO system
("io_request_lock"), and these days it's a per-block-queue lock.

In many cases the fix is as simple as just replacing the
"io_request_lock" with "host->host_lock", but sometimes this is
complicated by the need to pass the right data structures down far
enough..

Many drivers have been converted (ie IDE, symbios, aic7xxx etc), but
many more have not (especially older SCSI drivers, in your case it's the
classic aha1542).

It will probably take some time until most drivers have been converted.
Tested patches are more than welcome,

		Linus
