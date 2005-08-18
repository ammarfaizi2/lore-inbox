Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbVHRNN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbVHRNN1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 09:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbVHRNN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 09:13:27 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:29113 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932209AbVHRNN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 09:13:27 -0400
Date: Thu, 18 Aug 2005 15:13:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zero-copy read() interface
Message-ID: <20050818131327.GA21830@wohnheim.fh-wedel.de>
References: <20050818100151.GF12313@vanheusden.com> <20050818100536.GB16751@wohnheim.fh-wedel.de> <20050818104131.GH12313@vanheusden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050818104131.GH12313@vanheusden.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 August 2005 12:41:32 +0200, Folkert van Heusden wrote:
>
> > Just use mmap().  Unlike your proposal, it cooperates with the page
> > cache.
> 
> Doesn't that one also use copying? I've also heard that using mmap is
> expensive due to pagefaulting. I've found, for example, that copying a
> 1.3GB file using read/write instead of mmap & memcpy is seconds faster.

Since you don't consider device DMA to be a copy, no, it doesn't.  The
data is transferred into page cache, then the pages are mapped into
your processes memory without an additional copy.

The pagefaulting isn't free either, I agree.  And for streaming
accesses like your copy of a large file, taking one fault per 4k
copied is not an ideal case.

Most likely you'd want Linus' pipe stuff for copying a large file
without ever looking at the data.  That work is still unfinished,
though, and I'm currently lacking time to work on it.

Jörn

-- 
He that composes himself is wiser than he that composes a book.
-- B. Franklin
