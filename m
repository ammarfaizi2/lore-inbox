Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWGZKEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWGZKEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWGZKEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:04:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34195 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751173AbWGZKEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:04:32 -0400
Date: Wed, 26 Jul 2006 11:04:31 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
Message-ID: <20060726100431.GA7518@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	lkml <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Ulrich Drepper <drepper@redhat.com>,
	netdev <netdev@vger.kernel.org>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11539054952574@2ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 01:18:15PM +0400, Evgeniy Polyakov wrote:
> 
> This patch includes asynchronous propagation of file's data into VFS
> cache and aio_sendfile() implementation.
> Network aio_sendfile() works lazily - it asynchronously populates pages
> into the VFS cache (which can be used for various tricks with adaptive
> readahead) and then uses usual ->sendfile() callback.

And please don't base this on sendfile.  Please make the splice infrastructure
aynschronous without duplicating all the code but rather make the existing
code aynch and the existing synchronous call wait on them to finish, similar
to how we handle async/sync direct I/O.  And to be honest, I don't think
adding all this code is acceptable if it can't replace the existing aio
code while keeping the interface.  So while you interface looks pretty
sane the implementation needs a lot of work still :)

