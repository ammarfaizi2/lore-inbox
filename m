Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314285AbSEXJqW>; Fri, 24 May 2002 05:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317080AbSEXJqV>; Fri, 24 May 2002 05:46:21 -0400
Received: from holomorphy.com ([66.224.33.161]:23964 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S314285AbSEXJqU>;
	Fri, 24 May 2002 05:46:20 -0400
Date: Fri, 24 May 2002 02:46:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
        "chen, xiangping" <chen_xiangping@emc.com>
Subject: Re: Poor read performance when sequential write presents
Message-ID: <20020524094606.GH14918@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Giuliano Pochini <pochini@shiny.it>, linux-kernel@vger.kernel.org,
	"chen, xiangping" <chen_xiangping@emc.com>
In-Reply-To: <3CED4843.2783B568@zip.com.au> <XFMail.20020524105942.pochini@shiny.it> <3CEE0758.27110CAD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 02:26:48AM -0700, Andrew Morton wrote:
> Oh absolutely.   That's the reason why 2.4 is beating 2.5 at tiobench with
> more than one thread.  2.5 is alternating fairly between threads and 2.4
> is not.  So 2.4 seeks less.

In one sense or another some sort of graceful transition to unfair
behavior could be considered a kind of thrashing control; how meaningful
that is in the context of disk I/O is a question I can't answer directly,
though. Do you have any comments on this potential strategic unfairness?


On Fri, May 24, 2002 at 02:26:48AM -0700, Andrew Morton wrote:
> I've been testing this extensively on 2.5 + multipage BIO I/O and when you
> increase readahead from 32 pages (two BIOs) to 64 pages (4 BIOs), 2.5 goes
> from perfect to horrid - each threads grabs the disk head and performs many,
> many megabytes of read before any other thread gets a share.  Net effect is
> that the tiobench numbers are great, but any operation which involves
> reading disk has 30 or 60 second latencies.
> Interestingly, it seems specific to IDE.  SCSI behaves well.
> I have tons of traces and debug code - I'll bug Jens about this in a week or
> so.

What kinds of phenomena appear to be associated with IDE's latencies?
I recall some comments from prior IDE maintainers on poor interactions
between generic disk I/O layers and IDE drivers, particularly with
respect to small transactions being given to the drivers to perform.
Are these comments still relevant, or is this of a different nature?


Cheers,
Bill
