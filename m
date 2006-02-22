Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWBVCcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWBVCcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 21:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWBVCcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 21:32:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19086 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422648AbWBVCcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 21:32:05 -0500
Date: Tue, 21 Feb 2006 18:30:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: torvalds@osdl.org, ak@suse.de, holt@sgi.com, bcasavan@sgi.com, cr@sap.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs: fix mount mpol nodelist parsing
Message-Id: <20060221183004.72ffa011.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0602212341160.5390@goblin.wat.veritas.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> Move the mpol= parsing to shmem_parse_mpol under CONFIG_NUMA, reject
>  all its options as invalid if not NUMA.

That's a bit irritating, really.  It means that userspace needs to be
different for NUMA kernels (or more different, which is still bad).  Boot
into a non-NUMA kernel and whoops, no tmpfs and quite possibly no boot.

But last time I whined about this Albert had a list of fairly
reasonable-sounding reasons why filesystems shouldn't silently accept
not-understood options.

But in this case, we _do_ understand them.  We're just not going to do
anything about them.

I just wonder if we're being as friendly as we possibly can be to admins
and distro-makers.

[ Vaguely suprised that tmpfs isn't using match_token()... ]
