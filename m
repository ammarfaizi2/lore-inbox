Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265106AbSJWR0R>; Wed, 23 Oct 2002 13:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSJWR0R>; Wed, 23 Oct 2002 13:26:17 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:22596 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S265106AbSJWR0Q>; Wed, 23 Oct 2002 13:26:16 -0400
Date: Wed, 23 Oct 2002 10:40:35 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, <lkcd-devel@lists.sourceforge.net>
Subject: Re: [PATCH] LKCD for 2.5.44 (6/8): dump trace/dump calls/dump_in_progress
In-Reply-To: <20021023180105.B16547@infradead.org>
Message-ID: <Pine.LNX.4.44.0210231023130.28800-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes -- I don't know how this didn't get picked up, this
was probably the result of the volatile->atomic_t->volatile
code changes.

The patch change should be:

 #ifdef CONFIG_SMP
    if (!dump_function_ptr) {
        smp_send_stop();
    }
 #endif

I'm copying the utils.patch file to the web site now:

	http://lkcd.sourceforge.net/download/latest/

--Matt

On Wed, 23 Oct 2002, Christoph Hellwig wrote:
|>On Wed, Oct 23, 2002 at 02:44:43AM -0700, Matt D. Robinson wrote:
|>> +#if !defined(CONFIG_CRASH_DUMP) && !defined(CONFIG_CRASH_DUMP_MODULE)
|>>  #ifdef CONFIG_SMP
|>>  	smp_send_stop();
|>>  #endif
|>> +#endif
|>
|>Again, is there a chance you could make this a runtime switch?
|>This would allow to poweroff dump-enabled kernel not configured for
|>dumping.
|>
|>-
|>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
|>the body of a message to majordomo@vger.kernel.org
|>More majordomo info at  http://vger.kernel.org/majordomo-info.html
|>Please read the FAQ at  http://www.tux.org/lkml/
|>

-- 

