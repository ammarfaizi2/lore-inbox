Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVDLAWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVDLAWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 20:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDLAWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 20:22:51 -0400
Received: from webmail.topspin.com ([12.162.17.3]:44483 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261725AbVDLAWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 20:22:48 -0400
To: Andrew Morton <akpm@osdl.org>, libor@topspin.com
Cc: hozer@hozed.org, linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 11 Apr 2005 17:21:04 -0700
In-Reply-To: <20050411171347.7e05859f.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 11 Apr 2005 17:13:47 -0700")
Message-ID: <521x9gyhe7.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 12 Apr 2005 00:21:04.0866 (UTC) FILETIME=[83C67C20:01C53EF5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> Yes, because the kernel may go through and unmap pages
    Roland> from userspace while trying to swap.  Since we have the
    Roland> page locked in the kernel, the physical page won't go
    Roland> anywhere, but userspace might end up with a different page
    Roland> mapped at the same virtual address.

    Andrew> That shouldn't happen.  If get_user_pages() has elevated
    Andrew> the refcount on a page then the following can happen:

    ...

    Andrew> IOW: while the page has an elevated refcount from
    Andrew> get_user_pages(), that physical page is 100% pinned.
    Andrew> Once you've done the set_page_dirty+put_page(), the page
    Andrew> is again under control of the VM.

Hmm... I've never tested it first hand but Libor assures me there is a
something like what I said.  Libor, did I get the explanation right?

 - R.
