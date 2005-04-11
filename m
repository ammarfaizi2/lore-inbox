Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVDKS2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVDKS2E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVDKS2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:28:04 -0400
Received: from webmail.topspin.com ([12.162.17.3]:1779 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261869AbVDKS2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:28:01 -0400
To: Troy Benjegerdes <hozer@hozed.org>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 11 Apr 2005 11:03:08 -0700
In-Reply-To: <20050411180107.GF26127@kalmia.hozed.org> (Troy Benjegerdes's
 message of "Mon, 11 Apr 2005 13:01:08 -0500")
Message-ID: <52oeclyyw3.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Apr 2005 18:03:08.0541 (UTC) FILETIME=[B7A1E2D0:01C53EC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Troy> Do we even need the mlock in userspace then?

Yes, because the kernel may go through and unmap pages from userspace
while trying to swap.  Since we have the page locked in the kernel,
the physical page won't go anywhere, but userspace might end up with a
different page mapped at the same virtual address.

 - R.
