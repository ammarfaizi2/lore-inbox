Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUBVCgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUBVCgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:36:40 -0500
Received: from uslink-66.173.43-133.uslink.net ([66.173.43.133]:51840 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S261642AbUBVCgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:36:38 -0500
Date: Sat, 21 Feb 2004 18:36:38 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
Message-ID: <20040222023638.GA13840@dingdong.cryptoapps.com>
References: <4037FCDA.4060501@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4037FCDA.4060501@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 04:50:34PM -0800, Mike Fedyk wrote:

> I have 1.5 GB of ram in this system that will be a Linux Terminal
> Server (but using Debian & VNC).  There's 600MB+ anonymous memory,
> 600MB+ slab cache, and 100MB page cache.  That's after turning off
> swap (it was 400MB into swap at the time).

I have a similar annoying problem...  I have a machine which is almost
always idle (single user work station type thing) with 1.5GB of RAM
and I end up with 850M in slab!

For me the main problem seems to be driven by dentry_cache itself
bloating up really big and those entries keep fs-specific memory
pinned.

Forcing paging will push this down to acceptable levels but it's a
really irritating solution --- I'm still trying to think of a better
way to stop the dentries from using such a disproportionate amount of
memory.

I'm played with -mm kernels and various patches out there...  nothing
seems to put enough pressure on the slab unless I force paging.

akpm, riel --- any (more) ideas here?


