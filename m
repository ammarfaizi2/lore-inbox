Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130906AbRCFDmm>; Mon, 5 Mar 2001 22:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130908AbRCFDmd>; Mon, 5 Mar 2001 22:42:33 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:37133 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130906AbRCFDmV>; Mon, 5 Mar 2001 22:42:21 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: Linux 2.4.3
Date: 5 Mar 2001 19:42:10 -0800
Organization: Transmeta Corporation
Message-ID: <981mai$e19$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.21.0103052124250.1132-100000@groveland.analogic.com>,
Richard B. Johnson <johnson@groveland.analogic.com> wrote:
>
>I   -- S T R O N G L Y -- suggest that nobody use this kernel with
>a BusLogic SCSI controller until this problem is fixed.

Ho humm..

Anybody who has any ideas or input, please holler.  There are no actual
BusLogic controller changes in the current 2.4.3-pre kernels at all, so
there's something else going on.

There's a new aic7xxx driver there - did you enable support for that? I
wonder if there could be some inter-action: the aic7xxx driver tries to
probe every PCI SCSI controller because they are basically hard to ID
any other way (no single vendor/id combination, or even a simple
pattern).  But it has some rather careful internal logic to filter out
all non-aic7xxx controllers, so this really doesn't look likely.

If you didn't compile aic7xxx in, the only other SCSI change (apart from
a lot of spelling fixes in comments etc) is some trivial error handling,
like changing scsi_test_unit_ready to not have a result buffer (because
it doesn't have a result except for the regular sense buffer).  Which
again certainly shouldn't be able to matter at all. 

Ideas?

		Linus
