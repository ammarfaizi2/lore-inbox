Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318014AbSIETWv>; Thu, 5 Sep 2002 15:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318086AbSIETWv>; Thu, 5 Sep 2002 15:22:51 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32519 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318014AbSIETWQ>; Thu, 5 Sep 2002 15:22:16 -0400
Date: Thu, 5 Sep 2002 20:26:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905202652.A13687@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	lord@sgi.com
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194824.A11974@infradead.org> <20020905190600.GH1657@dualathlon.random> <20020905201530.A12457@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020905201530.A12457@infradead.org>; from hch@infradead.org on Thu, Sep 05, 2002 at 08:15:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 08:15:30PM +0100, Christoph Hellwig wrote:
> Won't happen:
> 
> 
> 					O_DIRECT write starts
> 					+ takes XFS iolock exclusive
> 					- invalidates pagecache
> 					+ downgrades iolock to shared
> 					- perform write
> 
> 	xfs_setattr for truncate called
> 	+ takes XFS iolock shared

			^^^ exclusive ^^^

> 	  -> blocks
> 
> 					- write i_size to something
> 					+ releases iolock
> 	  -> gets woken
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
