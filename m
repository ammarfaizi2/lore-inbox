Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbTH0OoO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263410AbTH0OoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:44:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:39948 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263418AbTH0On6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:43:58 -0400
Date: Wed, 27 Aug 2003 14:45:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: Strange memory usage reporting
In-Reply-To: <20030827095241.D639@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.44.0308271430150.1269-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Ingo Oeser wrote:
> On Tue, Aug 26, 2003 at 06:03:14PM +0100, Hugh Dickins wrote:
> > Which is the driver involved?  Though it's not wrong to give do_no_page
> > a Reserved page, beware of the the page->count accounting: while it's
> > Reserved, get_page or page_cache_get raises the count, but put_page
> > or page_cache_release does not decrement it - very easy to end up
> > with the page never freed.
> 
> Why is this so asymetric? I would understand ignoring these pages
> in the freeing logic, but why exclude them also from refcounting?

I don't think there's a _good_ reason, it just evolved that way.

The real answer is to get rid of PageReserved completely, which
I'll embark on again in 2.7 (I did start a couple of times in 2.5,
but each time it was too late).

There was a halfway-house suggestion in 2.5 about three months ago,
inspired (as usual) by Reserved page problems in AIO's get_user_pages,
to do as you suggest: submit them to normal refcounting.  I don't
know what became of that, I didn't have much time to get involved.

Hugh

