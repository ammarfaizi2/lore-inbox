Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVBUIUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVBUIUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbVBUIUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 03:20:51 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25730 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261916AbVBUIUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 03:20:46 -0500
Date: Mon, 21 Feb 2005 09:20:44 +0100
From: Jens Axboe <axboe@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cfq: depth 4 reached, tagging now on
Message-ID: <20050221082044.GW4056@suse.de>
References: <1108846748.10705.31.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108846748.10705.31.camel@krustophenia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19 2005, Lee Revell wrote:
> Starting around 2.6.11-rc4 I get this printk during the boot process
> after kjournald starts, and again if I stress the filesystem.
> 
> cfq: depth 4 reached, tagging now on
> 
> Is this printk intentional?  I am sure users will wonder about it,
> especially because (presumably) cfq turns tagging off at some point in
> between, and doesn't say anything about it.

It is intentional, but could be supressed. But I'm wondering if the
accounting change introduced a bug - what hardware are you using cfq on
(ie does it actually do tagged command queueing, is it SCSI?)?

It's a one-time message. CFQ starts out assuming the drive doesn't do
TCQ, if the driver depth goes beyond a defined limit (4), it will assume
that the hardware can do tagged queueing and change its internal
accounting accordingly. The setting stays that way, it's not a
transitional state.

-- 
Jens Axboe

