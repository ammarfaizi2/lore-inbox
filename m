Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263292AbSJHT04>; Tue, 8 Oct 2002 15:26:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbSJHT0D>; Tue, 8 Oct 2002 15:26:03 -0400
Received: from packet.digeo.com ([12.110.80.53]:58087 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263292AbSJHTYt>;
	Tue, 8 Oct 2002 15:24:49 -0400
Message-ID: <3DA33250.FB61BAAE@digeo.com>
Date: Tue, 08 Oct 2002 12:30:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org,
       riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
References: <20021008190513.GA4728@tapu.f00f.org> <1034104637.29468.1483.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 19:30:24.0410 (UTC) FILETIME=[261117A0:01C26F01]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> ...
> 
> Andrew, any experience on one vs. the other?

I'd say that if you were designing a new application which
streams large amount of data then yes, you would design it
to use O_DIRECT.  You would instantiate a separate IO worker
thread and a message passing mechanism so that thread would
pump your data for you, and would peform your readahead, etc.

If your filesystem supports O_DIRECT, of course.  Not all do.

The strength of O_STREAMING is that you can take an existing,
working, megahuge application and make it play better with the
VM by changing a single line of code.  No big redesign needed.
