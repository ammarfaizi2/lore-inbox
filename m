Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312146AbSCTUf5>; Wed, 20 Mar 2002 15:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312147AbSCTUfr>; Wed, 20 Mar 2002 15:35:47 -0500
Received: from imladris.infradead.org ([194.205.184.45]:19213 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S312146AbSCTUfm>;
	Wed, 20 Mar 2002 15:35:42 -0500
Date: Wed, 20 Mar 2002 20:35:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Rik van Riel <riel@conectiva.com.br>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320203520.A2003@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Hugh Dickins <hugh@veritas.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Dave McCracken <dmccr@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <127930000.1016651345@flay> <20020320212341.M4268@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 09:23:41PM +0100, Andrea Arcangeli wrote:
> we need to walk pagetables not just from the current task and mapping
> pagetables there would decrase the user address space too much.

Who sais it should be taken from user address space?
For example openunix takes a small (I think 4MB) part of the normal KVA
to be per-process mapped.

> I think you're missing the problem with mainline. There is no shortage
> of virtual address space, there is a shortage of physical ram in the
> zone normal. So we cannot keep them in zone normal (and there's no such
> thing as "mapping in zone_normal"). Maybe I misunderstood what you were
> saying.

The problem is not the 4GB ZONE_NORMAL but the ~1GB KVA space.
UnixWare/OpenUnix had huge problems getting all kernel structs for managing
16GB virtual into that - on the other hand their struct page is more
then twice as big as ours..

