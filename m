Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSCTU05>; Wed, 20 Mar 2002 15:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312139AbSCTU0r>; Wed, 20 Mar 2002 15:26:47 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24923 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312136AbSCTU0l>; Wed, 20 Mar 2002 15:26:41 -0500
Date: Wed, 20 Mar 2002 21:26:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Hugh Dickins <hugh@veritas.com>, Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et al
Message-ID: <20020320212620.N4268@dualathlon.random>
In-Reply-To: <127930000.1016651345@flay> <Pine.LNX.4.44L.0203201635570.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 04:36:48PM -0300, Rik van Riel wrote:
> On Wed, 20 Mar 2002, Martin J. Bligh wrote:
> 
> > This, unfortunately, isn't a total solution - we may sometimes need to
> > modify the task's pagetables from outside the process context, eg.
> > swapout (thanks to dmc for pointing this out to me ;-)). For this, we'd
> > just use the existing kmap mechanism to create another mapping to use
> > temporarily, and we're no worse off than before. But on the whole I
> > think it wins us enough to be worthwhile.
> 
> There is absolutely no problem mapping the page tables of
> another process into our own kmap space. It's just like

I thought he's talking about kswapd and friends, they all should keep
using the atomic kmaps for that, no problem there because we'll never
run copy-users from kswapd, kswapd doesn't have userspace to copy to :).

Andrea
