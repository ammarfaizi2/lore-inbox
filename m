Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273867AbRIXOh2>; Mon, 24 Sep 2001 10:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273788AbRIXOhR>; Mon, 24 Sep 2001 10:37:17 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:61684 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273867AbRIXOhK>; Mon, 24 Sep 2001 10:37:10 -0400
Date: Mon, 24 Sep 2001 15:37:00 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>, linux-kernel@vger.kernel.org,
        tovarlds@transmeta.com, Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems, kupdated bugfixes
Message-ID: <20010924153700.B13817@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0109201445170.13543-100000@gamma.student.ljbc> <20010921152627.C13862@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921152627.C13862@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Fri, Sep 21, 2001 at 03:26:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 21, 2001 at 03:26:27PM +0200, Matthias Andree wrote:

> Be careful! MTAs rely on this behaviour on fsync(). The official
> consensus on ReiserFS and ext3 on current Linux 2.4.x kernels (x >= 9)
> is that "any synchronous operation flushes all pending operations", and
> if that is changed, you MUST make sure that the changed ReiserFS/ext3fs
> still make all the guarantees that softupdated BSD file systems make,
> lest you want people to run their mail queues off "sync" disks.

Reiserfs and ext3 have their own IO ordering --- they don't commit
transactions until the log writes for _all_ of the blocks in those
transactions have been acknowledged.  Reordering outstanding IOs won't
affect the fsync guarantees at all.

--Stephen
