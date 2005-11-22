Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVKVEXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVKVEXF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 23:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVKVEXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 23:23:05 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:50062 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S932193AbVKVEXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 23:23:04 -0500
Date: Tue, 22 Nov 2005 12:24:43 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] properly account readahead file major faults
Message-ID: <20051122042443.GA4588@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>, akpm@osdl.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20051121140038.GA27349@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121140038.GA27349@logos.cnet>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 21, 2005 at 12:00:38PM -0200, Marcelo Tosatti wrote:
> Hi,
> 
> The fault accounting of filemap_dopage() is currently unable to account
> for readahead pages as major faults.

Sorry, I don't know much about the definition of major/minor page faults.
So I googled one that explains the old behavior:

--> Page Faults <--
These come in two varieties. Minor and Major faults. A Major fault results
when an application tries to access a memory page that has been swapped out to
disk. The page must be swapped back in. A Minor fault results when an
application tries to access a memory page that is still in memory, but the
physical location of which is not immediately known. The address must be
looked up.

With the current accounting logic:
- major faults reflect the times one has to wait for real I/O.
- the more success read-ahead, the less major faults.
- anyway, major+minor faults remain the same for the same benchmark.

With your patch:
- major faults are expected to remain the same with whatever read-ahead.
- but what's the new meaning of minor faults?

Thanks,
Wu
