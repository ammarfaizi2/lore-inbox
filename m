Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267226AbUHDCS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267226AbUHDCS6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 22:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267218AbUHDCS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 22:18:58 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:51121 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267226AbUHDCSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 22:18:50 -0400
Date: Wed, 4 Aug 2004 04:18:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, Arjan van de Ven <arjanv@redhat.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040804021824.GU2241@dualathlon.random>
References: <20040803221121.GN2241@dualathlon.random> <Pine.LNX.4.44.0408032120570.5948-100000@dhcp83-102.boston.redhat.com> <20040804015350.GS2241@dualathlon.random> <20040803190730.A1924@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040803190730.A1924@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2004 at 07:07:30PM -0700, Chris Wright wrote:
> I think it's no different from current behaviour.  Which for fs based
> allocations is only guarded by fsuid and max_huge_pages.

sorry, what does prevent people from creating a 2M file, filling it with
pagefaults, closing creating another one and so on? Either "this"
accounting is applied to hugetlb files too or it's insecure.

Now if they didn't change the creation of the hugetlb files to be
allowed if the rlimit is !=0 then it wouldn't be insecure, but they
changed that in the first patch.

could you post a final patch once you're ready so that I will apply and
verify that I can exploit it? If it doesn't break it'll be still messed
up w.r.t. chown semantics (a true quota would get that right).
