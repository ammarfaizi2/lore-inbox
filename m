Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbUK2Lkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbUK2Lkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 06:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUK2Lkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 06:40:32 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:36008 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261678AbUK2LkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 06:40:23 -0500
X-Envelope-From: kraxel@bytesex.org
To: pawfen@wp.pl
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: MTRR vesafb and wrong X performance
References: <1101338139.1780.9.camel@PC3.dom.pl>
	<20041124171805.0586a5a1.akpm@osdl.org>
	<1101419803.1764.23.camel@PC3.dom.pl>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 29 Nov 2004 12:12:08 +0100
In-Reply-To: <1101419803.1764.23.camel@PC3.dom.pl>
Message-ID: <87is7ogb93.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pawel Fengler <pawfen@wp.pl> writes:

> > Please send the full dmesg output and the contents of /proc/mtrr for
> > 2.6.10-rc2.

> reg02: base=0xe3000000 (3632MB), size=   4MB: write-combining, count=1

> vesafb: framebuffer at 0xe3000000, mapped to 0xcc880000, using 1875k,
> total 4096k

The BIOS reports 4MB video memory, and vesafb adds an mtrr entry for
that.  Looks ok, with the exception that the reported 4MB are probably
not correct, otherwise the X-Server wouldn't complain.  vesafb in
2.6.10-rc2 has a option to overwrite the BIOS-reported value
(vtotal=n, with n in megabytes), that should fix it.

The reason that you don't see this with old kernels probably is just
that vesafb doesn't create mtrr entries by default in 2.4.x

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
