Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268588AbUILKLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268588AbUILKLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 06:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268591AbUILKLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 06:11:32 -0400
Received: from holomorphy.com ([207.189.100.168]:36484 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268588AbUILKKv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 06:10:51 -0400
Date: Sun, 12 Sep 2004 03:10:49 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: /proc/sys/kernel/pid_max issues
Message-ID: <20040912101049.GM2660@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org,
	mingo@elte.hu, viro@parcelfarce.linux.theplanet.co.uk
References: <20040912085609.GK32755@krispykreme> <20040912093605.GJ2660@holomorphy.com> <20040912095805.GL2660@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040912095805.GL2660@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 02:36:05AM -0700, William Lee Irwin III wrote:
>> +		if (map > &pidmap_array[pid_max/BITS_PER_PAGE])
>> +			map = pidmap_array;
>>  		if (unlikely(!map->page)) {
>>  			unsigned long page = get_zeroed_page(GFP_KERNEL);

On Sun, Sep 12, 2004 at 02:58:05AM -0700, William Lee Irwin III wrote:
> If pid_max == BITS_PER_PAGE*n, none of &pidmap_array[pid_max/BITS_PER_PAGE]
> is usable, so if we must complete a full revolution around pidmap_array[]
> to discover a free pid slightly less than last_pid we will miss it. Hence:

That could only happen if max_steps were initialized to PIDMAP_ENTRIES
instead of PIDMAP_ENTRIES + 1, so this more accurate upper bound is not
strictly necessary, though with this in place, we could probably reduce
max_steps to just PIDMAP_ENTRIES so we cycle no further than the block
we began; I'll not bother with that.


-- wli
