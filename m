Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751990AbWCPCwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751990AbWCPCwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752006AbWCPCwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:52:37 -0500
Received: from mx.pathscale.com ([64.160.42.68]:8837 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751990AbWCPCwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:52:36 -0500
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <adaslpjt8rg.fsf@cisco.com>
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	 <ada4q27fban.fsf@cisco.com>
	 <1141948516.10693.55.camel@serpentine.pathscale.com>
	 <ada1wxbdv7a.fsf@cisco.com>
	 <1141949262.10693.69.camel@serpentine.pathscale.com>
	 <20060309163740.0b589ea4.akpm@osdl.org>
	 <1142470579.6994.78.camel@localhost.localdomain>
	 <ada3bhjuph2.fsf@cisco.com>
	 <1142475069.6994.114.camel@localhost.localdomain>
	 <adaslpjt8rg.fsf@cisco.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 18:52:59 -0800
Message-Id: <1142477579.6994.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 18:37 -0800, Roland Dreier wrote:
>     Roland> I think you should always be doing a get_page().
> 
>     Bryan> Yeah.  I think so too, but when I do it, I get an oops.
> 
> Hmm, looking at that oops might help debug your problem.

This is what it looks like when I always call get_page in my nopage
handler (after checking that the pfn is valid and pfn_to_page hasn't
given me junk).

Bad page state at free_hot_cold_page (in process 'mpi_hello', page ffff810002098af8)
flags:0x0100000000000404 mapping:0000000000000000 mapcount:0 count:0 (Not tainted)
Backtrace:

Call Trace:<ffffffff80169577>{bad_page+135} <ffffffff8016a743>{free_hot_cold_page+112}
       <ffffffff8016a839>{__pagevec_free+41} <ffffffff801710ba>{release_pages+331}
       <ffffffff8017fce9>{free_pages_and_swap_cache+125} <ffffffff80176953>{unmap_vmas+1186}
       <ffffffff80179a58>{exit_mmap+124} <ffffffff80139fe6>{mmput+37}
       <ffffffff8013f2d4>{do_exit+584} <ffffffff8013fdd1>{sys_exit_group+0}
       <ffffffff80149fd9>{get_signal_to_deliver+1594} <ffffffff8010f23a>{do_signal+116}
       <ffffffff8011017e>{retint_signal+61}
Trying to fix it up, but a reboot is needed


