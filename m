Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUDUCKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUDUCKa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 22:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264286AbUDUCKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 22:10:30 -0400
Received: from mail.shareable.org ([81.29.64.88]:7333 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S264271AbUDUCKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 22:10:24 -0400
Date: Wed, 21 Apr 2004 03:10:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
Message-ID: <20040421021010.GC23621@mail.shareable.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com> <20040416223548.GA27540@mail.shareable.org> <1082411657.2237.128.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082411657.2237.128.camel@sisko.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> > If so, what was the change?
> 
> 2.4.9 behaved like current 2.6 --- on MS_ASYNC, it did a
> set_page_dirty() which means the page will get picked up by the next
> 5-second bdflush pass.  But later 2.4 kernels were changed so that they
> started MS_ASYNC IO immediately with filemap_fdatasync() (which is
> asynchronous regarding the new IO, but which blocks synchronously if
> there is already old IO in flight on the page.)
> 
> That was reverted back to the earlier, 2.4.9 behaviour in the 2.5
> series.

It was 2.5.68.

Thanks, that's very helpful.

msync(0) has always had behaviour consistent with the <=2.4.9 and
>=2.5.68 MS_ASYNC behaviour, is that right?

If so, programs may as well "#define MS_ASYNC 0" on Linux, to get well
defined and consistent behaviour.  It would be nice to change the
definition in libc to zero, but I don't think it's possible because
msync(MS_SYNC|MS_ASYNC) needs to fail.

-- Jamie
