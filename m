Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266120AbTBKALb>; Mon, 10 Feb 2003 19:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266250AbTBKALb>; Mon, 10 Feb 2003 19:11:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:52866 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266120AbTBKALa>;
	Mon, 10 Feb 2003 19:11:30 -0500
Date: Mon, 10 Feb 2003 16:20:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: dhowells@redhat.com, torvalds@transmeta.com, jgarzik@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: extra PG_* bits for page->flags
Message-Id: <20030210162018.385642f0.akpm@digeo.com>
In-Reply-To: <1044922034.4866.14.camel@laptop-linux.cunninghams>
References: <20459.1044874267@warthog.cambridge.redhat.com>
	<20030210151244.7e42d3fb.akpm@digeo.com>
	<1044922034.4866.14.camel@laptop-linux.cunninghams>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Feb 2003 00:21:10.0186 (UTC) FILETIME=[7A3200A0:01C2D163]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@clear.net.nz> wrote:
>
> On Tue, 2003-02-11 at 12:12, Andrew Morton wrote:
> > David Howells <dhowells@redhat.com> wrote:
> > >  (*) PG_journal
> > >  (*) PG_journalmark
> > 
> > Well.  If you new fs goes in then yes, we can spare those bits (just).
> 
> May I ask, how many bits do you consider available?

Too darn few, frankly.

> swsusp beta 18 (ie
> 2.4), which I'm beginning to port to 2.5, uses 4 bits during suspend &
> resume for various purposes. If I understand the code correctly, the
> zone flags use bits 24-31 (although there has been that thread saying
> they could use less bits). I see in the 2.5.60 patch bit 19 is now in
> use. Should I be using private, temporarily allocated bitmaps instead of
> the page flags, to ease the pressure? (Especially since the suspend code
> is not used in 'normal' operation anyway).

256 zones is fairly exorbitant.  I suspect the number of machines which have

a) more than 16 zones and 
b) CONFIG_SOFTWARE_SUSPEND

is zero. So you can always munch into the top eight bits.

PG_checked is supposed to be removed - I have not looked into that.  PG_slab
is fairly optional.

PG_highmem can go away.  (just use page_zone(page)->is_highmem)

I would dearly like to dump PG_reserved, but I doubt if I'll get onto that.
(thinks about what happens if you start a direct-io read from a soundcard DMA
buffer, and munmap/close while that is in progress...)

So.  There's not a lot of fat there, but we're not all out of options.


