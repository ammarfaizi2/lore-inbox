Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVBVVXt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVBVVXt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbVBVVXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:23:48 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:12276 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261259AbVBVVXe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:23:34 -0500
Date: Tue, 22 Feb 2005 15:19:38 -0600
To: Jamie Lokier <jamie@shareable.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222211938.GB7079@austin.ibm.com>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222210752.GG22555@mail.shareable.org>
User-Agent: Mutt/1.5.6+20040523i
From: olof@austin.ibm.com (Olof Johansson)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2005 at 09:07:52PM +0000, Jamie Lokier wrote:
> 
> That won't work because the vma lock must be help between key
> calculation and get_user() - otherwise futex is not reliable.  It
> would work if the futex key calculation was inside the loop.

Sure, but that's still true: It's just that the get_user() is done twice
instead. The semaphore is never released between the key calculation and
the "real" get_user().

> A much simpler solution (and sorry for not offering it earlier,
> because Andrew Morton pointed out this bug long ago, but I was busy), is:

Either way works for me. Andrew/Linus, got a preference? I'll either
post my refresh based on Andrews comments, or code up Jamie's
suggestion.


-Olof
