Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271038AbUJUWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271038AbUJUWlf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271041AbUJUWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:40:11 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:28876 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S271038AbUJUWfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:35:31 -0400
Date: Fri, 22 Oct 2004 00:36:13 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] zap_pte_range should not mark non-uptodate pages dirty
Message-ID: <20041021223613.GA8756@dualathlon.random>
References: <1098393346.7157.112.camel@localhost> <20041021144531.22dd0d54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021144531.22dd0d54.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 02:45:31PM -0700, Andrew Morton wrote:
> Maybe we should revisit invalidate_inode_pages2().  It used to be an
> invariant that "pages which are mapped into process address space are
> always uptodate".  We broke that (good) invariant and we're now seeing
> some fallout.  There may be more.

such invariant doesn't exists since 2.4.10. There's no way to get mmaps
reload data from disk without breaking such an invariant. It's not even
for the write side, it's buffered read against O_DIRECT write that
requires breaking such invariant.

Either you fix it the above way, or you remove the BUG() in pdflush and
you simply clear the dirty bit without doing anything, both are fine,
peraphs we should do both, but the above is good to have anyways since
it's more efficient to not even show the not uptodate pages to pdflush.
