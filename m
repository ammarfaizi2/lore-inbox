Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269561AbUIZPlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269561AbUIZPlr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 11:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269567AbUIZPlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 11:41:47 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:60589 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S269561AbUIZPlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 11:41:45 -0400
Date: Sun, 26 Sep 2004 17:41:37 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all	set_pte must be written in asm
Message-ID: <20040926154137.GW3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random> <1096155207.475.40.camel@gaston> <20040926002037.GP3309@dualathlon.random> <1096159487.18234.64.camel@gaston> <228130000.1096209711@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <228130000.1096209711@[10.10.2.4]>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 26, 2004 at 07:41:52AM -0700, Martin J. Bligh wrote:
> Wouldn't it make sense to call set_pte_atomic, and just have that resolve
> to set_pte on 90% of arches? (I'm ignoring the wierdo compiler issue here,
> this is just for arches with pte > long). 

I also like this more, since it betters defines that set_pte really
cannot be called on an established pte in common code [i.e. the bug
triggering on x86] (and asm-generic is common code).
