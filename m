Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263263AbTDVRXZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 13:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263264AbTDVRXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 13:23:25 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41824 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263263AbTDVRXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 13:23:24 -0400
Date: Tue, 22 Apr 2003 13:34:46 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       <mbligh@aracnet.com>, <mingo@elte.hu>, <hugh@veritas.com>,
       <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: objrmap and vmtruncate
In-Reply-To: <20030422165746.GK23320@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0304221324380.24424-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Andrea Arcangeli wrote:

> could we focus and solve the remap_file_pages current breakage first?

truncate always used to be such a PITA in the VM. And so few code depends
on it doing the right thing to vmas. Which i claim to not be the right
thing at all.

is anything forcing us to fixing up mappings during a truncate? What we
need is just for the FS to recognize pages behind end-of-inode to still
potentially exist after truncation, if those areas were mapped before the
truncation. Apps that do not keep uptodate with truncaters can get
out-of-date data anyway, via read()/write() anyway. Are there good
arguments to be this strict across truncate()? We sure could make it safe
even thought it's not safe currently.

	Ingo

