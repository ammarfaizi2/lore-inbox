Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUDSVyb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUDSVyb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 17:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUDSVyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 17:54:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43432 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261914AbUDSVy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 17:54:29 -0400
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040416223548.GA27540@mail.shareable.org>
References: <1080771361.1991.73.camel@sisko.scot.redhat.com>
	 <20040416223548.GA27540@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1082411657.2237.128.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Apr 2004 22:54:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2004-04-16 at 23:35, Jamie Lokier wrote:
> Stephen C. Tweedie wrote:
> > I've been looking at a discrepancy between msync() behaviour on 2.4.9
> > and newer 2.4 kernels, and it looks like things changed again in
> > 2.5.68.
> 
> When you say a discrepancy between 2.4.9 and newer 2.4 kernels, do you
> mean that the msync() behaviour changed during the 2.4 series?

Yes.

> If so, what was the change?

2.4.9 behaved like current 2.6 --- on MS_ASYNC, it did a
set_page_dirty() which means the page will get picked up by the next
5-second bdflush pass.  But later 2.4 kernels were changed so that they
started MS_ASYNC IO immediately with filemap_fdatasync() (which is
asynchronous regarding the new IO, but which blocks synchronously if
there is already old IO in flight on the page.)

That was reverted back to the earlier, 2.4.9 behaviour in the 2.5
series.

Cheers,
 Stephen

