Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262992AbTCLAUm>; Tue, 11 Mar 2003 19:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262993AbTCLAUW>; Tue, 11 Mar 2003 19:20:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:34963 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262992AbTCLAUJ>;
	Tue, 11 Mar 2003 19:20:09 -0500
Date: Tue, 11 Mar 2003 16:25:52 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Free pages leaking in 2.5.64?
Message-Id: <20030311162552.7f78e764.akpm@digeo.com>
In-Reply-To: <1047376995.1692.23.camel@laptop-linux.cunninghams>
References: <1047376995.1692.23.camel@laptop-linux.cunninghams>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 00:30:45.0406 (UTC) FILETIME=[9F085BE0:01C2E82E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> wrote:
>
> Hi all.
> 
> I've come across the following problem in 2.5.64. Here's example output.
> The header is one page - all messages only have a single call to
> get_zeroed_page between the printings and the same code works as

nr_free_pages() does not account for the pages in the per-cpu head arrays. 

You can make the numbers look right via drain_local_pages(), but that is only
100% reliable on uniprocessor with interrupts disabled.

