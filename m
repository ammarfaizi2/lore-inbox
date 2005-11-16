Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbVKPNAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbVKPNAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVKPNAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:00:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:1967 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030307AbVKPNAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:00:40 -0500
Date: Wed, 16 Nov 2005 07:00:24 -0600
From: Robin Holt <holt@sgi.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-mm@kvack.org,
       Andy Whitcroft <apw@shadowen.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: pfn_to_nid under CONFIG_SPARSEMEM and CONFIG_NUMA
Message-ID: <20051116130024.GD4573@lnx-holt.americas.sgi.com>
References: <20051115221003.GA2160@w-mikek2.ibm.com> <20051116115548.EE18.Y-GOTO@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116115548.EE18.Y-GOTO@jp.fujitsu.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 12:14:18PM +0900, Yasunori Goto wrote:
> static inline int pfn_to_nid(unsigned long pfn)
> {
> 	return page_to_nid(pfn_to_page(pfn));

But that does not work if the pfn points to something which does not
have a struct page behind it (uncached memory on ia64 for instance).
At the very least you would need to ensure pfn_to_page returns a  struct
page * before continuing blindly.

> page_to_nid() and pfn_to_page() is well defined.
> Probably, this will work on all architecture.
> So, just we should check this should be used after that memmap
> is initialized.

Robin
