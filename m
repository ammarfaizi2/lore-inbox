Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbVBXJKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbVBXJKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVBXJKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:10:16 -0500
Received: from fire.osdl.org ([65.172.181.4]:40592 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261829AbVBXJKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:10:10 -0500
Date: Thu, 24 Feb 2005 01:09:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: hugh@veritas.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       rrebel@whenu.com, marcelo.tosatti@cyclades.com,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] A new entry for /proc
Message-Id: <20050224010947.774628f3.akpm@osdl.org>
In-Reply-To: <3f250c71050224003110e74704@mail.gmail.com>
References: <20050106202339.4f9ba479.akpm@osdl.org>
	<Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
	<3f250c710502220513179b606a@mail.gmail.com>
	<3f250c71050224003110e74704@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin <mauriciolin@gmail.com> wrote:
>
> You said that the old smaps version is not efficient because the way
>  it access each pte.

Nick is talking about changing the kenrel so that it "refcounts pagetable
pages".  I'm not sure why.

I assume that this means that each pte page's refcount will be incremented
by one for each instantiated pte.  If so, then /proc/pid/smaps can become a
lot more efficient.  Just add up the page refcounts on all the pte pages -
no need to walk the ptes themselves.

Maybe?
