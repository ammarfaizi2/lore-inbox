Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSFPQfj>; Sun, 16 Jun 2002 12:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316355AbSFPQfj>; Sun, 16 Jun 2002 12:35:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11655 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316339AbSFPQfh>; Sun, 16 Jun 2002 12:35:37 -0400
Date: Sun, 16 Jun 2002 17:35:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Kevin Easton <s3159795@student.anu.edu.au>
cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <20020616143507.A30647@beernut.flames.org.au>
Message-ID: <Pine.LNX.4.21.0206161534430.1150-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Jun 2002, Kevin Easton wrote:
> 
> So... the difference on i386 is just the definitions of the protection_map
> entries that are used.. specifically that PAGE_SHARED in asm-i386/pgtable.h
> includes _PAGE_RW? Changing this definition to be the same as the PAGE_COPY
> definition would be one fix?

It _could_ be _part_ of a fix (to the "problem" of dirty unbacked
pages arriving unheralded at the filesystem, too late to find
space for them; but our reluctance to have read faults allocate).

I say "could" because it would tend to cause double (read then write)
faulting more widely than necessary; I say "part" because at present
do_wp_page expects to be handling private Copy-On-Write faults rather
than shared mappings (please correct me if I'm wrong, Russell); and
we would still need to implement a callout down to the filesystem
(e.g. "wppage" method I suggested) to allocate the space (though,
doing it on the cheap, that method could be "nopage" revisited).

And I put quotes around "problem" because I'm uncertain how seriously
to take it, and we've had no chorus of anxious developers and users.

Hugh

