Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTJMLvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 07:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbTJMLvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 07:51:55 -0400
Received: from holomorphy.com ([66.224.33.161]:52357 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261689AbTJMLvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 07:51:54 -0400
Date: Mon, 13 Oct 2003 04:54:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kk@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Invalidate_inodes can be very slow
Message-ID: <20031013115458.GI16158@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kk@sw.ru>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <200310131318.09234.kk@sw.ru> <20031013040821.19b3745e.akpm@osdl.org> <20031013111931.GH16158@holomorphy.com> <200310131545.01779.kk@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310131545.01779.kk@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> Generally dcache_lock stands in front of inode_lock, even with the
>> current hashtable RCU code. inode_lock has been seen before in unusual
>> situations I don't remember offhand, though generally it's not #1.
>> The workloads used for, say, benchmark testing don't adequately model
>> situations like what you just mentioned (or a number of other real-life
>> usage cases), so per-sb inode_lock may be worth considering on a priori
>> grounds, though it would probably be better to actually set something
>> up to test that scenario.

On Mon, Oct 13, 2003 at 03:45:01PM +0400, Kirill Korotaev wrote:
> This patch can be tested quite easily. Main changes are in invalidate_list.
> This path can be triggered by umount/quota off.
> So I tested it the following way:
> 1. mounting/working/umounting partition (and turning quota on/off)
> 2. running memeater to call prune_icache when partition was mounted
> to test that lists are ok.
> All other places should be ok, since simple list_add/list_del is inserted.

Sorry if I was unclear, I had in mind SMP performance testing of mount
and unmount -heavy workloads, like uni setups with many automounted fs's,
not stability testing per se.

-- wli
