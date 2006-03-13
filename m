Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWCMOtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWCMOtg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 09:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751406AbWCMOtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 09:49:36 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:38883 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1751361AbWCMOtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 09:49:35 -0500
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.de>,
       netdev@vger.kernel.org, Dean Nelson <dcn@sgi.com>
Subject: Re: kmalloc_node returns unaligned memory
References: <20060313144513.GA9542@suse.de>
From: Jes Sorensen <jes@sgi.com>
Date: 13 Mar 2006 09:49:34 -0500
In-Reply-To: <20060313144513.GA9542@suse.de>
Message-ID: <yq0y7zev1q9.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Olaf" == Olaf Hering <olh@suse.de> writes:

Olaf> kmalloc_node returns unaligned pointers on powerpc, when
Olaf> CONFIG_DEBUG_SLAB is enabled. This makes iptables very
Olaf> unhappy. It checks the alignment in
Olaf> net/ipv6/netfilter/ip6_tables.c:check_entry_size_and_hooks().
Olaf> __alignof__(struct ip6t_entry) returns 8. But returned pointers
Olaf> from xt_alloc_table_info() are unaligned:

Hi Olaf,

I believe this is expected behavior ;-(

We have the same problem with the XPC driver for the SN2 which resulted
in a wrapper macro being created for it.

Some sort of SLAB_HWCACHE_ALIGN flag to Slab that was always respected
for this would be nice.

Cheers,
Jes
