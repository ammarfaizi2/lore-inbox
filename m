Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129253AbRBTKyJ>; Tue, 20 Feb 2001 05:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129650AbRBTKxs>; Tue, 20 Feb 2001 05:53:48 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:6193 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129246AbRBTKxo>; Tue, 20 Feb 2001 05:53:44 -0500
Date: Tue, 20 Feb 2001 05:53:33 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile64?
Message-ID: <20010220055333.S16592@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20010220015518.B12073@convergence.de> <20010220145123.A1609@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010220145123.A1609@metastasis.f00f.org>; from cw@f00f.org on Tue, Feb 20, 2001 at 02:51:24PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 02:51:24PM +1300, Chris Wedgwood wrote:
>     Why isn't there a sendfile64?
> 
> because nobody has implemented on -- arguably it's not needed; the
> different between:
> 
> 	sendfile64(...)
> 
> and
> 
> 	while(blah){
> 		sendfile( ... 1G or so ...)
> 	}
> 
> probably won't be detectable anyhow. I see no reason why sendfile64
> should be purely user-space (then again, I see no reason why not to
> extend the kernel API as is, but last time I tested it is was busted
> WRT signals so I would rather that be fixed before further
> proliferation there).

Wrong. sendfile takes a pointer to off_t, not loff_t, so you cannot replace
sendfile64 with multiple sendfile's if offset is non-NULL from userland.
It simply won't work properly on big files (no matter what size you transfer
at a time).

	Jakub
