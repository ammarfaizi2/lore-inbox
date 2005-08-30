Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVH3Ae5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVH3Ae5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 20:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbVH3Ae4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 20:34:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43229 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751432AbVH3Ae4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 20:34:56 -0400
Date: Mon, 29 Aug 2005 17:34:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ray Fucillo <fucillo@intersystems.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Rik van Riel <riel@redhat.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <43139B62.7010502@intersystems.com>
Message-ID: <Pine.LNX.4.58.0508291725160.3243@g5.osdl.org>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
 <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
 <430E6FD4.9060102@yahoo.com.au> <Pine.LNX.4.58.0508252055370.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261220230.4697@goblin.wat.veritas.com>
 <Pine.LNX.4.58.0508261052330.3317@g5.osdl.org>
 <Pine.LNX.4.61.0508261917360.8477@goblin.wat.veritas.com>
 <Pine.LNX.4.63.0508261910080.8057@cuia.boston.redhat.com>
 <Pine.LNX.4.58.0508261621410.3317@g5.osdl.org> <43108136.1000102@yahoo.com.au>
 <Pine.LNX.4.61.0508280500450.3323@goblin.wat.veritas.com> <43115E67.1050305@yahoo.com.au>
 <43139B62.7010502@intersystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Aug 2005, Ray Fucillo wrote:
> 
> FWIW, an interesting side effect of this occurs when I run the database 
> with this patch internally on a Linux server that uses NIS.  Its an 
> unrelated problem and not a kernel problem.  Its due to the children 
> calling initgroups()...  apparently when you have many processes making 
> simultaneous initgroups() calls something starts imposing very long 
> waits in increments of 3 seconds

Sounds like something is backing off by waiting for three seconds whenever
some lock failure occurs. I don't see what locking the code might want to
do (it should just do the NIS equivalent of reading /etc/groups and do a
"setgroups()" system call), but I assume that the NIS server ends up
having some strange locking.

You might do an "ltrace testcase" (and, probably, the nis server) to see
if you can see where it happens, and bug the appropriate maintainers.
Especially if you have a repeatable test-case (where "repeatable" isn't
just for your particular machine: it's probably timing-related), somebody
might even fix it ;)

		Linus
