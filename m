Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUABW2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUABW2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 17:28:41 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:128 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265592AbUABW2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 17:28:40 -0500
Subject: Re: JFS resize=0 problem in 2.6.0
From: Christophe Saout <christophe@saout.de>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Elliott Bennett <lkml@dhtns.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040102212417.GG1882@matchmail.com>
References: <20031228153028.GB22247@faraday.dhtns.com>
	 <20031229000503.GD1882@matchmail.com>
	 <20040102201221.GA28116@faraday.dhtns.com>
	 <20040102212417.GG1882@matchmail.com>
Content-Type: text/plain
Message-Id: <1073082525.28665.10.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 02 Jan 2004 23:28:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fr, den 02.01.2004 schrieb Mike Fedyk um 22:24:

> I would be careful of DM and MD RAID in 2.6.0.  There are some bugs flying
> around mentioning XFS->DM->MD RAID, , but also reproducable with Ext3->DM.
> 
> So if you're using DM, you might want to do some extra consistancy checks in
> your tests, and don't use it with important data.

Only DM or DM->RAID? There is one bug on bugzilla mentioning XFS
problems on a >2TB LVM volume dating back to 2.5.73. DM uses sector_t
everywhere, so perhaps it might be a different problem.

DM has a workaround included since one of the later test kernels so that
it should not break on top of the raid code. Also someone posted
bugfixes not too long ago that fixed some hard to trigger bugs with
bi_idx not always starting at zero (which should have affected raid and
dm code under rare circumstances). These bugfixes are in 2.6.1-pre1 I
think.

There is also one bug that isn't fixed in 2.6.0 (but in the -mm kernels
for some time and also in 2.6.1-pre1), it concerns online resizing of
mounted filesystems.

At least I think the core DM code should be safe under normal usage. I
bombed it with all kinds of BIOs, not only the page sized ones most
filesystems and swap code create, using an IDE disk. I'm using it on all
my systems for a long time now.

Elliot's problem is a different though, the jfs option parser doesn't do
what he wants. ;)


