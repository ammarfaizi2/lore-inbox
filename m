Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266753AbUITTaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266753AbUITTaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUITTaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:30:16 -0400
Received: from zero.aec.at ([193.170.194.10]:60166 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S266753AbUITTaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:30:11 -0400
To: Terence Ripperda <tripperda@nvidia.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
References: <2F1dX-2r9-5@gated-at.bofh.it> <2F7VJ-7o7-7@gated-at.bofh.it>
	<2F8fj-7yw-39@gated-at.bofh.it> <2F8oL-7DK-1@gated-at.bofh.it>
	<2F8oR-7DK-17@gated-at.bofh.it> <2FwKr-7VO-7@gated-at.bofh.it>
	<2GAsE-21G-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Mon, 20 Sep 2004 21:30:07 +0200
In-Reply-To: <2GAsE-21G-9@gated-at.bofh.it> (Terence Ripperda's message of
 "Mon, 20 Sep 2004 19:50:08 +0200")
Message-ID: <m3brg0yc00.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda <tripperda@nvidia.com> writes:

> this is some ugly code. we're doing a lookup on a physical address to
> see if this is memory we previously allocated and returning a kernel
> pointer to the page.
>
> the particular snippet in question (that uses MAXMEM) is an ugly attempt
> to verify the address is a real physical address, before using __va()
> on something like an i/o region. A better approach than comparing
> MAXMEM would probably be to convert the address to a mapnr and compare
> to max_mapnr.

pfn_valid() is intended for that. However it cannot work 
when you have more than 4GB memory and IO memory holes below 4GB.
Testing the reserved bit of the struct page * may work in
that case, although it can give false positives when you try
this with random memory (some people set reserved on real memory
for other reason) 

-Andi

