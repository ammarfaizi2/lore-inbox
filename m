Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTAXTz4>; Fri, 24 Jan 2003 14:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265008AbTAXTz4>; Fri, 24 Jan 2003 14:55:56 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5088 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264925AbTAXTzy>;
	Fri, 24 Jan 2003 14:55:54 -0500
Date: Fri, 24 Jan 2003 21:04:34 +0100
From: Jens Axboe <axboe@suse.de>
To: Valdis.Kletnieks@vt.edu, Nick Piggin <piggin@cyberone.com.au>
Cc: Giuliano Pochini <pochini@shiny.it>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, linux-kernel@alex.org.uk,
       Alex Tomas <bzzz@tmi.comex.ru>, Andrew Morton <akpm@digeo.com>,
       Oliver Xymoron <oxymoron@waste.org>
Subject: Re: 2.5.59-mm5
Message-ID: <20030124200434.GD889@suse.de>
References: <XFMail.20030124180942.pochini@shiny.it> <3E31765F.4010900@cyberone.com.au> <200301241934.h0OJYf0V005773@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301241934.h0OJYf0V005773@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24 2003, Valdis.Kletnieks@vt.edu wrote:
> On Sat, 25 Jan 2003 04:22:39 +1100, Nick Piggin said:
> > We probably wouldn't want to go that far as you obviously can
> > only merge reads with reads and writes with writes, a flag would
> > be fine. We have to get the basics working first though ;)
> 
> "obviously can only"?  Admittedly, merging reads and writes is a lot
> trickier, and probably "too hairy to bother", but I'm not aware of a
> fundamental "cant" that applies across IDE/SCSI/USB/1394/fiberchannel/etc.

Nicks comment refers to the block layer situation, we obviously cannot
merge reads and writes there. You would basically have to rewrite the
entire request submission structure and break all drivers. And for zero
benefit. Face it, it would be stupid to even attempt such a manuever.

Since you bring it up, you must know if a device which can take a single
command that says "read blocks a to b, and write blocks x to z"? Even if
such a thing existed, it would be much better implemented by the driver
as pulling more requests of the queue and constructing these weirdo
commands itself. Something as ugly as that would never invade the Linux
block layer, at least not as long as I have any input on the design of
it.

So I quite agree with the "obviously".

-- 
Jens Axboe

