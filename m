Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbUJZDUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbUJZDUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbUJZCyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 22:54:06 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:15851 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262079AbUJZB51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:57:27 -0400
Date: Tue, 26 Oct 2004 03:58:25 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: lowmem_reserve (replaces protection)
Message-ID: <20041026015825.GU14325@dualathlon.random>
References: <20041025170128.GF14325@dualathlon.random> <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410252147330.30224-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 09:48:25PM -0400, Rik van Riel wrote:
> On Mon, 25 Oct 2004, Andrea Arcangeli wrote:
> 
> > This is a forward port to 2.6 CVS of the lowmem_reserve VM feature in
> > the 2.4 kernel.
> > 
> > 	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.9/lowmem_reserve-1
> 
> -       unsigned long           protection[MAX_NR_ZONES];
> +       unsigned long           lowmem_reserve[MAX_NR_ZONES];
> 
> The gratituous renaming of variable and function names makes
> it hard to see what this patch actually changed.  Hard enough
> that I'm not sure what the behavioural difference is supposed
> to be.

the behavioural difference is the API and the fact the feaure is now
enabled with sane values (the previous code was disabled by default and
it was unusable with that API). besides fixing the API the patch nukes
dozens of useless lines of code and a buffer overflow.  The sysctl
definitely needs renaming or it'd break the ABI with userspace, it's far
from a gratituous rename. since I was foroced to change the sysctl name
accordingly with the new 2.4 API, I thought renaming the variable that
is set by the sysctl was also required, otherwise the sysctl is called
lowmem_reserve and the variable is still called protection. Clearly it's
much cleaner if _both_ sysctl and variable are called lowmem_reserve.

I could have used protection2 to still use the "protection" name, but
lowmem_reserve (btw, the same name I used first in 2.4, before
protection ever existed in 2.6) looks nicer to me.
