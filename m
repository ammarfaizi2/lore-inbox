Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbSIXV5C>; Tue, 24 Sep 2002 17:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbSIXV5C>; Tue, 24 Sep 2002 17:57:02 -0400
Received: from holomorphy.com ([66.224.33.161]:47260 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261815AbSIXV5C>;
	Tue, 24 Sep 2002 17:57:02 -0400
Date: Tue, 24 Sep 2002 15:01:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, mingo@elte.hu,
       davem@redhat.com, jgarzik@mandrakesoft.com, torvalds@transmeta.com
Subject: Re: on 2.5.38-mm2 tbench 64 smptimers shows 30% improvement
Message-ID: <20020924220123.GL6070@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	dipankar@in.ibm.com, mingo@elte.hu, davem@redhat.com,
	jgarzik@mandrakesoft.com, torvalds@transmeta.com
References: <20020924081340.GD6070@holomorphy.com> <20020924083606.GF6070@holomorphy.com> <3D90A378.C58157AA@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D90A378.C58157AA@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> 2.5.38-mm2-smptimers:
>> c01053dc 30936965 41.2616     poll_idle
>> c020ee62 30635964 40.8601     .text.lock.dev       <- what's this?
>> c0114c08 2499541  3.33371     load_balance
>> c01175db 2141278  2.85589     .text.lock.sched
>> c020ce40 2141045  2.85558     dev_queue_xmit
>> c013a47e 932681   1.24394     .text.lock.page_alloc

On Tue, Sep 24, 2002 at 10:40:08AM -0700, Andrew Morton wrote:
> queue lock for the loopback device?

Yeah. I did some fishing around last time I ran smptimers benchmarks
and found (to everyone's surprise) it was the queue lock and not the
xmit lock, or at least as far as my reading of the disassembly went.

Busywait time was reduced from 80% to 45%, which is good.


Cheers,
Bill
