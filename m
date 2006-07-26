Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWGZKaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWGZKaF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWGZKaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:30:05 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:44427 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932097AbWGZKaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:30:03 -0400
Date: Wed, 26 Jul 2006 11:30:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
Message-ID: <20060726103001.GA10139@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>,
	netdev <netdev@vger.kernel.org>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru> <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726101919.GB2715@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 02:19:21PM +0400, Evgeniy Polyakov wrote:
> I stopped to work on AIO, since neither existing, nor mine
> implementation were able to outperform sync speeds (one of the major problems
> in my implementation is get_user_pages() overhead, which can be
> completely eliminated with physical memory allocation being done in
> advance in userspace, like Ulrich described).
> My personal opinion on existing AIO is that it is not the right design.
> Benjamin LaHaise agree with me (if I understood him right),

I completely agree with that aswell.

> but he
> failed to move AIO outside repeated-call model (2.4 had state machine
> based one, and out-of-the tree 2.6 patches have that design too).
> In theory existing AIO (with all posix userspace API) can be replaced
> with kevent (it will even take less space), but I would present it as a
> TODO item, since kevent itself has nothing to do with AIO.

And replacing the existing aio code is exactly we I want you to do.  We
can't keep adding more and more code without getting rid of old mess forever.

And yes, the asynchronous pagecache population bit in your patchkit has a lot
to do with aio.  It's same variant of aio done right (or at least less bad).

I suspect the right way to go ahead is to drop that bit for now (it's the
by far worst code in the patchkit anyway) and then we can redo it later to
not get abstractions wrong and duplicate lots of code but also replace the
aio code.  I don't expect you to do that alone, you'll probably need quite
a bit help from us FS and VM people.
