Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264223AbUFVOsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264223AbUFVOsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 10:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUFVOrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 10:47:08 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:30168 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264223AbUFVOiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 10:38:25 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrea Arcangeli <andrea@suse.de>
Date: Tue, 22 Jun 2004 16:38:15 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Stop the Linux kernel madness
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <A095D7F069C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jun 04 at 4:06, Andrea Arcangeli wrote:

> To make the last recent example we had to break the source API with the
> drivers to fix the release_pages race that Andrew found and fixed in
> mainline too. That changes page->count into page->_count and quite some
> drivers broke even outside the kernel. I had the choice of not breaking

FYI, vmware modules broke during your change because 2.4.20-xx kernels from 
RedHat moved page_count() from linux/mm.h to linux/mm_inline.h, and made 
it unavailable for non-GPL modules. So we had to do

#ifndef page_count
#define page_count(p) (p)->count
#endif

and this #ifndef test was broken by making page_count inline function.

But I'd like to publicly thank you for your effort, I really appreciate
it.
                                                Best regards,
                                                    Petr Vandrovec

