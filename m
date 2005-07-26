Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVGZIP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVGZIP6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVGZIP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:15:58 -0400
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:39008 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261167AbVGZIP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:15:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=ZZqJtTcMia8u18MxyCnrSLU+0rCUcjgYZtVazIzYugKHFSTxB/RUF50bu+w33ZYZnXpycqsO+yuOwkkk/5HovVo8yBQTVBQ3GOMhC8V9GBvjVyMn96Id6QLIMRTDlXjYo4PjG4vA7eOk42j1B0EcMXkdxL1Ss5qDz759EPriLUA=  ;
Message-ID: <42E5F139.70002@yahoo.com.au>
Date: Tue, 26 Jul 2005 18:15:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch 0/6] remove PageReserved
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

If you're feeling like -mm is getting too stable, then you might
consider giving these patches a spin? (unless anyone else raises
an objection).

Ben thought I should get moving with them soon.

Not much change from last time. A bit of ppc64 input from Ben,
and some rmap.c input from Hugh. Boots and runs on a few machines
I have lying around here.

The only remaining places that *test* PageReserved are swsusp, a
trivial useage in drivers/char/agp/amd64-agp.c, and arch/ code.

Most of the arch code is just reserved memory reporting, which
isn't very interesting and could easily be removed. Some arch users
are a bit more subtle, however they *should not* break, because all
the places that set and clear PageReserved are basically intact.

We can phase PageReserved out of the tree completely when the core
becomes stable.

Now the main problems we might have are the introduction of some
tighter checks introduced by this patchset - for example 'bad_page'
is triggered on PG_reserved.

The other thing is - MAP_PRIVATE of VM_RESERVED regions becomes
disallowed. Any program that attempts such a thing prints a warning.
Hugh has some code which handles this case but he suggested that we
should first see whether it is even required.

Any thoughts? Comments?

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
