Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTGAMZR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 08:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTGAMZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 08:25:17 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:53122 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262290AbTGAMZN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 08:25:13 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16129.33029.930495.661244@laputa.namesys.com>
Date: Tue, 1 Jul 2003 16:39:33 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm2
In-Reply-To: <20030701110858.GF26348@holomorphy.com>
References: <20030701105134.GE26348@holomorphy.com>
	<Pine.LNX.4.44.0307011202550.1217-100000@localhost.localdomain>
	<20030701110858.GF26348@holomorphy.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
X-Drdoom-Fodder: security CERT crypt crash root
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Tue, 1 Jul 2003, William Lee Irwin III wrote:
 > >> Well, I was mostly looking for getting handed back 0 when lowmem is
 > >> empty; I actually did realize they didn't give entirely accurate counts
 > >> of free lowmem pages.
 > 
 > On Tue, Jul 01, 2003 at 12:08:03PM +0100, Hugh Dickins wrote:
 > > I'm not pleading for complete accuracy, but nr_free_buffer_pages()
 > > will never hand back 0 (if your system managed to boot).
 > > It's a static count of present_pages (adjusted), not of
 > > free pages.  Or am I misreading nr_free_zone_pages()?
 > 
 > You're right. Wow, that's even more worse than I suspected.
 > 

Another thing is that if one boots with mem=X, nr_free_pagecache_pages()
returns X. However part of X (occupied by kernel image, etc) is not part
of any zone. As a result, zone actually contains fewer pages than
reported by nr_free_pagecache_pages(). With X small enough (comparable
with kernel image size, for example) this can confuse
balance_dirty_pages() enough so that throttling would never start, and
VM will oom_kill().

 > 
 > -- wli

Nikita.
