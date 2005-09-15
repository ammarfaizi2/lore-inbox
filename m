Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965203AbVIOH3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965203AbVIOH3d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 03:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVIOH3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 03:29:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965203AbVIOH3c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 03:29:32 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
X-Fcc: ~/Mail/linus
Cc: Sripathi Kodi <sripathik@in.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       patrics@interia.pl, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 2.6.13.1] Patch for invisible threads
In-Reply-To: Al Viro's message of  Thursday, 15 September 2005 03:12:36 +0100 <20050915021236.GA25261@ZenIV.linux.org.uk>
X-Shopping-List: (1) Dissident yies
   (2) Expeditious excitements
   (3) Seismic loads
   (4) Simultaneous belligerent battalions
   (5) Independent omnipresent bruisers
Message-Id: <20050915072906.A26D2180A18@magilla.sf.frob.com>
Date: Thu, 15 Sep 2005 00:29:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Among other things, it means that zombies keep pinning their root and cwd
> down, AFAICS.  Not Good(tm).

Good point.  The technique that looks for the first nonzombie in the group
to fetch its fs might be best if it's necessary to use fs for the
permission checks.  It should always find a winner on just one
iteration, or two or three in races, except for ptrace keeping zombie
threads alive (otherwise all zombies but the leader self-reap quickly).


Thanks,
Roland
