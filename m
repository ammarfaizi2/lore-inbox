Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUCaOE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 09:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUCaOE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 09:04:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16101 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261860AbUCaOE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 09:04:26 -0500
Subject: Re: [PATCH] barrier patch set
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Chris Mason <mason@suse.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1080684797.3546.85.camel@watt.suse.com>
References: <20040319153554.GC2933@suse.de>
	 <200403201723.11906.bzolnier@elka.pw.edu.pl>
	 <1079800362.11062.280.camel@watt.suse.com>
	 <200403201805.26211.bzolnier@elka.pw.edu.pl>
	 <1080662685.1978.25.camel@sisko.scot.redhat.com>
	 <1080674384.3548.36.camel@watt.suse.com>
	 <1080683417.1978.53.camel@sisko.scot.redhat.com>
	 <1080684797.3546.85.camel@watt.suse.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1080741817.1991.34.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 Mar 2004 15:03:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2004-03-30 at 23:13, Chris Mason wrote:

> Most database benchmarks are done on scsi, and the blkdev_flush should
> be a noop there.  For IDE based database and mail server benchmarks, the
> results won't be pretty.  

Yep.  I'm really not too worried about big database benchmarks -- those
are very much special cases, using rather specialised storage setup
(SCSI or FC, striped over lots of small disks rather than fewer large
ones.)  I'm much more concerned about your average LAMP user's mysql
database, and how to keep performance sane on that.

> The reiserfs fsync code tries hard to only flush once, so if a commit is
> done then blkdev_flush isn't called.  We might have to do a few other
> tricks to queue up multiple synchronous ios and only flush once.

Batching is really helpful when you've got lots of threads that can be
coalesced, yes.  ext3 does that for things like mail servers.  I'm not
sure whether the same tricks will apply to the various databases out
there, though.

--Stephen

