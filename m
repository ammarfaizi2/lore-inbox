Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318062AbSIETBZ>; Thu, 5 Sep 2002 15:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318061AbSIETBY>; Thu, 5 Sep 2002 15:01:24 -0400
Received: from [195.223.140.120] ([195.223.140.120]:50032 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318047AbSIETBJ>; Thu, 5 Sep 2002 15:01:09 -0400
Date: Thu, 5 Sep 2002 21:06:00 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       lord@sgi.com
Subject: Re: 2.4.20pre5aa1
Message-ID: <20020905190600.GH1657@dualathlon.random>
References: <20020904233528.GA1238@dualathlon.random> <20020905134414.A1784@infradead.org> <20020905165307.GC1254@dualathlon.random> <20020905180904.A8406@infradead.org> <20020905184125.GA1657@dualathlon.random> <20020905194824.A11974@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020905194824.A11974@infradead.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 07:48:24PM +0100, Christoph Hellwig wrote:
> On Thu, Sep 05, 2002 at 08:41:25PM +0200, Andrea Arcangeli wrote:
> > other fs, if you're not holding the i_sem (and you certainly aren't
> > holding the i_sem that frequently, you don't even for writes).
> 
> Except of O_DIRECT writes we _do_ hold i_sem, btw.

can't you end with this?

					O_DIRECT write
					write finishes
	truncate drops the write
	truncate set i_sem to 0
					write set i_sem to something

and the fs is then corrupt? (very minor corruption of course and
extremely hard to trigger, trivially solvable by an fsck, ext[23] had
similar issues too with the get_block failures with < PAGE_SIZE
softblocksize, fixed around 2.4.19, that was certainly easier to
reproduce btw)

Andrea
