Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267575AbUG3CJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267575AbUG3CJe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 22:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUG3CJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 22:09:34 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:11656 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267575AbUG3CJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 22:09:33 -0400
Date: Fri, 30 Jul 2004 04:09:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Wright <chrisw@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
       riel@redhat.com, akpm@osdl.org
Subject: Re: [patch] mlock-as-nonroot revisted
Message-ID: <20040730020910.GA30369@dualathlon.random>
References: <20040729100307.GA23571@devserv.devel.redhat.com> <20040729185215.Q1973@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040729185215.Q1973@build.pdx.osdl.net>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 06:52:15PM -0700, Chris Wright wrote:
> 1) hugetlb accounting is not done. so it's only simple change to checking
> permission, but the acutal usage is not tracked (gets back to problem
> andrea pointed out).  with this patch, wouldn't !capable(CAP_IPC_LOCK)
> && rlim[RLIMIT_MEMLOCK].rlim_cur == 1 be enough to get all the hugepages
> a user would want (i.e. security hole)?

exactly, you beaten me on reply-speed ;).

And this patch is needed primarly to get access to hugetlbfs without
IPC_CAP_LOCK as Arjan mentioned.

> I do agree, however, that storing in user struct allows for quota like
> accounting that matches the shm_lock and hugetlb use cases.

Looking forward to see hugetlbfs working with user quota too...
rlimit user-quota is certainly a reasonable approach, though I'm not
sure what happens if root runs chown, that's funny not? Comments?
