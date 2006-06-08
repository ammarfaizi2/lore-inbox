Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWFHMKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWFHMKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 08:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964818AbWFHMKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 08:10:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41419 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964815AbWFHMKK (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 08:10:10 -0400
Date: Thu, 8 Jun 2006 13:10:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Jens Axboe <axboe@suse.de>, Hans Reiser <reiser@namesys.com>,
       Tom Vier <tmv@comcast.net>, Linux-Kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: [PATCH] updated reiser4 - reduced cpu usage for writes by writing  more than 4k at a time (has implications for generic write code and eventually  for the IO layer)
Message-ID: <20060608121006.GA8474@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>, Jens Axboe <axboe@suse.de>,
	Hans Reiser <reiser@namesys.com>, Tom Vier <tmv@comcast.net>,
	Linux-Kernel@Vger.Kernel.ORG,
	Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
	Reiserfs mail-list <Reiserfs-List@namesys.com>
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero> <44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de> <1149766000.6336.29.camel@tribesman.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149766000.6336.29.camel@tribesman.namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2006 at 03:26:40PM +0400, Vladimir V. Saveliev wrote:
> > > It may go to the kernel as a 64MB write, but VFS sends it to the FS as
> > > 64MB/4k separate 4k writes.
> > 
> > Nonsense, 
> 
> Hans refers to generic_file_write which does
> prepare_write
> copy_from_user
> commit_write
> for each page.

That's not really the vfs but the generic pagecache routines.  For some
filesystems (e.g. XFS) only reservations for delayed allocations are
performed in this path so it doesn't really matter.  For not so advanced
filesystems batching these calls would definitly be very helpful.  Patches
to get there are very welcome.

