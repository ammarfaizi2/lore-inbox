Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWB0AFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWB0AFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 19:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWB0AFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 19:05:40 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:22765
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1750814AbWB0AFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 19:05:39 -0500
Date: Sun, 26 Feb 2006 18:05:40 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Anders K. Pedersen" <akp@cohaesio.com>
Cc: Dave Olien <dmo@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Let DAC960 supply entropy to random pool
Message-ID: <20060227000540.GN4650@waste.org>
References: <1140713078.16199.25.camel@homer.cohaesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140713078.16199.25.camel@homer.cohaesio.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2006 at 05:44:38PM +0100, Anders K. Pedersen wrote:
> Hello,
> 
> We have a couple of servers with Mylex RAID controllers (handled by the
> DAC960 block device driver). There's normally no keyboard or mouse
> attached, and neither the DAC960 nor the NIC driver (e100) provides
> entropy to the random pool, so it was impossible to get any data from
> /dev/random.

Doesn't the add_disk_randomness call in ll_rw_blk.c suffice? This is
the proper path for disks to add entropy.

I intend to kill the SA_SAMPLE_RANDOM path. It's part of a fast path
and all of its users are bogus.

-- 
Mathematics is the supreme nostalgia of our time.
