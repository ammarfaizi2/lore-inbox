Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262857AbUCJVnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbUCJVnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:43:16 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:4078 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262854AbUCJVkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:40:52 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH] backing dev unplugging
Date: Wed, 10 Mar 2004 21:40:50 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c2o212$4h0$1@news.cistron.nl>
References: <20040310124507.GU4949@suse.de> <20040310130046.2df24f0e.akpm@osdl.org> <20040310210207.GL15087@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1078954850 4640 62.216.29.200 (10 Mar 2004 21:40:50 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040310210207.GL15087@suse.de>,
Jens Axboe  <axboe@suse.de> wrote:
>On Wed, Mar 10 2004, Andrew Morton wrote:
>> Jens Axboe <axboe@suse.de> wrote:
>> >
>> > Here's a first cut at killing global plugging of block devices to reduce
>> > the nasty contention blk_plug_lock caused.
>> 
>> Shouldn't we take read_lock(&md->map_lock) in dm_table_unplug_all()?
>
>Ugh yes, we certainly should.

With the latest patches from Joe it would be more like

	map = dm_get_table(md);
	if (map) {
		dm_table_unplug_all(map);
		dm_table_put(map);
	}

No lock ranking issues, you just get a refcounted map (table, really).

Mike.

