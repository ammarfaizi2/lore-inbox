Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263299AbUCRXWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263313AbUCRXVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:21:50 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35715
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263299AbUCRXJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:09:00 -0500
Date: Fri, 19 Mar 2004 00:09:50 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040318230950.GB2050@dualathlon.random>
References: <20040318221447.GA3248@dualathlon.random> <Pine.LNX.4.44.0403182234090.16863-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403182234090.16863-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:37:55PM +0000, Hugh Dickins wrote:
> On Thu, 18 Mar 2004, Andrea Arcangeli wrote:
> > 
> > The fix is simple: always set and clear PG_anon under the page_map_lock,
> > this will avoid the race since all ClearPageAnon already runs under the
> > page_map_lock. I will implement and test in a few hours.
> > 
> > ... I find this more robust.
> 
> Absolutely, that's what I did too.  My old page_add_rmap had anon flag,
> but the new patches have page_add_anon_rmap and page_add_obj_rmap.

I remebered you had the anon param too, though I didn't realize it was
for this reason :/

the reason why I go with the parameter is that sometime I've a single
call at the end of the function with the same new_page, but sometime
it has to be considered anonymous sometime not. So I couldn't split out
the interface with _anon/_file suffixes with some #define and remove the
0/1 numbering ugliness.
