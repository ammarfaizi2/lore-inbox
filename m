Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262448AbVESCqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262448AbVESCqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 22:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVESCqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 22:46:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:52705 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262448AbVESCqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 22:46:10 -0400
Date: Wed, 18 May 2005 19:47:57 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rik van Riel <riel@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
In-Reply-To: <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org>
 <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 May 2005, Rik van Riel wrote:
>
> On Wed, 18 May 2005, Linus Torvalds wrote:
> 
> > Why not just change the "addr >= len" test into "addr > len" and be done 
> > with it?
> 
> If you're fine with not catching dereferences of a struct
> member further than PAGE_SIZE into a struct when the struct
> pointer is NULL, sure ...

I'm certainly ok with that, especially since it should never be a problem
in practice (ie the virtual memory map getting so full that we even get to
these low allocations should be basically something that never happens
under normal load).

However, it would be good to have even the trivial patch tested. 
Especially since what it tries to fix is a total corner-case in the first 
place..

		Linus
