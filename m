Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265253AbSJaRGX>; Thu, 31 Oct 2002 12:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265251AbSJaRGT>; Thu, 31 Oct 2002 12:06:19 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:29450 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265250AbSJaRFh>; Thu, 31 Oct 2002 12:05:37 -0500
Date: Thu, 31 Oct 2002 17:12:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH]: reiser4 [5/8] export remove_from_page_cache()
Message-ID: <20021031171201.A11958@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <15809.21559.295852.205720@laputa.namesys.com> <20021031161826.A9747@infradead.org> <15809.22856.534975.384956@laputa.namesys.com> <20021031163104.A9845@infradead.org> <15809.24115.993132.576769@laputa.namesys.com> <20021031165819.A11604@infradead.org> <15809.25256.143498.726816@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15809.25256.143498.726816@laputa.namesys.com>; from Nikita@Namesys.COM on Thu, Oct 31, 2002 at 08:04:40PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 08:04:40PM +0300, Nikita Danilov wrote:
> Interesting. But things like ->vm_writeback() and friends will go
> directly to the page bypassing metapage wrapper, right?

Yes.

> JFS checks that
> page is still "live" on each low-level VM call?

Well, if the exntent in question doesn't exist anymore get_block()
will return a failure.  In practice that won't happen as those
pages still kept around are never dirty.
