Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVKVSzF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVKVSzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 13:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965107AbVKVSzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 13:55:05 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:1742 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S965106AbVKVSzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 13:55:03 -0500
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, npiggin@suse.de
Subject: Re: PageReserved removal woes: vbetool, suspend-to-ram breakage
In-Reply-To: <20051111103808.GA22057@isilmar.linta.de>
References: <20051111103808.GA22057@isilmar.linta.de>
Date: Tue, 22 Nov 2005 18:54:57 +0000
Message-Id: <E1EedI9-0005O6-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Just wanted to let you know that the warning introduced in
> [PATCH] core remove PageReserved

It's not much of a warning, it seems to stop vbetool from working (which
may explain a few complaints about ACPI suspend being broken in 2.6.15 -
it's not, but vbetool is...)

vbetool (well, strictly it's LRMI, but...) needs to access real-mode
memory. On the other hand, it's probably a bad idea to let it actually
scribble over RAM that the kernel may be using. So
MAP_PRIVATE|PROT_WRITE seems to be the correct thing to do. This
certainly /seemed/ to work in older kernels, but doesn't any more. What
should I be doing instead?

(I'm also not quite sure why the error claims that it's deprecated,
whereas in fact it doesn't actually work at all. Breaking userspace
without warning isn't terribly nice)
-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
