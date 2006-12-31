Return-Path: <linux-kernel-owner+w=401wt.eu-S933158AbWLaMZd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933158AbWLaMZd (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 07:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933157AbWLaMZd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 07:25:33 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:40225 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933154AbWLaMZc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 07:25:32 -0500
To: rmk+lkml@arm.linux.org.uk
CC: davem@davemloft.net, arjan@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
In-reply-to: <20061231100007.GC1702@flint.arm.linux.org.uk> (message from
	Russell King on Sun, 31 Dec 2006 10:00:07 +0000)
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
References: <20061230.212338.92583434.davem@davemloft.net> <20061231092318.GA1702@flint.arm.linux.org.uk> <1167557242.20929.647.camel@laptopd505.fenrus.org> <20061231.014756.112264804.davem@davemloft.net> <20061231100007.GC1702@flint.arm.linux.org.uk>
Message-Id: <E1H0zkD-0003uw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 31 Dec 2006 13:24:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm willing to do that - and I guess this means we can probably do this
> instead of walking the list of VMAs for the shared mapping, thereby
> hitting both anonymous and shared mappings with the same code?

But for the get_user_pages() case there's no point, is there?  The VMA
and the virtual address is already available, so trying to find it
again through RMAP doesn't much make sense.

Users of get_user_pages() don't care about any other mappings (maybe
ptrace does, I don't know) only about one single user mapping and one
kernel mapping.

So using flush_dcache_page() there is an overkill, trying to teach it
about anonymous pages is not the real solution, flush_dcache_page()
was never meant to be used on anything but file mapped pages.

Miklos
